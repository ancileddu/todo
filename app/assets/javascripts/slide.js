//$(document).ready(function(){
	$( document ).on('turbolinks:load', function() {
    $(".closebtn").click(function(){
        $( ".overlay" ).toggle( "fold", 1000 );
    });
    })
//});