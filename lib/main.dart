import 'package:dynamic_color/dynamic_color.dart';
import 'package:expenses/Screen/homepage.dart';
import 'package:expenses/google_sheets_api.dart';
import 'package:expenses/theme_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsAPI().init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expenses - Budget App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightDynamic,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: darkDynamic,
        ),
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        home: const HomePage(),
      );
    });
  }
}
