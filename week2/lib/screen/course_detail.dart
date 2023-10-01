import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final String mata_kuliah;
  final String kp;

  CourseDetail(this.mata_kuliah, this.kp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Course Detail'),
        ),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    mata_kuliah,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 500,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          width: 50,
                          height: 50,
                          child: Text("KP. " + kp),
                        ),
                        Container(
                            color: Colors.red,
                            width: 50,
                            height: 50,
                            child: mata_kuliah == "WFP"
                                ? Text('Senin 09.45')
                                : (mata_kuliah == "Emerging Technology"
                                    ? Text('Senin 07.00')
                                    : Text('Tidak ada jadwal reguler'))),
                        Container(
                            color: Colors.red,
                            width: 50,
                            height: 50,
                            child: mata_kuliah == "WFP"
                                ? Text('LA 02.01')
                                : (mata_kuliah == "Emerging Technology"
                                    ? Text('TB 01.01A')
                                    : Text('Tidak ada kelas reguler'))),
                        Container(
                            color: Colors.red,
                            width: 50,
                            height: 50,
                            child: mata_kuliah == "WFP" ||
                                    mata_kuliah == "Emerging Technology"
                                ? Text('3 sks')
                                : Text('Tidak ada kelas reguler')),
                      ]),
                )
              ]),
        ));
  }
}
