import 'package:flutter/material.dart';

class animate_try extends StatefulWidget {
  animate_try({Key? key}) : super(key: key);

  @override
  State<animate_try> createState() => _animate_tryState();
}

// SingleTickerProviderStateMixin means only one animation controller (more efficient when only one ) TickerProviderStateMixin several
class _animate_tryState extends State<animate_try>
    with SingleTickerProviderStateMixin {
  late final AnimationController acontroller;
  late final Animation animate2;
  bool tap = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animate2 = Tween(begin: -5, end: 5).animate(
        CurvedAnimation(parent: acontroller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    acontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text")),
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: GestureDetector(
            onTap: () {
              tap = !tap;
              print(tap);
              if (tap) {
                acontroller.forward();
              } else {
                acontroller.reverse();
              }
            },
          ),
        ),
      ),
    );
  }
}
