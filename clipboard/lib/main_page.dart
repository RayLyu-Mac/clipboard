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
    print(clip_keys);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: _screenH,
        child: Row(
          children: [
            Container(
              width: _screenWidth / 5,
              height: _screenH / 3,
              child: clip_info(),
            ),
            IconButton(
                onPressed: (() {
                  dialog_mode([
                    Row(
                      children: [
                        Container(
                            width: _screenWidth / 20,
                            child: TextField(
                              controller: clip__add_key,
                            )),
                        Container(
                          width: _screenWidth / 20,
                          child: TextField(
                            controller: clip__add_value,
                          ),
                        )
                      ],
                    ),
                    RaisedButton.icon(
                        icon: Icon(Icons.add_alarm_rounded),
                        label: Text("Add values"),
                        onPressed: (() {
                          setState(() {
                            add_entries(
                                clip__add_key.text, clip__add_value.text);
                            clip__add_key.clear();
                            clip__add_value.clear();
                          });
                        }))
                  ]);
                }),
                icon: Icon(Icons.add)),
            Container(
              width: _screenWidth / 8,
              child: Clip_search(
                  controller: clip__add_key,
                  searchS: clip_keys,
                  values: clip_Value,
                  add_value: clip__add_value),
            )
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
