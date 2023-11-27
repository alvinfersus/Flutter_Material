import 'dart:async';

import 'package:flutter/material.dart';

class Animasi extends StatefulWidget {
  const Animasi({Key? key}) : super(key: key);

  @override
  _AnimasiState createState() => _AnimasiState();
}

class _AnimasiState extends State<Animasi> {
  bool animated = false;
  late Timer _timer;
  double opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        animated = !animated;
        if (opacityLevel == 1.0) {
          opacityLevel = 0.0;
        } else {
          opacityLevel = 1.0;
        }
      });
    });
  }

  Widget widget1() {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          "Click me!",
          style: TextStyle(fontSize: 30),
        ));
  }

  Widget widget2() {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Click me!",
          style: TextStyle(fontSize: 30),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation")),
      body: ListView(children: [
        Container(
            width: 250.0,
            height: 250.0,
            child: AnimatedAlign(
              alignment: animated ? Alignment.topRight : Alignment.bottomLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Image.network('https://placekitten.com/100/100?image=12'),
            )),
        Container(
            width: 250.0,
            height: 250.0,
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: const Duration(seconds: 3),
              child: Image.network('https://placekitten.com/240/240?image=10'),
            )),
        AnimatedContainer(
          height: animated ? 200 : 300,
          margin: EdgeInsets.all(50),
          decoration: animated
              ? BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage('https://placekitten.com/400/400?image=8'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 10,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage('https://placekitten.com/400/400?image=7'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.amber,
                    width: 5,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
          duration: const Duration(seconds: 3),
          curve: Curves.fastOutSlowIn,
        ),
        Center(
            child: AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: Image(
              image: AssetImage("assets/images/mark.jpeg"),
              fit: BoxFit.fitWidth,
              width: 200,
              height: 240),
          secondChild: Image(
              image: AssetImage("assets/images/hulk.jpeg"),
              fit: BoxFit.fitWidth,
              width: 200,
              height: 240),
          crossFadeState:
              animated ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )),
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(child: child, turns: animation);
            //return ScaleTransition(child: child, scale: animation);
          },
          child: animated ? widget1() : widget2(),
        ),
        AnimatedDefaultTextStyle(
          child: Center(child: Text('Hello')),
          style: animated
              ? TextStyle(
                  color: Colors.blue,
                  fontSize: 60,
                )
              : TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
          duration: Duration(milliseconds: 1000),
        ),
        TextButton(
          child: Text('Animate'),
          onPressed: () {
            setState(() {
              animated = !animated;
            });
          },
        )
      ]),
    );
  }
}
