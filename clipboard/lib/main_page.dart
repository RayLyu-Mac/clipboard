import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async' show Future;
import 'method.dart';
import 'dart:io';
import 'hive_base.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'box_info.dart';
import 'package:file_picker/file_picker.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  TextEditingController clip__add_key = TextEditingController();
  TextEditingController clip__add_value = TextEditingController();
  TextEditingController clip_comment = TextEditingController();
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
      backgroundColor: Colors.grey.shade50,
      body: Container(
        height: _screenH,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                  border: Border.all(width: 10, color: Colors.grey.shade300)),
              width: _screenWidth / 2.2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Search",
                        style: TextStyle(
                          fontFamily: "s3",
                          fontSize: _screenH / 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  Clip_search(
                      controller: clip__add_key,
                      searchS: clip_keys,
                      values: clip_Value,
                      comment: clip_comment,
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
                  child: const Icon(Icons.arrow_right_alt_outlined)),
            ),
            isfold
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    width: _screenWidth / 2.2,
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
