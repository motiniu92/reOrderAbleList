import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'order.dart';

class OrderDataSource extends DataGridSource {
  List<DataGridRow> _orders = [];

  OrderDataSource(List<Order> orders) {
    _orders = orders
        .map<DataGridRow>((order) =>
        DataGridRow(cells: [
          DataGridCell<String>(columnName: 'orderNo', value: order.orderNo),
          DataGridCell<String>(
              columnName: 'orderDate', value: order.orderDate),
          DataGridCell<String>(
              columnName: 'customerName', value: order.customerName),
          DataGridCell<String>(
              columnName: 'mobileNo', value: order.mobileNo),
          DataGridCell<String>(columnName: 'address', value: order.address),
          DataGridCell<String>(
              columnName: 'productName', value: order.productName),
          DataGridCell<double>(
              columnName: 'productPrice', value: order.productPrice),
        ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _orders;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = _orders.indexOf(row);
    final Color backgroundColor =
    rowIndex.isEven ? Colors.grey.shade200 : Colors.white;

    return DataGridRowAdapter(
      color: backgroundColor,
      cells: row
          .getCells()
          .asMap()
          .entries
          .map((entry) {
        final int columnIndex = entry.key;
        final DataGridCell cell = entry.value;

        final bool isFirstColumn = columnIndex == 0;
        final bool isFirstRow = rowIndex == 0;

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border(
              left: isFirstColumn
                  ? const BorderSide(color: Colors.black, width: 2)
                  : BorderSide.none,
              right: const BorderSide(color: Colors.black, width: 1),
              bottom: const BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: Text(cell.value.toString(), maxLines: 2,  overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12),),
        );
      }).toList(),
    );
  }

}
