import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final int id_photo;
  StudentDetail(this.id_photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: Center(
        child: Image.network('https://i.pravatar.cc/300?img=$id_photo'),
      ),
    );
  }
}