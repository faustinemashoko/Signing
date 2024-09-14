import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/main_screen.dart';
import 'models/db_connection.dart';
import 'package:mysql1/mysql1.dart'; // Assuming you're using this package for MySQL connection

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
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/main-screen': (context) => FutureBuilder<MySqlConnection>(
          future: DBConnection().dbConnect(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()), // Loading screen while waiting for DB connection
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error connecting to the database')),
              );
            } else if (snapshot.hasData) {
              return MainScreen(conn: snapshot.data!);  // Pass the connection once it's available
            } else {
              return Scaffold(
                body: Center(child: Text('Unknown error')),
              );
            }
          },
        ),
      },
    );
  }
}
