import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', report = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('reports').add({
        'name': name,
        'email': email,
        'report': report,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan berhasil dikirim')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulir Pelaporan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nama'),
              onChanged: (val) => name = val,
              validator: (val) => val!.isEmpty ? 'Masukkan nama' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val) => email = val,
              validator: (val) => val!.isEmpty ? 'Masukkan email' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Laporan'),
              maxLines: 3,
              onChanged: (val) => report = val,
              validator: (val) => val!.isEmpty ? 'Masukkan laporan' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(child: Text('Kirim'), onPressed: _submit),
          ]),
        ),
      ),
    );
  }
}
