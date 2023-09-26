import 'package:gsheets/gsheets.dart';

class GoogleSheetsAPI {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "expense-tracker-400122",
  "private_key_id": "2ce7260e335b13f7c9530e4e2abb583b784ad069",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDSasap3aa+TAgi\n+FZ9KQxUxlbdKOLr2y7YwCqeugBSloBQ9Ye8z36j93POtW37HdppkrQOn4hYjIWS\nRqEj1DUhEHtBGRtNGeTMnpaKKzwoO/290ide0XRMgKtALoe7quHEcocmos2hMcx/\noa1PXvGMYRS2QtGLapcE6PoJEsTx058N6IG4d4DWdDTrYd/G1y+MC/rG5CwypjzS\niL+bSX6Lq2Cmpq6ywthofXr8DHREXPY2zKtSLeNzU9k8boVaXPn3jM+ZHI6G9N6K\nko2YZNkqFWQ/1pBDMJlFnusJBuSDKXZ32suB/VwPuz04/k+Xq3DLOJeK1FplkNzI\n4AX//8wNAgMBAAECggEANoUuJpNlAgfHT/BS0KlTJaAin7lZWs13DPh10pzVOpD+\nfHuyCQ0mfiu+2P+PmLJ6hkJZ3zQc6vy2G1mrpRH2FjQkC5EKzuZ3r0EkNnbPZols\nzMNoKhxRawUn2kB0MP8s8m7OcAddCnhRyXxF4Lv0EHCTIkqb6ujaao5HQxSW7SV0\n172omr5vDGKck2WWYSNs0Z0N8yahabcKGl6ulffB8Nd0jPWbkOdO4ASEWSIoR/SH\nxii0ZHhoc9S19DRHAzacMgeou6mEuqEGJtbv7RDYooFwbF5tx+sApDZdIXaZ2q9Y\nRtt4YTJVAyYK8qiec6G/yIjWJSQ5cd06ZX933QNa7QKBgQDqsO9jIm0Z5iVwgxAw\nElDvwHb41yN2PjZMtVUXTiynSxG4AgHfGcTczNMjON4InQjR9SvEBW5LbfFyLuLF\nVJU20C2dlRvASs+3SxDBv9Pp/p/Kdi5ZnypDW1k2oulWeGtP/bLy6prUnJvCWpvY\n6c1fpHRzjSlLoT8QqAqW56JKpwKBgQDlhZ/pWQs8AYOfhGcRKJCXfWbKyWBeY96r\n59JzPXlYtpOTzWQVSOWft4jPG1I4EB9do5kdvEQj62/LAYMUDAb/pI/72+XnmuZC\nyxs9cOyhBvmica1818hldHSwvPSTCvNpyXj60XIVg/3nrKBY+e+vJ8B3imTfIFyG\n/s9aX7ruKwKBgQCzT2wXOf5Rg12nkPuVPulHxK0hgn49oVqrUQAqRjgnuVtYU3BK\nnM2kRXortw8tVY2fnMpLgjq6ts16iAgK7Iz0zCmN9Ja3XHFHgbrTzVSDu18quRDA\nuLL5s5l9/Qp6XpbfDt7iagzR1LXM0J2yJTAcmvG+N2QNvK0KdNliYqfEkQKBgQDh\nZmCsYG3P+Ayy0uwExbl5jAUukKS7DYjXeUoLMgvBO0uiksn+vSADwdHw0fvkYrDq\n3Ia51PF19PhMfKelQEp/M7TSuhkFYfFPFvchV4yKdrcg+FJPj/mU6NDP4ECvRsnU\n0a6lYpqO1pi6s6SkvI7NjFRPEPIOzVEQoZwwPGLvEQKBgQDKmd4AbnAjz2w1HcwL\nZSrd8FIJjsREwBgNfShD6tPApHZU7VIXrqlZEUYYLHUgF4uaaUHuz2Va3C9T+8/6\noY6xWIA8e2uTlVnwBoXDVoB69Jyn8JxAs0TSDlN6DE5qCjrnBnim4G/SPqw50XfH\n3tJHO7PjCwc97VfH1PCVTZlKiQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "expense-tracker@expense-tracker-400122.iam.gserviceaccount.com",
  "client_id": "110101719294336477643",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expense-tracker%40expense-tracker-400122.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static final _spreadsheetId = "1qhJodKgO9PhNG-M4MoP3W_EOAQycEcpA8vbbpSDRTRE";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _expensesSheet;
  static Worksheet? _categoriesSheet;

  static int numberOfTransactions = 0;
  static int numberOfCategories = 0;
  static List<List<dynamic>> currentTransactions = [];
  static List<List<dynamic>> currentCategories = [];
  static bool loadingTransactions = true;
  static bool loadingCategories = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _expensesSheet = ss.worksheetByTitle('Expenses');
    _categoriesSheet = ss.worksheetByTitle('Categories');
    countExpenses();
    countCategories();
  }

  static Future countExpenses() async {
    while ((await _expensesSheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    loadTransactions();
  }

  static Future countCategories() async {
    while ((await _categoriesSheet!.values
            .value(column: 1, row: numberOfCategories + 1)) !=
        '') {
      numberOfCategories++;
    }
    loadCategories();
  }

  static Future loadTransactions() async {
    if (_expensesSheet == null) return;
    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _expensesSheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _expensesSheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _expensesSheet!.values.value(column: 3, row: i + 1);
      final String transactionCategory =
          await _expensesSheet!.values.value(column: 4, row: i + 1);
      final String transactionDate =
          await _expensesSheet!.values.value(column: 5, row: i + 1);
      final String transactionNotes =
          await _expensesSheet!.values.value(column: 6, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
          transactionCategory,
          transactionDate,
          transactionNotes,
        ]);
      }
    }
    currentTransactions = currentTransactions.reversed.toList();
    // print(currentTransactions);
    loadingTransactions = false;
  }

  static Future loadCategories() async {
    if (_categoriesSheet == null) return;
    for (int i = 1; i < numberOfCategories; i++) {
      final String categoryName =
          await _categoriesSheet!.values.value(column: 1, row: i + 1);
      final String categoryColor =
          await _categoriesSheet!.values.value(column: 2, row: i + 1);

      if (currentCategories.length < numberOfCategories) {
        currentCategories.add([
          categoryName,
          categoryColor,
        ]);
      }
    }
    // print(currentCategories);
    loadingCategories = false;
  }

  static Future insertTransaction(String name, String amount, String type,
      String category, String timeStamp, String notes) async {
    if (_expensesSheet == null) return;
    numberOfTransactions++;
    currentTransactions = currentTransactions.reversed.toList();
    currentTransactions.add([
      name,
      amount,
      type,
      category,
      timeStamp,
      notes,
    ]);
    currentTransactions = currentTransactions.reversed.toList();
    await _expensesSheet!.values.appendRow([
      name,
      amount,
      type,
      category,
      timeStamp,
      notes,
    ]);
  }

  static Future insertCategory(String name, String color) async {
    if (_categoriesSheet == null) return;
    numberOfCategories++;
    currentCategories.add([
      name,
      color,
    ]);
    await _categoriesSheet!.values.appendRow([
      name,
      color,
    ]);
  }

  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
