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

    displayMessage = 'We have just started, way to go!';
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
}
