import 'package:flutter/material.dart';
import 'package:dart_mysql/services/authentication_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthenticationService();

  // Email validator
  String? validateEmail(String? value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  // Password validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else {
      return null;
    }
  }

  // On login press
  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _authService.authenticateUser(
        _emailController.text,
        _passwordController.text,
      );
      if (success) {
        Navigator.pushReplacementNamed(context, '/main-screen');
      } else {
        // Show login failure message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed! Check your credentials.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: validatePassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Don’t have an account? Sign up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset-password');
                },
                child: Text('Forgot Password? Reset here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
