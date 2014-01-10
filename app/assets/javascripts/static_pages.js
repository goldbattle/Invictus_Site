$(document).ready(function() {
  // Highlight Download tooltip
  $('#download').tooltip({ placement : 'bottom' });
  // Revisions comment popup
  $('.comments').popover({html: true, placement: 'right', trigger: 'hover '})
});