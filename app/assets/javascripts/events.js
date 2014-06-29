
$(document).ready(function() {

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',

            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        events: '/events.json',
        allDaySlot:false,
        dayClick: function(date, jsEvent, view) {
             clickedDate = date.format();
             query = '?clicked_date='+date.format();
             window.location.assign('events/new/' + query);
        }

    });

});

