//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//
$(document).ready(function() {
  $('body').on('blur', 'td.existing-value', function() {
    var changedAttribute = $(this).data('attribute');
    var newValue = $(this).html();
    var databaseName = $('.table-content table').data('database-name');
    var tableName = $('.table-content table').data('table-name');
    var rowId = $(this).siblings("td[data-attribute='id']").text();
    var url = '/pg/databases/' + databaseName + '/tables/' + tableName + '/records/' + rowId;

    var updateObject = {};
    updateObject['id'] = rowId;
    updateObject['record'] = tableName;
    updateObject['attributes'] = {}
    updateObject['table_id'] = tableName;

    updateObject['attributes'][changedAttribute] = newValue;

    $.ajax({
      data: updateObject,
      type: 'PUT',
      url: url
    });
  });

  // Attach listenr to action tabs
  $('body').on('click', '.action-tab', function(e) {
    $this = $(this)
    $('.action-tab').removeClass('active');
    $this.addClass('active');
    window.location.hash = $this.find('a').attr('href');
    e.preventDefault();
  });

  // Update tab styles
  $('a[href="'+window.location.hash+'"]').parent().addClass('active');
});
