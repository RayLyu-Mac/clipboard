import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async' show Future;
import 'method.dart';
import 'dart:io';
import 'hive_base.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'box_info.dart';
import 'package:open_file/open_file.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  TextEditingController clip__add_key = TextEditingController();
  TextEditingController clip__add_value = TextEditingController();
  double _screenWidth = 0;
  double _screenH = 0;
  List clip_keys = [];
  List clip_Value = [];
  bool isfold = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    // TODO: implement initState

    for (var i = 0; i < Hive.box("Clip_board").length; i++) {
      clip_keys.add(Hive.box("Clip_board").getAt(i).keys);
      clip_Value.add(Hive.box("Clip_board").getAt(i).values);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Container(
        height: _screenH,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue.shade100,
                  border:
                      Border.all(width: 10, color: Colors.lightBlue.shade500)),
              width: 330,
              child: Column(
                children: [
                  Text("Search"),
                  Clip_search(
                      controller: clip__add_key,
                      searchS: clip_keys,
                      values: clip_Value,
                      add_value: clip__add_value)
                ],
              ),
            ),
            Container(
              width: 40,
              child: FlatButton(
                  onPressed: (() {
                    setState(() {
                      isfold = !isfold;
                    });
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("History"),
                      Icon(Icons.arrow_right_alt_outlined)
                    ],
                  )),
            ),
            isfold
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade100,
                        border:
                            Border.all(width: 10, color: Colors.blue.shade400)),
                    width: 400,
                    child: clip_info(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  dialog_mode(List<Widget> dia) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                  children: dia,
                ),
              ));
        });
  }
}
