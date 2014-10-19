//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//


// APPLICATION
$(document).ready(function() {

  // Show hidden table row for inputing new database row
  $('body').on('click', 'li.add-row', function() {
    var rowCopy = $('.new-row').clone();
    $('.table-content tbody').prepend(rowCopy);
    rowCopy.removeClass('hidden new-row').addClass('empty-row');
    $(document).scrollTop(0);
  });

  // Create new table row
  $('body').on('click', '.create-row', function() {
    var databaseName = $('.table-content table').data('database-name');
    var tableName = $('.table-content table').attr('data-table-name');
    var url = '/pg/databases/' + databaseName + '/tables/' + tableName + '/records/';
    var tableRow = $(this).closest('tr');

    $tableColumns = $(this).siblings();

    rowObject = {};
    rowObject['attributes'] = {};

    $.each($tableColumns, function(index, row) {
      var rowName = $(row).attr('data-attribute');
      var rowValue = $(row).text();

      if (rowValue.length != 0) {
        rowObject['attributes'][rowName] = rowValue;
      }
    });

    $.ajax({
      data: rowObject,
      type: 'POST',
      url: url
    }).done(function() {
      $('.footer .errors').empty().removeClass('alert-danger');
      $(".footer .errors").addClass("alert-success");
      $(".footer .errors").append('<p>Table entry successfully created.</p>')
    }).fail(function() {
      tableRow.addClass('flash red-green-out');
      setTimeout(function() {
        tableRow.removeClass('flash red-green-out');
      }, 1000);
    });
  });

  // Update attribute on edit form
  $('body').on('blur', 'td.existing-value', function() {
    var newValue = $(this).text();
    var oldValue = $(this).attr('data-current-value');

    if (newValue == oldValue) {
      return
    }

    $this = $(this);

    var changedAttribute = $(this).attr('data-attribute');
    var databaseName = $('.table-content table').data('database-name');
    var tableName = $('.table-content table').attr('data-table-name');
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
    }).fail(function() {
      $this.addClass('flash red-out');
      $this.text(oldValue);
      setTimeout(function() {
        $this.removeClass('flash red-out');
      }, 1000);
    }).done(function() {
      $this.data('current-value', oldValue);
      $this.addClass('flash green-out');
      setTimeout(function() {
        $this.removeClass('flash green-out');
      }, 1000);
    });
  });

  // Delete table row
  $('body').on('click', 'td.action.delete', function() {
    var $tableRow = $(this).closest('tr');
    var tableRowId = $tableRow.attr('data-row-id');
    var tableName = $('.table-content table').attr('data-table-name');
    var databaseName = $('.table-content table').attr('data-database-name');

    var deleteObject = {}
    deleteObject['table_id'] = tableName;
    deleteObject['id'] = tableRowId;

    var url = '/pg/databases/' + databaseName + '/tables/' + tableName + '/records/' + tableRowId;

    $.ajax({
      data: deleteObject,
      type: 'DELETE',
      url: url
    }).fail(function() {
      $tableRow.addClass('flash red-out');
      setTimeout(function() {
        $tableRow.removeClass('flash red-out');
      }, 900);
    }).done(function() {
      $tableRow.addClass('flash red-out');
      setTimeout(function() {
        $tableRow.hide('fast');
      }, 900);
    })
  });

  // Attach listenr to action tabs
  $('body').on('click', '.action-tab', function(e) {
    $this = $(this)
    $link = $this.find('a');
    $('.action-tab').removeClass('active');
    $this.addClass('active');
    window.location.hash = $link.attr('href');
    $targetTab = $($link.attr("data-target"));
    if ($targetTab.length != 0) {
      $('.tab-content .tab-pane').removeClass('active');
      $targetTab.addClass('active');
    }
    e.preventDefault();
  });

  // Update tab styles
  if (window.location.hash.length == 0) window.location.hash = "#content";
  $('a[href="'+window.location.hash+'"]').parent().click();

});

