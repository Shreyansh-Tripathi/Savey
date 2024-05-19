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
          builder: (context, provider, child) => StreamBuilder(
            stream: provider.getGoals(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        color: ColorConstants.white,
                      )),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    StringConstants.errorConnectingToDatabase,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    StringConstants.noGoalsFound,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              }
              
              final List goals = snapshot.data!.docs;
              Goal goal = goals[0].data();
              provider.setData(goal);
          
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      provider.title,
                      style: Theme.of(context).textTheme.displayLarge,
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
                                    style: provider.savingsPercentage < 1
                                        ? Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                              color: ColorConstants.offWhite,
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .displayLarge,
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
                      style: Theme.of(context).textTheme.displaySmall,
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
                              Text(
                                StringConstants.goalTitle,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                'By ${provider.targetDate.month}/${provider.targetDate.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorConstants.offWhite,
                                        fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                            '${StringConstants.currencySymbol}${provider.totalAmountToSave.toString()}',
                            style: Theme.of(context).textTheme.displayMedium,
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
                    SavingsDataSheet(items: provider.contributions),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
