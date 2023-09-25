import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();

  String type = "Expense";
  String color = "Red";
  String category = "Food";

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    notesController.dispose();
    categoryNameController.dispose();
    super.dispose();
  }

  Future<void> addExpense() {
    return FirebaseFirestore.instance
        .collection('Expenses')
        .add({
          'title': titleController.text.trim(),
          'amount': amountController.text.trim(),
          'isExpense': type == "Expense" ? true : false,
          'notes': notesController.text.trim(),
          'category': category,
          'date': Timestamp.now(),
        })
        .then((value) => print("Expense Added"))
        .catchError((error) => print("Failed to add expense: $error"));
  }

  Future<void> addCategory() {
    return FirebaseFirestore.instance
        .collection('Categories')
        .add({
          'name': categoryNameController.text.trim(),
          'color': color,
        })
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add category: $error"));
  }

  IconData getIcon() {
    IconData itemIcon;
    if (category == "Food") {
      itemIcon = Icons.fastfood_outlined;
    } else if (category == "Travel") {
      itemIcon = Icons.bike_scooter_outlined;
    } else if (category == "Personal") {
      itemIcon = Icons.people_outlined;
    } else if (category == "Groceries") {
      itemIcon = Icons.shopping_cart_outlined;
    } else if (category == "Games") {
      itemIcon = Icons.sports_esports_outlined;
    } else if (category == "Laundry") {
      itemIcon = Icons.local_laundry_service;
    } else if (category == "Salary") {
      itemIcon = Icons.attach_money_outlined;
    } else if (category == "Wifi") {
      itemIcon = Icons.wifi_outlined;
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Add Transaction",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.close),
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.1),
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
                                color: type == "Expense"
                                    ? Colors.red[100]
                                    : Colors.green[100],
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              getIcon(),
                              color: type == "Expense"
                                  ? Colors.red[700]
                                  : Colors.green[700],
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "TITLE",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextField(
                          controller: titleController,
                          cursorColor: Theme.of(context).colorScheme.onSurface,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "AMOUNT",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          cursorColor: Theme.of(context).colorScheme.onSurface,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.currency_rupee),
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "TRANSACTION TYPE",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    type = "Expense";
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: type == "Expense"
                                        ? Colors.red[100]
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "Expense",
                                    style: TextStyle(
                                      color: type == "Expense"
                                          ? Colors.red[800]
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    type = "Income";
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: type == "Income"
                                        ? Colors.green[100]
                                        : Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "Income",
                                    style: TextStyle(
                                      color: type == "Income"
                                          ? Colors.green[800]
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "CATEGORY",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Add new Category',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              "NAME",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                            TextField(
                                              controller: categoryNameController,
                                              cursorColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceVariant,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant),
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              "COLOR",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Red";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.red,
                                                        selected: color == "Red"
                                                            ? true
                                                            : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Orange";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.orange,
                                                        selected:
                                                            color == "Orange"
                                                                ? true
                                                                : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Yellow";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.yellow,
                                                        selected:
                                                            color == "Yellow"
                                                                ? true
                                                                : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Green";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.green,
                                                        selected:
                                                            color == "Green"
                                                                ? true
                                                                : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Blue";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.blue,
                                                        selected:
                                                            color == "Blue"
                                                                ? true
                                                                : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Indigo";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.indigo,
                                                        selected:
                                                            color == "Indigo"
                                                                ? true
                                                                : false,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          color = "Purple";
                                                        });
                                                      },
                                                      child: ColorItem(
                                                        color: Colors.purple,
                                                        selected:
                                                            color == "Purple"
                                                                ? true
                                                                : false,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10,
                                                      ),
                                                      child: Text(
                                                        'Close',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      addCategory();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10,
                                                      ),
                                                      child: Text(
                                                        'Save',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        width: 2,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            category = "Food";
                                          });
                                        },
                                        child: CategoryItem(
                                          category: "Food",
                                          selected:
                                              category == "Food" ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            category = "Travel";
                                          });
                                        },
                                        child: CategoryItem(
                                          category: "Travel",
                                          selected: category == "Travel"
                                              ? true
                                              : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            category = "Personal";
                                          });
                                        },
                                        child: CategoryItem(
                                          category: "Personal",
                                          selected: category == "Personal"
                                              ? true
                                              : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            category = "Groceries";
                                          });
                                        },
                                        child: CategoryItem(
                                          category: "Groceries",
                                          selected: category == "Groceries"
                                              ? true
                                              : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            category = "Games";
                                          });
                                        },
                                        child: CategoryItem(
                                          category: "Games",
                                          selected: category == "Games"
                                              ? true
                                              : false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "WHEN",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            DateFormat('MMM dd, yyyy').format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "NOTES",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        TextField(
                          controller: notesController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorColor: Theme.of(context).colorScheme.onSurface,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              addExpense();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Add New Transaction",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
