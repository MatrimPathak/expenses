import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Screen/screens.dart';
import '../theme_provider.dart';

class ExpenseItem extends StatelessWidget {
  final String name;
  final String category;
  final String date;
  final String amount;
  final bool isExpense;
  final String notes;
  const ExpenseItem({
    super.key,
    this.isExpense = true,
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
  });

  IconData getIcon() {
    IconData itemIcon;
    if (category == "Food") {
      itemIcon = Icons.fastfood_outlined;
    } else if (category == "Salary") {
      itemIcon = Icons.attach_money_outlined;
    } else if (category == "Wifi") {
      itemIcon = Icons.wifi_outlined;
    } else if (category == "Groceries") {
      itemIcon = Icons.shopping_cart_outlined;
    } else if (category == "Personal") {
      itemIcon = Icons.people_outlined;
    } else if (category == "Travel") {
      itemIcon = Icons.bike_scooter_outlined;
    } else if (category == "Laundry") {
      itemIcon = Icons.local_laundry_service;
    } else if (category == "Games") {
      itemIcon = Icons.sports_esports_outlined;
    } else if (category == "Subscriptions") {
      itemIcon = Icons.subscriptions_outlined;
    } else if (category == "Recharge") {
      itemIcon = Icons.five_g_outlined;
    } else if (category == "Movies") {
      itemIcon = Icons.videocam_outlined;
    } else {
      itemIcon = Icons.warning_outlined;
    }
    return itemIcon;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionScreen(
              title: name,
              amount: amount,
              category: category,
              date: date,
              isExpense: isExpense,
              iconData: getIcon(),
              notes: notes,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).themeMode ==
                        ThemeMode.dark
                    ? isExpense
                        ? Colors.red[100]
                        : Colors.green[100]
                    : isExpense
                        ? Colors.red[700]
                        : Colors.green[700],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                getIcon(),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(category),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${isExpense ? "-" : "+"} ₹ $amount",
                  style: TextStyle(
                    color: isExpense ? Colors.red[400] : Colors.green[400],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(date)
              ],
            )
          ],
        ),
      ),
    );
  }
}
