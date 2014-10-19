function sortTableByColumn(databse_name, table_name, table_column, order) {
  // TODO: Implement AJAX call
  $.ajax({
    data: { sort: order, table_column: table_column },
    type: 'POST',
    url: "???"
  });
}