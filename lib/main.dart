import 'package:flutter/material.dart';
import 'screens/login_screen.dart';  // Import login screen
import 'screens/register_screen.dart';  // Import register screen
import 'screens/reset_password_screen.dart';  // Import reset password screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 187, 236, 255),  // Set the background color here
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => RegisterPage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
    );
  }
}
