class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :startTask]
  before_action :authenticate_user!
  respond_to :js, :json, :html
  

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @task = Task.new #aggiunto io per avere l'oggetto utile per "form"

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @tasks = Task.all
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    set_date
    set_category

    if (@task.value).include? "@"
      valore = @task.value
      initIndexAss = valore.index('@')
      finIndexAss = valore.index(' ');
      assegnatarioTMP = valore[initIndexAss + 1,finIndexAss -1]
      if User.exists?(:username => assegnatarioTMP)
        @task.assignee = valore[initIndexAss + 1,finIndexAss]
      else
        redirect_to tasks_url, notice: 'Assegnatario non presente. Riprova '
        return
      end
      @task.value = valore[finIndexAss + 1,valore.length]
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, :flash => { :success => "task creato Correttamente!" }}
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, :flash => { :alert => "Errore creazione task!" }}
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, :flash => { :success => "task modificato Correttamente!" }}
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, :flash => { :alert => "Errore modifica task!" } }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, :flash => { :success => "task eliminato Correttamente!" }}
      format.json { head :no_content }
    end
  end

  def complete
    @task.update_attribute(:completed, true)
    @task.update_attribute(:endDate, Time.now.getutc) #setto tempo fine task
    redirect_to tasks_url, :flash => { :success => "task completato!" }

  end

  def startTask
      @task.update_attribute(:startDate, Time.now.getutc) #setto tempo inizio task
      noti = "Tempo partito per "+@task.id.to_s
      redirect_to tasks_url, :flash => { :success => noti }
  end

  def notified
    Task.notified(current_user.username)
  end

  def notify_assigned
    
    @n_notifies =  Task.notify(current_user.username)
       respond_to do |format|
          format.json { render :json => @n_notifies }
             end
  
  end

  private 

  #date_of_next "Monday"
    #=>#<Date: 2011-10-31 (4911731/2,0,2299161)>
  #date_of_next "Sunday"
    #=>#<Date: 2011-10-30 (4911729/2,0,2299161)>

  def set_date
  
      if !@task.value.scan(/!(\w+)/)[0].nil? #se ! è impostato - 1f
          if @task.value.scan(/!(\w+)/)[0].join.to_s == "oggi" #se è oggi - 2if
             @task.date = DateTime.now
              value = @task.value.sub(/!(\w+)/, '')
              @task.value = value
        
          elsif @task.value.scan(/!(\w+)/)[0].join.to_s == "domani" #se è domani - 2if 
             @task.date = DateTime.now.tomorrow.to_date
              value = @task.value.sub(/!(\w+)/, '')
              @task.value = value
          

          else #altrimenti è una data in formato giorno.mese.data - 2if
            task_date = @task.value[/!([\d.]+)/, 1].split(".").map {|i| i.to_i}
            if task_date.size == 3 #giorno.mese.anno
              @task.date = Date.new(task_date[2],task_date[1],task_date[0]) #AMG
            elsif task_date.size == 2 #giorno.mese
                if task_date[1] < DateTime.now.month
                 year = Time.now.year+1
               else
                  year = Time.now.year
                end
               @task.date = Date.new(year,task_date[1],task_date[0])
            elsif task_date.size == 1 #giorno
              @task.date = Date.new(Time.now.year,Time.now.month,task_date[0])
            end
            value = @task.value.sub(/!([\d.]+)/, "")
            @task.value = value
          end
      else #se ! non è impostato allora salva la data di oggi - 1f
          @task.date = DateTime.now
          value = @task.value.sub(/!([\d.]+)/, "")
          @task.value = value

      end
  end

  def set_category
      #username = params[:assignee]
      #@task.assignee = username
      if !@task.value.scan(/#(\w+)/)[0].nil?
      @task.category = @task.value.scan(/#(\w+)/)[0].join
      value = @task.value.sub(/#(\w+)/, '')
      @task.value = value
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:value, :completed, :category, :date, :assignee)
  end
end
