import 'package:flutter/material.dart';
import 'package:savey/ui/screen/goal_detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoalDetailScreen(),
    );
  }
}