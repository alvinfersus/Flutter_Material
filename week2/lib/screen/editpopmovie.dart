import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;
import 'package:week2/class/genre.dart';
import 'package:week2/class/popMovie.dart';

class EditPopMovie extends StatefulWidget {
  int movieID;
  EditPopMovie({super.key, required this.movieID});

  @override
  EditPopMovieState createState() {
    return EditPopMovieState();
  }
}

class EditPopMovieState extends State<EditPopMovie> {
  final _formKey = GlobalKey<FormState>();
  late PopMovie pm;
  TextEditingController _titleCont = TextEditingController();
  TextEditingController _homepageCont = TextEditingController();
  TextEditingController _overviewCont = TextEditingController();
  TextEditingController _releaseDate = TextEditingController();
  int _runtime = 100;
  late Widget comboGenre;

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
      pm = PopMovie.fromJson(json['data']);
      setState(() {
        _titleCont.text = pm.title;
        _homepageCont.text = pm.homepage;
        _overviewCont.text = pm.overview;
        _releaseDate.text = pm.release_date;
        _runtime = pm.runtime;
      });
    });
  }

  void generateComboGenre() {
    //widget function for city list
    List<Genre> genres;
    var data = daftarGenre();
    data.then((value) {
      genres = List<Genre>.from(value.map((i) {
        return Genre.fromJSON(i);
      }));

      comboGenre = DropdownButton(
          dropdownColor: Colors.grey[100],
          hint: Text("tambah genre"),
          isDense: false,
          items: genres.map((gen) {
            return DropdownMenuItem(
              child: Column(children: <Widget>[
                Text(gen.genre_name, overflow: TextOverflow.visible),
              ]),
              value: gen.genre_id,
            );
          }).toList(),
          onChanged: (value) {
            //memnaggil fungsi menambah genre disini
          });
    });
  }

  void submit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.me/flutter/160420013/updatemovie.php"),
        body: {
          'title': pm.title,
          'overview': pm.overview,
          'homepage': pm.homepage,
          'release_date': pm.release_date,
          'runtime': pm.runtime,
          'movie_id': widget.movieID.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/daniel/genrelist.php"),
        body: {'movie_id': widget.movieID.toString()});

    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Popular Movie"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      //pm.title = value;
                    },
                    controller: _titleCont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'judul harus diisi';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                    onChanged: (value) {
                      pm.homepage = value;
                    },
                    controller: _homepageCont,
                    validator: (value) {
                      if (value == null || !Uri.parse(value).isAbsolute) {
                        return 'alamat website salah';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Overview',
                    ),
                    onChanged: (value) {
                      pm.overview = value;
                    },
                    controller: _overviewCont,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Release Date',
                        ),
                        controller: _releaseDate,
                      )),
                      ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              setState(() {
                                _releaseDate.text =
                                    value.toString().substring(0, 10);
                              });
                            });
                          },
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 24.0,
                          ))
                    ],
                  )),
              NumberPicker(
                value: _runtime,
                axis: Axis.horizontal,
                minValue: 50,
                maxValue: 300,
                itemHeight: 30,
                itemWidth: 60,
                step: 1,
                onChanged: (value) {
                  pm.runtime = value;
                  setState(() => _runtime = value);
                },
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    var state = _formKey.currentState;
                    if (state == null || !state.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10), child: Text('Genre:')),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pm.genres?.length ?? 0,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Text(pm?.genres?[index]['genre_name']);
                      })),
            ],
          ),
        ));
  }
}
