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
    "Angular",
    "My Sql",
    "Javascript"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: index.isOdd ? Colors.cyan.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(12), //  Corner radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), //  Match radius for clipping children
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      items[index],
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  leading: Icon(
                    Icons.drag_handle,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }

      ),
    );
  }
}
