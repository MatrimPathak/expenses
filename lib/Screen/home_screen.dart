import 'package:expenses/Screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Expenses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Total Balance Region
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("TOTAL BALANCE"),
                      Text(
                        "₹ 5,664",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Income and Expense Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.green[700],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: const [
                                    Text("TOTAL INCOME"),
                                    Text(
                                      "+ ₹ 40,000",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[200],
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red[700],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: const [
                                    Text("TOTAL EXPENSE"),
                                    Text(
                                      "- ₹ 34,336",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "RECENT TRANSACTIONS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        CategoryItem(category: "Food", selected: false),
                        CategoryItem(category: "Travel", selected: false),
                        CategoryItem(category: "Personal", selected: false),
                        CategoryItem(category: "Groceries", selected: false),
                        CategoryItem(category: "Games", selected: false),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ExpenseItem(
                  name: "Stipend",
                  category: "Salary",
                  amount: 40000,
                  isExpense: false,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Food - PG",
                  category: "Food",
                  amount: 2040,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Food - Office",
                  category: "Food",
                  amount: 1275,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Food - Others",
                  category: "Food",
                  amount: 866,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Wifi",
                  category: "Wifi",
                  amount: 4195,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Groceries",
                  category: "Groceries",
                  amount: 3280,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Rent",
                  category: "Personal",
                  amount: 3280,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Rapido",
                  category: "Travel",
                  amount: 708,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Laundry",
                  category: "Laundry",
                  amount: 708,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Valorant",
                  category: "Games",
                  amount: 900,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Youtube",
                  category: "Subscriptions",
                  amount: 900,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Jio Prepaid",
                  category: "Recharge",
                  amount: 299,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
                ExpenseItem(
                  name: "Jawaan",
                  category: "Movies",
                  amount: 814,
                  date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: const Icon(Icons.add),
      ),
    );
  }
}
