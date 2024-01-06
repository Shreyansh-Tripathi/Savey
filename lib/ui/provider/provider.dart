import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:savey/data/services/firestore_service.dart';

class GoalProvider extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();
  double savingsPercentage = 0.0;
  String displayMessage = '';
  Color foreground = Colors.red;
  Color background = Colors.red.withOpacity(0.2);

  Stream<QuerySnapshot> getGoals() {
    return firestoreService.getGoals();
  }

  void getPercentage(int targetAmount, int amount) {
    savingsPercentage = (amount / targetAmount);

    if (savingsPercentage >= 0.8) {
      foreground = Colors.green;
    } else if (savingsPercentage >= 0.4) {
      foreground = Colors.yellow;
    }

    displayMessage = 'You have just started, way to go!';
    if (savingsPercentage == 1) {
      displayMessage = 'Yay, you\'ve done it!';
    } else if (savingsPercentage >= 0.8) {
      displayMessage = 'Almost there, hold on for a bit!';
    } else if (savingsPercentage >= 0.4) {
      displayMessage = 'Halfway there, keep going!';
    } else {
      foreground = Colors.red;
    }

    background = foreground.withOpacity(0.2);
  }

  int calculateMonthlySavingsRequired({
    required int goalAmount,
    required String targetMonth,
    required int targetYear,
  }) {
    DateTime currentDate = DateTime.now();
    DateTime targetDate = DateTime(targetYear, _getMonthNumber(targetMonth));

    int monthsToTarget = _calculateMonthsDifference(currentDate, targetDate);

    if (monthsToTarget <= 0) {
      return 0;
    }

    int monthlySavings = (goalAmount / monthsToTarget).ceil();
    return monthlySavings;
  }

  static int _calculateMonthsDifference(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  static int _getMonthNumber(String month) {
    switch (month.toLowerCase()) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Aug':
        return 8;
      case 'Sep':
        return 9;
      case 'Oct':
        return 10;
      case 'Nov':
        return 11;
      default:
        return 12;
    }
  }
}
