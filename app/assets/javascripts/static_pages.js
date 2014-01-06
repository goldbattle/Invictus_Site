$(document).ready(function() {
  // Highlight Download tooltip
  $('#download').tooltip({ placement : 'bottom', title: 'Installing MCPatcher or Optifine is Recommended'});
  // Revisions comment popup
  $('.comments').popover({html: true, placement: 'right', trigger: 'hover '})
  // Revisions date
  $('.commitdate').tooltip({ placement : 'left'})
});