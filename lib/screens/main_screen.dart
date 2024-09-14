import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MainScreen extends StatelessWidget {
  final MySqlConnection conn;

  MainScreen({required this.conn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Text('Connected to the database successfully!'),
      ),
    );
  }
}
