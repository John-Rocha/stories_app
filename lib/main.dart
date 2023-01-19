import 'package:flutter/material.dart';
import 'package:stories_app/detail_screen.dart';
import 'package:stories_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFF2d3447),
          secondary: const Color.fromARGB(255, 71, 81, 110),
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
      routes: {
        DetailScreen.routeName: (context) => const DetailScreen(),
      },
    );
  }
}
