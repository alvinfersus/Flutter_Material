import 'package:flutter/material.dart';
import '../class/recipe.dart';

class AddRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _recipe_name_cont = TextEditingController();
  final TextEditingController _recipe_desc_cont = TextEditingController();
  final TextEditingController _recipe_photo_cont = TextEditingController();
  int _charleft = 0;

  @override
  void initState() {
    super.initState();
    _recipe_name_cont.text = "your food name";
    _recipe_desc_cont.text = "Recipe of ..";
    _charleft = 200 - _recipe_desc_cont.text.length;
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _recipe_name_cont,
                  onChanged: (v) {
                    print(_recipe_name_cont.text);
                    print(v);
                  },
                ),
                TextField(
                  controller: _recipe_desc_cont,
                  onChanged: (v) {
                    setState(() {
                      _charleft = 200 - v.length;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: null,
                ),
                Text("Char left: " + _charleft.toString()),
                TextField(
                  controller: _recipe_photo_cont,
                  onSubmitted: (v) {
                    setState(() {});
                  },
                ),
                Image.network(_recipe_photo_cont.text),
                Text(""),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getButtonColor),
                    ),
                    onPressed: () {
                      recipes.add(Recipe(
                        id: recipes.length + 1,
                        name: _recipe_name_cont.text,
                        desc: _recipe_desc_cont.text,
                        photo: _recipe_photo_cont.text,
                      ));

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Add Recipe'),
                                content: Text('Recipe successfully added'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                    child: Text('SUBMIT'))
              ],
            )),
      ),
    );
  }
}
