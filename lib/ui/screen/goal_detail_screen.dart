import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savey/data/model/goal.dart';
import 'package:savey/ui/provider/provider.dart';
import 'package:savey/ui/widgets/circular_progress_bar.dart';

class GoalDetailScreen extends StatefulWidget {
  const GoalDetailScreen({super.key});

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff2D2C79),
        body: Consumer<GoalProvider>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: StreamBuilder(
                stream: provider.getGoals(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error Connecting to Database',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'No Goals Found',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                    );
                  }

                  final List goals = snapshot.data!.docs;
                  Goal goal = goals[0].data;
                  provider.getPercentage(goal.totalAmount, goal.savedAmount);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Text(
                        goal.title,
                        style: const TextStyle(
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
                              foregroundColor: provider.foreground,
                              value: provider.savingsPercentage,
                              backgroundColor: provider.background,
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (provider.savingsPercentage * 100)
                                          .toStringAsFixed(1),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 209, 209, 209),
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
                        provider.displayMessage,
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
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text(
                                  'Goal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'By${goal.endMonth}${goal.endYear}',
                                  style:const  TextStyle(
                                    color: Colors.white60,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Text(
                              goal.totalAmount.toString(),
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
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard({super.key, required this.amountLeft, required this.savePerMonth});

  final int amountLeft;
  final int savePerMonth;

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
                  '' amountLeft,
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

  final colors = [Colors.blue, Colors.brown, Colors.teal];

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
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
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
