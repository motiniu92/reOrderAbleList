import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the DEBUG banner
      home: ReorderListPage(),
    );
  }
}

class ReorderListPage extends StatefulWidget {
  const ReorderListPage({super.key});

  @override
  _ReorderListPageState createState() => _ReorderListPageState();
}

class _ReorderListPageState extends State<ReorderListPage> {
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
    "Javascript"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: Text("Reorder Able List"),
        centerTitle: true,
      ),
      body: ReorderableListView.builder(
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
            color: Colors.white, // Set your desired item background color
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  items[index],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.drag_handle,
                  size: 32,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
