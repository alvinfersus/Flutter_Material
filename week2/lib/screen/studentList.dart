// ignore: file_names
import 'package:flutter/material.dart';
import 'package:week2/screen/studentDetail.dart';

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> arrStudent = ["1", "2", "3"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("This is Student List :"),
            for (var student in arrStudent)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0), // Adjust the space as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetail(int.parse(student)),
                      ),
                    );
                  },
                  child: Text("Student #$student"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}