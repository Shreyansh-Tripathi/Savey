import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savey/constants/color_constants.dart';
import 'package:savey/constants/string_constants.dart';
import 'package:savey/data/model/goal.dart';
import 'package:savey/ui/provider/provider.dart';
import 'package:savey/ui/widgets/circular_progress_bar.dart';
import 'package:savey/ui/widgets/data_card.dart';
import 'package:savey/ui/widgets/savings_data_sheet.dart';

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
        backgroundColor: ColorConstants.primaryColor,
        body: Consumer<GoalProvider>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: StreamBuilder(
              stream: provider.getGoals(),
              builder: (context, snapshot) {
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
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      StringConstants.errorConnectingToDatabase,
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
                      StringConstants.noGoalsFound,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  );
                }
                
                final List goals = snapshot.data!.docs;
                Goal goal = goals[0].data();
                provider.setData(goal);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      provider.title,
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
                                    '${(provider.savingsPercentage * 100).toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 209, 209, 209),
                                      fontSize: 40.0,
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
                                StringConstants.goalTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                'By ${provider.targetDate.month} ${provider.targetDate.year}',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                            '${StringConstants.currencySymbol}${provider.totalAmountToSave.toString()}',
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
                    DataCard(
                      amountLeft:
                          provider.totalAmountToSave - provider.savedAmount,
                      savePerMonth: provider.getMonthlySavingsRequired(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SavingsDataSheet(
                      items: provider.contributions,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
