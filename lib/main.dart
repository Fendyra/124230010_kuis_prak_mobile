import 'package:flutter/material.dart';
import 'package:kuis_prak_mobile/auth/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gravy App', 
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
