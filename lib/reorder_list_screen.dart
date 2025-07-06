import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:reorderable_list/googleMapLiveLocation/direction_map_screen.dart';

import 'excelSheetView/excel_sheet_list_view_screen.dart';

class ReorderListScreen extends StatefulWidget {
  const ReorderListScreen({super.key});

  @override
  _ReorderListScreenState createState() => _ReorderListScreenState();
}

class _ReorderListScreenState extends State<ReorderListScreen> {
  List<String> items = [
    "Flutter",
    "Developer",
    "Android",
    "Java",
    "Programming",
    "CPlusPlus",
    "Python",
    "PHP",
    "React",
    "Angular",
    "My Sql",
    "Javascript"
  ];

  bool isGridView = false; // toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DirectionMapScreen(),
              ),
            );
          },
          child: Text(
            isGridView ? "Reorder Able GridView" : "Reorder Able ListView",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.grid_view : Icons.checklist),
            tooltip: 'Toggle View',
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
              ),
              child: const Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Excel Sheet View', style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ExcelSheetListViewScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: isGridView
          ? _buildReOrderAbleGridView()
          : _buildReOrderAbleListView(),
    );
  }

  // List View
  Widget _buildReOrderAbleListView() {
    return ReorderableListView.builder(
      itemCount: items.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex -= 1;
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        return Container(
          key: ValueKey(items[index]),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(
            color: index.isOdd ? Colors.cyan.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              title: Text(
                items[index],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: const Icon(
                Icons.drag_handle,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  // Grid View
  Widget _buildReOrderAbleGridView() {
    return ReorderableGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(12),
      children: List.generate(items.length, (index) {
        return Card(
          key: ValueKey(items[index]),
          color: index.isEven ? Colors.green.shade100 : Colors.purple.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.grid_view_sharp,
                    size: 32, color: Colors.black87),
                const SizedBox(height: 12),
                Text(
                  items[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      }),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
    );
  }
}
