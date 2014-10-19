//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//


// APPLICATION
$(document).ready(function() {

  $('body').on('blur', 'td.existing-value', function() {
    var newValue = $(this).text();
    var oldValue = $(this).data('current-value');

    if (newValue == oldValue) {
      return
    }

    var changedAttribute = $(this).data('attribute');
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
    }).fail(function() {
      $(this).text(oldValue);
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
  $('body').on('click', 'table.sql th', function(e) {
    $this = $(this);
    var sort = "DESC"
    var attribute = $(this).text();
    var downArrowClass = 'fa-caret-down'
    var upArrowClass = 'fa-caret-up'
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
    sortOptions.order = sort;
    sortOptions.attribute = attribute;
    e.preventDefault();
  });
});

// HELPERS
function insertParam(key, value) {
    key = escape(key); value = escape(value);

    var kvp = document.location.search.substr(1).split('&');
    if (kvp == '') {
        document.location.search = '?' + key + '=' + value;
    }
    else {

        var i = kvp.length; var x; while (i--) {
            x = kvp[i].split('=');

            if (x[0] == key) {
                x[1] = value;
                kvp[i] = x.join('=');
                break;
            }
        }

        if (i < 0) { kvp[kvp.length] = [key, value].join('='); }

        //this will reload the page, it's likely better to store this until finished
        document.location.search = kvp.join('&');
    }
}
