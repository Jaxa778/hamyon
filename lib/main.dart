import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hamyon/services/local_database.dart';
import 'package:hamyon/views/screens/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase().init();
  await initializeDateFormatting('uz_UZ', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: ThemeData(
        brightness: Brightness.light,
        // colorSchemeSeed: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.green,
          error: Colors.blueGrey,
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          elevation: 10,
          shadowColor: Colors.red,
        ),
        
        hoverColor: Colors.red,
      ),
      dark: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      builder: (light, dark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // themeMode: themeMode,
          theme: light,
          darkTheme: dark,
          home: HomeScreen(),
        );
      },
    );
  }
}
