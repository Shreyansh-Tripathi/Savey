// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:savey/constants/color_constants.dart';
import 'package:savey/constants/string_constants.dart';

class SavingsDataSheet extends StatelessWidget {
  final Map<String, int> items;


  const SavingsDataSheet({
    Key? key,
    required this.items,
  }) : super(key: key);

  final colors = ColorConstants.colorsList;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              StringConstants.yourSavings,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Text(
                    '${StringConstants.currencySymbol}${entry.value.toString()}',
                    style: Theme.of(context).textTheme.bodySmall,
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
