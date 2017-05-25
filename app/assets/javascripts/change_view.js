$( document ).on('turbolinks:load', function() {
  //funzione per ordine decrescente tabelle report
  { 
    $("#report_table,#report_table2").tablesorter( {
      sortInitialOrder: 'desc',
      sortList: [[1,1]],        
    } ); 
  } 
  //fine funzione per ordine decrescente tabelle report


  // cambiare visualizzazione task in base a "miei task, task assegnati, completati ecc ecc"
  var user_name;
  var deleted = [];
  var completed = [];


  function deleted_empty(arr) {
      $.each(arr, function(i, v) {
          $('#mytable').append(v);
      });            
  }

  //funzione per mostrare i task in base allo stato
  function check_status()
  {
    if($('#all_check').is( ':checked' ))
    {
      $('#opened_check').prop('checked', false);
      $('#closed_check').prop('checked', false);

      deleted_empty(deleted);
    }
    else
    {
      if ($('#closed_check').is( ':checked' ))
      {
        $('#opened_check').prop('checked', false);

        $("#mytable tr td#task_status:contains('" + false + "')").each(function() {
          deleted.push($(this).parent().detach());
          });
      }
    

      if ($('#opened_check').is( ':checked' ))
      {
        $('#closed_check').prop('checked', false);
        $("#mytable tr td#task_status:contains('" + true + "')").each(function() {
          deleted.push($(this).parent().detach());
          });
      }
    }
  }

  //chiamata ajax per avere l'username corrente da usare nella visualizzazione dei task assegnati o task propri 
  $.ajax({
     url: "/user/show",
     type: "get",
     contentType: "application/json",
     success: function(data) {
         user_name = data.username;
     },
     error: function(xhr, textStatus, error) {
       alert(xhr.statusText+" "+textStatus+" "+error);
     }
  });


  //funzione per vedere i task in base all'assegnazione o proprietà contemporaneamente allo stato
  $('select#view, #opened_check, #closed_check, #all_check').on('change', function() {
    if($('select#view').val() == "i tuoi task")
    {
      deleted_empty(deleted);
	    $("#mytable tr td#user_name_task:not(:contains('" + user_name + "'))").each(function() {
        deleted.push($(this).parent().detach());
        });
      check_status();
    }
    else if ($('select#view').val() == "visualizza tutti")
    {
        deleted_empty(deleted);
        check_status();
    }
    else if ($('select#view').val() == "task assegnati")
    {
      deleted_empty(deleted);
    	$("#mytable tr td#assignee_task:not(:contains('" + user_name + "'))").each(function() {
        deleted.push($(this).parent().detach());
        });
      check_status();
	 }
  });
})