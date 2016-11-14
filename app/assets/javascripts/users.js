$(document).ready(function() {
    $('#daycalendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: ''
        },
        events: '/events.json',
        defaultView:'agendaDay',
        allDaySlot: false,
        dayClick: function(date, jsEvent, view) {
            clickedDate = date.format();
            query = '?clicked_date='+date.format();
            window.location.assign('events/new/' + query);
        }
    });
    var $signUpButton = $(".signup-button");

    $signUpButton.on("click", function(){
        $(this).fadeOut(150).queue(function(){
            $(".signup-form").slideToggle(300)
        })
    });

    if(document.cookie.indexOf("redirect_after_error") != -1){
        $signUpButton.click();
    }
});

