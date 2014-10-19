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
    $link = $this.find('a');
    $('.action-tab').removeClass('active');
    $this.addClass('active');
    window.location.hash = $link.attr('href');
    $targetTab = $($link.data("target"));
    if ($targetTab.length != 0) {
      $('.tab-content .tab-pane').removeClass('active');
      $targetTab.addClass('active');
    }
    e.preventDefault();
  });

  // Update tab styles
  if (window.location.hash.length == 0) window.location.hash = "#content";
  $('a[href="'+window.location.hash+'"]').parent().click();

  // Sorting
  $('body').on('click', 'table.sql th', function() {
    var sort = "DESC"
    var downArrowClass = 'fa-caret-down'
    var upArrowClass = 'fa-caret-up'
    $this = $(this);
    $arrow = $this.find('.fa')
    if ($arrow.length != 0) {
      if ($arrow.hasClass(downArrowClass)) {
        sort = "ASC";
        $arrow.removeClass(downArrowClass);
        $arrow.addClass(upArrowClass);
      } else {
        sort = null;
        $arrow.remove();
      }
    } else {
      $this.prepend('<i class="fa '+downArrowClass+'"></i>');
    }
    // TODO: Attach AJAX call
  });
});
