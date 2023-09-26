import 'package:expenses/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalTransactionCard extends StatelessWidget {
  final bool isExpense;
  final double amount;
  const TotalTransactionCard({
    super.key,
    required this.isExpense,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.surfaceVariant,
          color: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
              ? isExpense
                  ? Colors.red[100]
                  : Colors.green[100]
              : isExpense
                  ? Colors.red[700]
                  : Colors.green[700],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     color: Provider.of<ThemeProvider>(context).themeMode ==
            //             ThemeMode.dark
            //         ? isExpense
            //             ? Colors.red[100]
            //             : Colors.green[100]
            //         : isExpense
            //             ? Colors.red[700]
            //             : Colors.green[700],
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   padding: const EdgeInsets.all(10),
            //   child: Icon(
            //     isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            //     color: Provider.of<ThemeProvider>(context).themeMode ==
            //             ThemeMode.dark
            //         ? isExpense
            //             ? Colors.red[700]
            //             : Colors.green[700]
            //         : isExpense
            //             ? Colors.red[100]
            //             : Colors.green[100],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    isExpense ? "TOTAL EXPENSE" : "TOTAL INCOME",
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? isExpense
                              ? Colors.red[700]
                              : Colors.green[700]
                          : isExpense
                              ? Colors.red[100]
                              : Colors.green[100],
                    ),
                  ),
                  Text(
                    "₹ ${double.parse((amount).toStringAsFixed(2))}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<ThemeProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? isExpense
                              ? Colors.red[700]
                              : Colors.green[700]
                          : isExpense
                              ? Colors.red[100]
                              : Colors.green[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
