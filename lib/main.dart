import 'package:flutter/material.dart';
import 'halaman/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mykonos Official Store',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8F9),
        primaryColor: const Color(0xFF7A0C3E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF7A0C3E),
          secondary: const Color(0xFFE2527A),
        ),
      ),
      // Frame HPnya
      builder: (context, child) {
        return Container(
          color: const Color(0xFF1A1A1A),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: ClipRRect(
                child: child,
              ),
            ),
          ),
        );
      },
      home: const MainNavigation(),
    );
  }
}