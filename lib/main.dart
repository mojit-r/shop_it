import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_it/provider/data_provider.dart';

import 'screens/add_product_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dataProvider = DataProvider();
  await dataProvider.loadCart();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => dataProvider),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, ThemeMode>(
      selector: (context, provider) => provider.customThemeMode,
      builder:
          (context, customThemeMode, _) => MaterialApp(
            title: 'Shop It App',
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: customThemeMode,
            home: const AddProductScreen(),
          ),
    );
  }
}
