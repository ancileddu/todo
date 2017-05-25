$( document ).on('turbolinks:load', function() {

var username=[];   
var assignee="";
$.get('/user').success(function(data) { username = data;} );      

function split(val) {
    return val.split(/@\s*/);
}

function extractLast(term) {
    return split(term).pop();
}

$( '#details' ).on( 'click', '#remove', function () {
    var task = $('#task_value').val().replace(assignee,'');
    assignee="";
    $('#task_value').val(task);
    $("#details").empty();

});





$("#task_value")
// don't navigate away from the field on tab when selecting an item
.bind("keydown", function(event) {
    if (event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active) {
        event.preventDefault();
    }
}).autocomplete({
    minLength: 0,
    source: function(request, response) {
        var term = request.term,
        term = request.term,
            results = [];
        if (term.indexOf("@") >= 0) {
            
            term = extractLast(request.term);
            if (term.length > 0) {
                results = $.ui.autocomplete.filter(
                username, term);
            }
        }
        response(results);
    },
    focus: function() {
        // prevent value inserted on focus
        return false;
    },
    select: function(event, ui) {
        var terms = split(this.value);
        // remove the current input
        terms.pop();
        // add the selected item
        terms.push(ui.item.value);
        // add placeholder to get the comma-and-space at the end
        terms.push("");
        this.value = terms.join("");
        assignee = ui.item.value;

        
        //add the html to an element
      $('#details').html("assegna task a: <span id='assignee'> " + assignee + "</span><span id='remove' class='glyphicon glyphicon-remove' aria-hidden='true'></span>");


        return false;
    }
});





//prendo il valore del task, mando il valore (selezionato prima nella lista) come "assignee" e lo tolgo dalla stringa task. Mando anche tutto il value del task
$( "#new_task" ).submit(function(event) {
event.preventDefault();
    var value = $('#task_value').val().replace(assignee,'');
value.replace(/&nbsp;/g,'');

 $.ajax({
   url: "/tasks",
   type: "post",
   contentType: "application/json",
   
   data: JSON.stringify({ task: { assignee: assignee, value: value } }),
   success: function(data) {
   },
   error: function(xhr, textStatus, error) {
     alert(xhr.statusText+" "+textStatus+" "+error);
   }
});

});



})
