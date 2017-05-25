

    $( document ).on('turbolinks:load', function() {

$.ajax({
   url: "/tasks/notify_assigned",
   type: "get",
   contentType: "application/json",
   success: function(data) {
       if (data==0){
        $('#noti_Counter').hide();
        $('#noti_Button').css('background-color', '#9d9d9d');

       }
       else {
       $('#noti_Counter').text(data);}
   },
   error: function(xhr, textStatus, error) {
   }
});



        
        $('#noti_Counter')
            .css({ opacity: 0 })
            .css({ top: '-10px' })
            .animate({ top: '-2px', opacity: 1 }, 500);
        
        $('#noti_Button').click(function () {

            $('#notifications').fadeToggle('fast', 'linear', function () {
                if ($('#notifications').is(':hidden')) {
                    $('#noti_Button').css('background-color', '#9d9d9d');
                }
                else $('#noti_Button').css('background-color', '#FFF');        // CHANGE BACKGROUND COLOR OF THE BUTTON.
            });

            $('#noti_Counter').fadeOut('slow');                 // HIDE THE COUNTER.

            if ($('#noti_Counter').text()>0){
              //alert("faccio update");

            $.post('/tasks/notified').success(function(data) {} );  
            $('#noti_Counter').text(0);
            } 
            return false;
        });

        // HIDE NOTIFICATIONS WHEN CLICKED ANYWHERE ON THE PAGE.
        $(document).click(function () {
            $('#notifications').hide();

            // CHECK IF NOTIFICATION COUNTER IS HIDDEN.
            if ($('#noti_Counter').is(':hidden')) {
                // CHANGE BACKGROUND COLOR OF THE BUTTON.
                $('#noti_Button').css('background-color', '#9d9d9d');
            }


        });

        $('#notifications').click(function () {
            return false;       // DO NOTHING WHEN CONTAINER IS CLICKED.
        });

        //});
        







    });