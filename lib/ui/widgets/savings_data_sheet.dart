import 'package:flutter/material.dart';
import 'package:savey/constants/color_constants.dart';
import 'package:savey/constants/string_constants.dart';

class SavingsDataSheet extends StatelessWidget {
  final Map<String, int> items;

  final colors = ColorConstants.colorsList;
  SavingsDataSheet({super.key, required this.items});

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
              StringConstants.yourSavings,
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
                    '${StringConstants.currencySymbol}${entry.value.toString()}',
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

    for (int value in items.values) {
      double percentage = (value / totalSum) * 100;
      currentPercentage += percentage;
      stops.add(currentPercentage / 100);
    }

    return stops;
  }
}
