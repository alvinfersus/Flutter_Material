import 'package:flutter/material.dart';
import 'package:week2/screen/about.dart';
import 'package:week2/screen/addRecipe.dart';
import 'package:week2/screen/animasi.dart';
import 'package:week2/screen/basket.dart';
import 'package:week2/screen/home.dart';
import 'package:week2/screen/login.dart';
import 'package:week2/screen/my_course.dart';
import 'package:week2/screen/search.dart';
import 'package:week2/screen/history.dart';
import 'package:week2/screen/studentList.dart';
import 'package:week2/screen/quiz.dart';
import 'package:week2/screen/popularMovie.dart';
import 'package:week2/screen/popularActor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week2/screen/top_score.dart';

void main() {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'about': (context) => About(),
        'basket': (context) => Basket(),
        'student_list': (context) => Student(),
        'my_course': (context) => MyCourse(),
        'add_recipe': (context) => AddRecipe(),
        'quiz': (context) => Quiz(),
        'top_score': (context) => TopScore(),
        'animasi': (context) => Animasi(),
        'popularMovie': (context) => PopularMovie(),
        'popularActor': (context) => PopularActor(),
      },
    );
  }
}

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _title = ['Home', 'Search', 'History'];
  String _user_id = '';
  String _user_top = '';
  int _user_top_point = 0;

  @override
  void initState() {
    super.initState();
    checkUser().then((value) => setState(
          () {
            _user_id = value;
          },
        ));
    // getTopUser();
  }

  void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    main();
  }

  // void getTopUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _user_top = prefs.getString("top_user") ?? '';
  //   _user_top_point = prefs.getInt("top_point") ?? 0;
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      persistentFooterButtons: persistentFooter,
      bottomNavigationBar: bottomNavigation(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  BottomNavigationBar bottomNavigation() {
    return BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }

  List<Widget> get persistentFooter {
    return <Widget>[
      ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.skip_previous),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.skip_next),
      ),
    ];
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("xyz"),
              accountEmail: Text(_user_id),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"))),
          ListTile(
            title: new Text("Inbox"),
            leading: new Icon(Icons.inbox),
          ),
          ListTile(
              title: new Text("My Basket "),
              leading: new Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.pushNamed(context, "basket");
              }),
          ListTile(
              title: Text("About"),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.pushNamed(context, "about");
              }),
          ListTile(
              title: Text("Student List"),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.pushNamed(context, "student_list");
              }),
          ListTile(
              title: Text("My Course"),
              leading: Icon(Icons.book),
              onTap: () {
                Navigator.pushNamed(context, "my_course");
              }),
          ListTile(
              title: Text("Add Recipe"),
              leading: Icon(Icons.file_present),
              onTap: () {
                Navigator.pushNamed(context, "add_recipe");
              }),
          ListTile(
              title: new Text("Quiz"),
              leading: new Icon(Icons.question_mark_outlined),
              onTap: () {
                Navigator.popAndPushNamed(context, "quiz");
              }),
          ListTile(
              title: new Text("Top Score"),
              leading: new Icon(Icons.question_mark_outlined),
              onTap: () {
                Navigator.popAndPushNamed(context, "top_score");
                // Navigator.push(
                //     context,
                //Tidak bisa dilakukan karena harus terus mengupdate, maka lebih baik menggunakan stateful
                // MaterialPageRoute(
                //     builder: (context) => TopScore(
                //           topUser: _user_top,
                //           topPoint: _user_top_point,
                //         ))
                // );
              }),
          ListTile(
              title: new Text("Animasi"),
              leading: new Icon(Icons.animation),
              onTap: () {
                Navigator.popAndPushNamed(context, "animasi");
              }),
          ListTile(
              title: new Text("Popular Movie"),
              leading: new Icon(Icons.animation),
              onTap: () {
                Navigator.popAndPushNamed(context, "popularMovie");
              }),
          ListTile(
              title: new Text("Popular Actor"),
              leading: new Icon(Icons.animation),
              onTap: () {
                Navigator.popAndPushNamed(context, "popularActor");
              }),
          ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () {
                doLogout();
              }),
        ],
      ),
    );
  }
}
