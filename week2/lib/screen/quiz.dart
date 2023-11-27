import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:week2/class/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

void checkTopScore(int point) async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  String _top_user = prefs.getString("top_user") ?? '';
  int top_point = prefs.getInt("top_point") ?? 0;

  if (point > top_point) {
    prefs.setString("top_user", user_id);
    prefs.setInt("top_point", point);
  }
}

class _QuizState extends State<Quiz> {
  late Timer _timer;
  int _hitung = 10;
  int _initValue = 10;
  List<QuestionObj> _questions = [];
  int _question_no = 0;
  int _point = 0;

  @override
  void initState() {
    super.initState();
    _questions.add(QuestionObj(
        "Nama karakter tersebut adalah",
        'Ironman',
        'Spiderman',
        'Thor',
        'Hulk',
        'Ironman',
        'https://cdn.idntimes.com/content-images/community/2019/05/iron-man-header-f99ad485400903a231ee96da6ca7c5b3_600x400.jpg'));
    _questions.add(QuestionObj(
        "Karakter berwarna ungu pada Teletubbies bernama",
        'Dipsy',
        'Tinky Winky',
        'Laalaa',
        'Poo',
        'Tinky Winky',
        'https://assets.ayobandung.com/crop/0x0:0x0/750x500/webp/photo/2022/11/08/2709876209.jpeg'));
    _questions.add(QuestionObj(
        "Siapakah pemeran batman dalam film The Flash 2023",
        'Subrata',
        'Michael Keaton',
        'Tony Stark',
        'John Cena',
        'Michael Keaton',
        'https://www.mnctrijaya.com/uploads/news/IMG-20230614-WA0004.jpg'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Flash',
        'Aquades',
        'Flash',
        'https://cms.disway.id/uploads/809bf1f9acdd87ada7f38a4a900cb677.jpeg'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Flash',
        'Wonder Woman',
        'Wonder Woman',
        'https://d1tgyzt3mf06m9.cloudfront.net/v3-staging/2022/12/wonder-woman27a688e9-1b87-41f0-8811-d2c0e2150301-300x169.jpg'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Flash',
        'Wonder Woman',
        'Batman',
        'https://o-cdf.sirclocdn.com/unsafe/o-cdn-cas.sirclocdn.com/parenting/images/batman-film.width-800.format-webp.webp'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Flash',
        'Wonder Woman',
        'Superman',
        'https://cdn1-production-images-kly.akamaized.net/Orb3jOlDta11CdpdCP6i06fksKw=/1200x1200/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/725423/original/superman_in_batman_v_superman_dawn_of_justice-1600x900.jpg'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Hulk',
        'Wonder Woman',
        'Hulk',
        'https://img.freepik.com/premium-photo/incredible-hulk-wallpapers-hd-wallpapers_853177-21137.jpg'));
    _questions.add(QuestionObj(
        "Nama superhero ini adalah",
        'Batman',
        'Superman',
        'Flash',
        'Spiderman',
        'Spiderman',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7nBsd7grp077jApDwH-ZIPDcyELMYm2Buew&usqp=CAU'));
    _questions.add(QuestionObj(
        "Apa nama negara fiksi dalam film Black Panther",
        'Wakanda',
        'Konoha',
        'Antah Berantah',
        'Antartika',
        'Wakanda',
        'https://img.inews.co.id/media/822/files/inews_new/2023/06/01/kenapa_indonesia_disebut_negara_wakanda.jpg'));

    _questions.shuffle();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _hitung--;

        if (_hitung == 0) {
          _question_no++;
          if (_question_no >= 5) {
            finishQuiz();
          }
          _hitung = _initValue;

          // _timer.cancel();
          // showDialog<String>(
          //   context: context,
          //   builder: (BuildContext context) => AlertDialog(
          //     title: Text('Quiz'),
          //     content: Text('Quiz Ended'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),
          // );
        }
      });
    });
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      _question_no++;
      if (_question_no >= 5) {
        finishQuiz();
      }
      _hitung = _initValue;
    });
  }

  finishQuiz() {
    _timer.cancel();
    _question_no = 0;
    checkTopScore(_point);
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quiz'),
              content: Text('Your point = $_point'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _hitung--;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          percent: 1 - (_hitung / _initValue),
          center: Text(formatTime(_hitung)),
          progressColor: Colors.red,
        ),
        Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_questions[_question_no]. photo),
                fit: BoxFit.cover,
              ),
              // shape: BoxShape.circle,
            )),
        Text("Question ${_question_no + 1}: " + _questions[_question_no].narration),
        TextButton(
            onPressed: () {
              checkAnswer(_questions[_question_no].option_a);
            },
            child: Text("A. " + _questions[_question_no].option_a)),
        TextButton(
            onPressed: () {
              checkAnswer(_questions[_question_no].option_b);
            },
            child: Text("B. " + _questions[_question_no].option_b)),
        TextButton(
            onPressed: () {
              checkAnswer(_questions[_question_no].option_c);
            },
            child: Text("C. " + _questions[_question_no].option_c)),
        TextButton(
            onPressed: () {
              checkAnswer(_questions[_question_no].option_d);
            },
            child: Text("D. " + _questions[_question_no].option_d)),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _timer.isActive ? _timer.cancel() : startTimer();
              });
            },
            child: Text(_timer.isActive ? "Stop" : "Start"))
      ])),
    );
  }
}
