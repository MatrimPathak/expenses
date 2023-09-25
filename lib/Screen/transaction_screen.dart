import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  final String title;
  final int amount;
  final bool isExpense;
  final String category;
  final String date;
  final IconData iconData;
  final String notes;

  const TransactionScreen({
    super.key,
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.category,
    required this.date,
    required this.iconData,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Transaction Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceVariant,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color:
                              isExpense ? Colors.red[100] : Colors.green[100],
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        iconData,
                        color: isExpense ? Colors.red[700] : Colors.green[700],
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "TITLE",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "AMOUNT",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    "₹ $amount",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "TRANSACTION TYPE",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    isExpense ? "Expense" : "Income",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "CATEGORY",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "WHEN",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "NOTES",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    notes == "" ? "-" : notes,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
