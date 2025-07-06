import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'order.dart';
import 'order_data_source.dart';

class ExcelSheetListViewScreen extends StatefulWidget {
  ExcelSheetListViewScreen({super.key});

  @override
  State<ExcelSheetListViewScreen> createState() =>
      _ExcelSheetListViewScreenState();
}

class _ExcelSheetListViewScreenState extends State<ExcelSheetListViewScreen> {
  final ScrollController _scrollController = ScrollController();
  late OrderDataSource orderDataSource;

  bool isAtStart = true;
  bool isAtEnd = false;

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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
    Order(
      orderNo: 'ORD-456DEF-ZW',
      orderDate: '2025-07-02',
      customerName: 'Maria Islam',
      mobileNo: '01700000005',
      address: '2020 Lane, Barisal',
      productName: 'Keyboard E5',
      productPrice: 2999.00,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    orderDataSource = OrderDataSource(orders);
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;

      setState(() {
        isAtStart = offset <= 0;
        isAtEnd = offset >= maxScroll;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: const Text('Excel Sheet View'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: SizedBox(
                width: MediaQuery.of(context).size.width +
                    200, // full screen width
                child: SfDataGrid(
                  source: orderDataSource,
                  columnWidthMode: ColumnWidthMode.none,
                  columns: [
                    GridColumn(
                      columnName: 'orderNo',
                      label: _buildHeader('Order No', isFirstColumn: true),
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
              ),
            ),
          ),

          // Scroll Arrows
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade600, width: 1),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      // Remove default padding
                      constraints: BoxConstraints(),
                      // Remove default constraints
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20, // Slightly smaller to center better
                          color:
                              isAtStart ? Colors.grey.shade300 : Colors.black,
                        ),
                      ),
                      onPressed: isAtStart
                          ? null
                          : () {
                              _scrollController.animateTo(
                                _scrollController.offset - 200,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    ),
                  ),
                ),

                const SizedBox(width: 120),

                // Forward Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade600, width: 1),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      // Ensure no extra space
                      constraints: BoxConstraints(),
                      // Remove default constraints
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: isAtEnd ? Colors.grey.shade300 : Colors.black,
                        ),
                      ),
                      onPressed: isAtEnd
                          ? null
                          : () {
                              _scrollController.animateTo(
                                _scrollController.offset + 200,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Back Button
          //       Container(
          //         width: 44,
          //         height: 44,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           border: Border.all(color: Colors.grey.shade600, width: 1),
          //           color: Colors.transparent,
          //         ),
          //         child: Center(
          //           child: IconButton(
          //             icon: Padding(
          //               padding: const EdgeInsets.only(left: 4.0),
          //               child: const Icon(Icons.arrow_back_ios, size: 28),
          //             ),
          //             onPressed: () {
          //               _scrollController.animateTo(
          //                 _scrollController.offset - 200,
          //                 duration: const Duration(milliseconds: 300),
          //                 curve: Curves.easeInOut,
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //
          //       const SizedBox(width: 120),
          //
          //       // Forward Button
          //       Container(
          //         width: 44,
          //         height: 44,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           border: Border.all(color: Colors.grey.shade600, width: 1),
          //           color: Colors.transparent,
          //         ),
          //         child: Center(
          //           child: IconButton(
          //             icon: Padding(
          //               padding: const EdgeInsets.only(right: 8.0),
          //               child: const Icon(Icons.arrow_forward_ios, size: 28),
          //             ),
          //             onPressed: () {
          //               _scrollController.animateTo(
          //                 _scrollController.offset + 200,
          //                 duration: const Duration(milliseconds: 300),
          //                 curve: Curves.easeInOut,
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 10,
          )
        ],
      ),
      /* Scrollbar(
        thumbVisibility: true, //  shows the scrollbar
        child: SfDataGrid(
          source: orderDataSource,
          //columnWidthMode: ColumnWidthMode.fill,
          columnWidthMode: ColumnWidthMode.none, //  Enables horizontal scroll
          horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(), // Optional
          columns: [
            GridColumn(
              columnName: 'orderNo',
              label: _buildHeader('Order No',
                  isFirstColumn: true), //  First column
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
      ) */
    );
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
