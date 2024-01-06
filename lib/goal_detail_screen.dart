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
    double currentSavings = 5000;
    double targetAmount = 10000;

    double savingsPercentage = (currentSavings / targetAmount);
    Color foreground = Colors.red;

    if (savingsPercentage >= 0.8) {
      foreground = Colors.green;
    } else if (savingsPercentage >= 0.4) {
      foreground = Colors.orange;
    }

    String centerText = 'We have just started, way to go!';
    if (savingsPercentage == 1) {
      centerText = 'Yay, you\'ve done it!';
    } else if (savingsPercentage >= 0.8) {
      centerText = 'Almost there, hold on for a bit!';
    } else if (savingsPercentage >= 0.4) {
      centerText = 'Halfway there, keep going!';
    }

    Color background = foreground.withOpacity(0.2);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff2D2C79),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Buy a Dream House',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    CircleProgressBar(
                      foregroundColor: foreground,
                      value: savingsPercentage,
                      backgroundColor: background,
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (savingsPercentage * 100).toStringAsFixed(1),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 209, 209, 209),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                centerText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Goal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'By Jan 2025',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Text(
                      targetAmount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              const DataCard(),
              const SizedBox(
                height: 30,
              ),
              SavingsSplitCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color(0xFF256DEA),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Need More Savings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '1000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Need More Savings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '200',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SavingsSplitCard extends StatelessWidget {
  final Map<String, double> items = {
    'Monthly Savings': 1000.0,
    'Extra Deposits': 20000.0,
    'Rewards': 5000.0,
  };

  final colors = [Colors.blue, Colors.green, Colors.purple];

  SavingsSplitCard({super.key});

  @override
  Widget build(BuildContext context) {
    double totalSum = items.values.fold(0, (a, b) => a + b);
    int i = 0;
    int j = 0;
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Your Savings',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 10.0,
            width: double.infinity,
            child: Row(
              children: items.entries.map((entry) {
                double percentage = (entry.value / totalSum) * 100;
                Color itemColor = colors[i++];
                return Expanded(
                  flex: (percentage * 10).toInt(),
                  child: Container(
                    color: itemColor,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.entries.map((entry) {
                Color itemColor = colors[j++];
                return ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: itemColor,
                    size: 14,
                  ),
                  title: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '₹${entry.value.toString()}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<double> calculateStops(double totalSum) {
    List<double> stops = [];
    double currentPercentage = 0.0;

    for (double value in items.values) {
      double percentage = (value / totalSum) * 100;
      currentPercentage += percentage;
      stops.add(currentPercentage / 100);
    }

    return stops;
  }
}
