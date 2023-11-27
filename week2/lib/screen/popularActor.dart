import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../class/actor.dart';
import 'dart:convert';

class PopularActor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularActorState();
  }
}

class _PopularActorState extends State<PopularActor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Popular Actor')),
        body: ListView(children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DaftarPopActor(snapshot.requireData);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ]));
  }

  List<PopActor> PAs = [];
  Future<String> fetchData() async {
    final response = await http
        .get(Uri.parse("https://ubaya.me/flutter/160420013/list_actor.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  Widget DaftarPopActor(data) {
    List<PopActor> PAs = [];
    Map json = jsonDecode(data);
    for (var mov in json['data']) {
      PopActor pa = PopActor.fromJson(mov);
      PAs.add(pa);
    }
    return ListView.builder(
        itemCount: PAs.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie, size: 30),
                title: Text(PAs[index].id.toString()),
                subtitle: Text(PAs[index].name),
              ),
            ],
          ));
        });
  }
}
