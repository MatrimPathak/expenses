import 'dart:async';

import 'package:expenses/Screen/screens.dart';
import 'package:expenses/Widgets/topcard.dart';
import 'package:expenses/Widgets/totaltransactioncard.dart';
import 'package:expenses/google_sheets_api.dart';
import 'package:expenses/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsAPI.loadingTransactions == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsAPI.loadingTransactions == true &&
        timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: const Text(
            "Expenses",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: TopCard(
              amount: (GoogleSheetsAPI.calculateIncome() -
                  GoogleSheetsAPI.calculateExpense()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Row(
              children: [
                TotalTransactionCard(
                  amount: GoogleSheetsAPI.calculateIncome(),
                  isExpense: false,
                ),
                const SizedBox(width: 10),
                TotalTransactionCard(
                  amount: GoogleSheetsAPI.calculateExpense(),
                  isExpense: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "RECENT TRANSACTIONS",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleSheetsAPI.loadingTransactions == true
                          ? const Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : GoogleSheetsAPI.numberOfTransactions == 0
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Text(
                                      "NO TRANSACTIONS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemCount: GoogleSheetsAPI
                                    .currentTransactions.length,
                                itemBuilder: (context, index) {
                                  return ExpenseItem(
                                    name: GoogleSheetsAPI
                                        .currentTransactions[index][0],
                                    amount: GoogleSheetsAPI
                                        .currentTransactions[index][1],
                                    isExpense:
                                        GoogleSheetsAPI.currentTransactions[
                                                    index][2] ==
                                                "expense"
                                            ? true
                                            : false,
                                    category: GoogleSheetsAPI
                                        .currentTransactions[index][3],
                                    date: GoogleSheetsAPI
                                        .currentTransactions[index][4],
                                    notes: GoogleSheetsAPI
                                        .currentTransactions[index][5],
                                  );
                                },
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Add New Transaction",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
