import 'package:flutter/material.dart';
import 'package:savey/circular_progress_bar.dart';

class GoalDetailScreen extends StatefulWidget {
  const GoalDetailScreen({super.key});

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double currentSavings = 5000.0;
    double targetAmount = 10000.0;

    double savingsPercentage = (currentSavings / targetAmount);
    Color foreground = Colors.red;

    if (savingsPercentage >= 0.8) {
      foreground = Colors.green;
    } else if (savingsPercentage >= 0.4) {
      foreground = Colors.orange;
    }

    Color background = foreground.withOpacity(0.2);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff2D2C79),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buy a Dream House',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CircleProgressBar(
                foregroundColor: foreground,
                value: savingsPercentage,
                backgroundColor: background,
              ),
            )
          ],
        ),
      ),
    );
  }
}
