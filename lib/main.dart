import 'package:flutter/material.dart';
import 'package:reorderable_list/reorder_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the DEBUG banner
      home: ReorderListScreen(),
    );
  }
}

