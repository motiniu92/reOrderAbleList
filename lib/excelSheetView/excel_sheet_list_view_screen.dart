import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'order.dart';
import 'order_data_source.dart';

class ExcelSheetListViewScreen extends StatelessWidget {
  ExcelSheetListViewScreen({super.key});

  final List<Order> orders = [
    Order(
      orderNo: 'ORD-490ZU7-ON',
      orderDate: '2025-07-06',
      customerName: 'John Doe',
      mobileNo: '01700000001',
      address: '123 Street, Dhaka',
      productName: 'Smartphone A1',
      productPrice: 19999.00,
    ),
    Order(
      orderNo: 'ORD-530ZX6-SB',
      orderDate: '2025-07-05',
      customerName: 'Jane Smith',
      mobileNo: '01700000002',
      address: '456 Avenue, Chittagong',
      productName: 'Tablet B2',
      productPrice: 25999.00,
    ),
    Order(
      orderNo: 'ORD-990BX7-KT',
      orderDate: '2025-07-04',
      customerName: 'Alice Mia',
      mobileNo: '01700000003',
      address: '789 Road, Khulna',
      productName: 'Laptop C3',
      productPrice: 74999.00,
    ),
    Order(
      orderNo: 'ORD-123ABC-XY',
      orderDate: '2025-07-03',
      customerName: 'Robert Khan',
      mobileNo: '01700000004',
      address: '1010 Street, Sylhet',
      productName: 'Monitor D4',
      productPrice: 12999.00,
    ),
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final OrderDataSource orderDataSource = OrderDataSource(orders);

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade100,
          title: const Text('Excel Sheet View'),
        ),
        body: Scrollbar(
          thumbVisibility: true, // 👈 shows the scrollbar
          child: SfDataGrid(
            source: orderDataSource,
            //columnWidthMode: ColumnWidthMode.fill,
            columnWidthMode: ColumnWidthMode.none, // 👈 Enables horizontal scroll
            horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(), // Optional
            columns: [
              GridColumn(
                columnName: 'orderNo',
                label: _buildHeader('Order No',
                    isFirstColumn: true), // 👈 First column
              ),
              GridColumn(
                columnName: 'orderDate',
                label: _buildHeader('Order Date'),
              ),
              GridColumn(
                columnName: 'customerName',
                label: _buildHeader('Customer'),
              ),
              GridColumn(
                columnName: 'mobileNo',
                label: _buildHeader('Mobile'),
              ),
              GridColumn(
                columnName: 'address',
                label: _buildHeader('Address'),
              ),
              GridColumn(
                columnName: 'productName',
                label: _buildHeader('Product'),
              ),
              GridColumn(
                columnName: 'productPrice',
                label: _buildHeader('Price'),
              ),
            ],
          ),
        ));
  }

  Widget _buildHeader(String title, {bool isFirstColumn = false}) {
    return Container(
      padding:
          const EdgeInsets.only(left: 4.0, top: 6.0, right: 4.0, bottom: 4.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        border: Border(
          left: isFirstColumn
              ? const BorderSide(color: Colors.black, width: 2)
              : BorderSide.none,
          right: const BorderSide(color: Colors.black, width: 1),
          top: const BorderSide(color: Colors.black, width: 1),
          bottom: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
