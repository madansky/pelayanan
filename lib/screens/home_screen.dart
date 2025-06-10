import 'package:flutter/material.dart';
import 'form_screen.dart';
// import 'login_screen.dart'; // Uncomment jika nanti digunakan

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selamat Datang')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text('Masuk sebagai Pelapor'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen()));
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.lock),
                label: Text('Masuk sebagai Admin'),
                onPressed: () {
                  // Implementasikan jika nanti dibutuhkan
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

