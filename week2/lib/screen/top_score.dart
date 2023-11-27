import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopScore extends StatefulWidget {
  @override
  _TopScoreState createState() => _TopScoreState();
}

// class TopScore extends StatelessWidget {
// final String topUser;
// final int topPoint;

// TopScore({required this.topUser, required this.topPoint});
// }

class _TopScoreState extends State<TopScore> {
  String top_user = '';
  int top_user_point = 0;

  @override
  void initState() {
    super.initState();
    _loadTopScore();
  }

  Future<void> _loadTopScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      top_user = prefs.getString('top_user') ?? '';
      top_user_point = prefs.getInt('top_point') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Score'),
      ),
      body: Center(
        child: Column(children: [
          Text('Top Score: $top_user'),
          Text('His/Her score was $top_user_point')
        ]),
      ),
    );
  }
}
