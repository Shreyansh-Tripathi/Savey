import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savey/ui/provider/provider.dart';
import 'package:savey/ui/screen/goal_detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => GoalProvider(),
        lazy: true,
        child: const GoalDetailScreen(),
      ),
    );
  }
}