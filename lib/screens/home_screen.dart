import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selamat Datang')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Masuk sebagai Pelapor'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormScreen()));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Masuk sebagai Admin'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
