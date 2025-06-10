import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '', password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (username == 'admin' && password == '1234') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard()),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Admin')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (val) => username = val,
              validator: (val) => val!.isEmpty ? 'Masukkan username' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (val) => password = val,
              validator: (val) => val!.isEmpty ? 'Masukkan password' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(child: Text('Login'), onPressed: _login),
          ]),
        ),
      ),
    );
  }
}
