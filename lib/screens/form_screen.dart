import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/upload_service.dart';
import 'dart:io';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _uraiPerihalController = TextEditingController();

  String nama = '', pangkat = '', nrp = '', satuan = '', dalamRangka = '', noHp = '';
  String? perihal;
  DateTime? tanggal;
  TimeOfDay? jam;
  File? selfie;
  File? lampiran;

  final List<String> perihalOptions = [
    'Sound System',
    'Vicon',
    'Jaringan Internet',
    'Dukungan Alkom',
    'Lainnya'
  ];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) setState(() => tanggal = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => jam = picked);
  }

  Future<void> _pickSelfie() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => selfie = File(picked.path));
  }

  Future<void> _pickLampiran() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) setState(() => lampiran = File(result.files.first.path!));
  }

  void _submit() async {
    if (_formKey.currentState!.validate() &&
        tanggal != null && jam != null && selfie != null && lampiran != null) {

      final snackBar = ScaffoldMessenger.of(context);
      snackBar.showSnackBar(SnackBar(content: Text('Mengirim...')));

      // URL dari Google Apps Script Web App kamu
      const scriptUrl = 'https://script.google.com/macros/s/AKfycbw0fE59JrF7UgExtk6ZCj0HG8aVW7ykx_9ZpdlMmto53TwdxTXboGb_txzYD_K-cuLt9g/exec';

      final selfieUrl = await UploadService.uploadFile(selfie!, 'selfie_${DateTime.now().millisecondsSinceEpoch}.jpg', scriptUrl);
      final lampiranUrl = await UploadService.uploadFile(lampiran!, 'lampiran_${DateTime.now().millisecondsSinceEpoch}.pdf', scriptUrl);

      if (selfieUrl != null && lampiranUrl != null) {
        await FirebaseFirestore.instance.collection('laporan').add({
          'nama': nama,
          'pangkat': pangkat,
          'nrp': nrp,
          'satuan': satuan,
          'perihal': perihal,
          'uraiPerihal': _uraiPerihalController.text,
          'dalamRangka': dalamRangka,
          'tanggal': tanggal?.toIso8601String(),
          'jam': jam?.format(context),
          'noHp': noHp,
          'selfieUrl': selfieUrl,
          'lampiranUrl': lampiranUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });

        snackBar.showSnackBar(SnackBar(content: Text('Laporan berhasil dikirim')));
        Navigator.pop(context);
      } else {
        snackBar.showSnackBar(SnackBar(content: Text('Gagal mengupload file')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Harap isi semua field yang wajib')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulir Pelaporan')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            _buildTextField(label: 'Nama', onChanged: (val) => nama = val),
            _buildTextField(label: 'Pangkat', onChanged: (val) => pangkat = val),
            _buildTextField(label: 'NRP', onChanged: (val) => nrp = val, keyboardType: TextInputType.number),
            _buildTextField(label: 'Satuan', onChanged: (val) => satuan = val),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Perihal'),
              value: perihal,
              items: perihalOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => perihal = val),
              validator: (val) => val == null ? 'Pilih perihal' : null,
            ),
            TextFormField(
              controller: _uraiPerihalController,
              decoration: InputDecoration(labelText: 'Uraian Perihal'),
              validator: (val) => val!.isEmpty ? 'Masukkan uraian perihal' : null,
            ),
            _buildTextField(label: 'Dalam Rangka', onChanged: (val) => dalamRangka = val),
            Row(
              children: [
                Expanded(child: Text(tanggal == null ? 'Tanggal belum dipilih' : 'Tanggal: ${tanggal!.toLocal()}'.split(' ')[0])),
                TextButton(onPressed: _pickDate, child: Text('Pilih Tanggal')),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(jam == null ? 'Jam belum dipilih' : 'Jam: ${jam!.format(context)}')),
                TextButton(onPressed: _pickTime, child: Text('Pilih Jam')),
              ],
            ),
            _buildTextField(label: 'No. HP Pelapor', onChanged: (val) => noHp = val, keyboardType: TextInputType.phone),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _pickSelfie, child: Text('Upload Foto Selfie')),
            if (selfie != null) Text('Foto selfie terpilih'),
            ElevatedButton(onPressed: _pickLampiran, child: Text('Lampiran Dokumen')),
            if (lampiran != null) Text('Dokumen terpilih'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text('Kirim')),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required Function(String) onChanged, TextInputType? keyboardType}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
    );
  }
}
