import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week2/class/popMovie.dart';

class DetailPop extends StatefulWidget {
  int movieID;
  DetailPop({super.key, required this.movieID});

  @override
  State<DetailPop> createState() => _DetailPopState();
}

class _DetailPopState extends State<DetailPop> {
  PopMovie? _pm;

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.me/flutter/160420013/detail_movie.php"),
        body: {'id': widget.movieID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      setState(() {});
    });
  }

  Widget tampilData() {
    if (_pm == null) {
      return const CircularProgressIndicator();
    }
    return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text(_pm!.title, style: const TextStyle(fontSize: 25)),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_pm!.overview, style: const TextStyle(fontSize: 15))),
          Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _pm?.genres?.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    // return Text("Genre");
                    return Text(_pm?.genres?[index]['genre_name']);
                  })),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Actor/Actress:"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _pm?.actor?.length ?? 0,
              itemBuilder: (BuildContext ctxt, int index) {
                final actor = _pm?.actor?[index];
                final personName = actor['person_name'];
                final characterPlayed = actor['character_name'];

                return ListTile(
                  title: Text(personName),
                  subtitle: Text("Character played: $characterPlayed"),
                );
              },
            ),
          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail of Popular Movie'),
        ),
        body: ListView(children: <Widget>[tampilData()]));
  }
}
