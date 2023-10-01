import 'package:flutter/material.dart';
import 'package:week2/screen/course_detail.dart';

class MyCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Course'),
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo, width: 5),
                    image: DecorationImage(image: AssetImage('assets/images/avatar.jpeg'),
                    fit: BoxFit.cover)
                  ),
                ),
                Text('Alvin Fernando Susanto'),
                Text('160420013'),
                Text('Teknik Informatika'),
                Text('Gasal 2023-2024'),
          Container(
              height: 500,
              width: 300,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail("Emerging Technology", "A")));
                      },
                      child: Text('Emerging Technology (A)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail("WFP", "A")));
                      },
                      child: Text('WFP (A)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail("Kerja Praktek", "-")));
                      },
                      child: Text('Kerja Praktek'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail("Tugas Akhir", "-")));
                      },
                      child: Text('Tugas Akhir'),
                    ),
                  ),
                ],
              )
            )
          ]
        )
      )
    );
  }
}
