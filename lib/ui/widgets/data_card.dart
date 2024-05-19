import 'package:flutter/material.dart';
import 'package:savey/constants/color_constants.dart';
import 'package:savey/constants/string_constants.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.amountLeft,
    required this.savePerMonth,
  });

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
      color: ColorConstants.cardBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.needMoreSavings,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${StringConstants.currencySymbol}$amountLeft',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConstants.savePerMonth,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${StringConstants.currencySymbol}$savePerMonth',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
