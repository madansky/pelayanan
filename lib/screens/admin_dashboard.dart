import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Admin')),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('reports')
      //       .orderBy('timestamp', descending: true)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData)
      //       return Center(child: CircularProgressIndicator());

      //     final docs = snapshot.data!.docs;

      //     return ListView.builder(
      //       itemCount: docs.length,
      //       itemBuilder: (context, index) {
      //         final data = docs[index];
      //         final tanggal = data['tanggal']?.toDate();
      //         final jam = data['jam'] != null ? TimeOfDay.fromDateTime(data['jam'].toDate()) : null;
      //         return Card(
      //           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //           child: ListTile(
      //             title: Text('${data['nama']} - ${data['pangkat']} (${data['nrp']})'),
      //             subtitle: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text('Satuan: ${data['satuan']}'),
      //                 Text('Perihal: ${data['perihal']}'),
      //                 Text('Uraian: ${data['uraianPerihal']}'),
      //                 Text('Dalam Rangka: ${data['dalamRangka']}'),
      //                 if (tanggal != null)
      //                   Text('Tanggal: ${DateFormat('dd/MM/yyyy').format(tanggal)}'),
      //                 if (jam != null)
      //                   Text('Jam: ${jam.format(context)}'),
      //                 Text('HP Pelapor: ${data['noHp']}'),
      //               ],
      //             ),
      //             isThreeLine: true,
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      body: Center(child: Text('Data Firebase belum diaktifkan.')),
    );
  }
}



