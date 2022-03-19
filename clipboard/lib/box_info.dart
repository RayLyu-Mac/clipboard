import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'textfield.dart';
import 'package:open_file/open_file.dart';
import 'method.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'hive_base.dart';
import 'package:intl/intl.dart';
import 'buttonfolder/deletebu.dart';

class clip_info extends StatefulWidget {
  clip_info({Key? key}) : super(key: key);

  @override
  State<clip_info> createState() => _clip_infoState();
}

class _clip_infoState extends State<clip_info> {
  late final AnimationController acontrol1;
  late final AnimationController acontrol2;

  TextEditingController changedvalue = TextEditingController();
  bool changeC = false;
  String cutime = DateFormat('MM/dd/yyyy').format(DateTime.now());
  @override
  double _screenWidth = 0;
  double _screenH = 0;
  DateTime tod = DateTime.now();
  bool hovering1 = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
  }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  Widget build(BuildContext context) {
    return WatchBoxBuilder(
        box: Hive.box("Clip_board"),
        builder: (context, clips) {
          return ListView.builder(
              dragStartBehavior: DragStartBehavior.down,
              itemCount: clips.length,
              itemExtent: _screenH / 4,
              itemBuilder: ((context, index) {
                final clip = clips.getAt(index);

                int daydiff = daysBetween(
                    DateFormat("MM/dd/yyyy")
                        .parse(clip.times.split("++")[0].split(":")[1]),
                    tod);

                if (clip.times.split("++")[1] != "Perm" &&
                    daydiff > double.parse(clip.times.split("++")[1])) {
                  clips.deleteAt(index);
                  return Container();
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      color: clip.times.split("++")[1] == "30"
                          ? Colors.grey.shade200
                          : Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade50,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1),
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        "Key:" + clip.keys.toString(),
                        style: TextStyle(
                          fontFamily: "b1",
                          fontSize: 22,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _screenWidth / 5.5,
                            child: Text(
                              " \n" +
                                  clip.comment.toString() +
                                  " \n" +
                                  clip.times.toString().split("++")[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "b1",
                                color: Colors.grey.shade600,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _screenWidth / 18,
                          ),
                          delete_button(
                              height: _screenH / 7.3,
                              childs: SimpleDialog(
                                backgroundColor: Colors.grey.shade300,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(43, 33, 43, 33),
                                title: Row(
                                  children: [
                                    const Text(
                                      "Change ",
                                      style: TextStyle(
                                          fontFamily: "s3",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 42),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    changeComment()
                                  ],
                                ),
                                children: [
                                  //oldValue(clip),

                                  TextFieldForm(
                                      screenWidth: _screenWidth,
                                      value: changedvalue,
                                      hint: "New Value/Key",
                                      prefix: Icons.change_history),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  RaisedButton.icon(
                                      color: Colors.grey.shade600,
                                      onPressed: () {
                                        dialog_mode([
                                          Title(
                                              color: Colors.grey.shade600,
                                              child: Text(
                                                changeC
                                                    ? "Change Key"
                                                    : "Change Value",
                                                style: TextStyle(
                                                    fontFamily: "s1",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _screenH / 25),
                                              )),
                                          SizedBox(
                                            height: _screenH / 30,
                                          ),
                                          Text(
                                            changeC
                                                ? clip.keys.toString()
                                                : clip.values.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "b1",
                                                fontWeight: FontWeight.bold,
                                                fontSize: _screenH / 32),
                                          ),
                                          Text("To\n" + changedvalue.text,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "b1",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: _screenH / 32)),
                                          SizedBox(
                                            height: _screenH / 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      clips.putAt(
                                                          index,
                                                          ClipBoards(
                                                              changeC
                                                                  ? changedvalue
                                                                      .text
                                                                  : clip.keys
                                                                      .toString(),
                                                              changeC
                                                                  ? clip.values
                                                                      .toString()
                                                                  : changedvalue
                                                                      .text,
                                                              "Updated on:" +
                                                                  cutime
                                                                      .toString() +
                                                                  "++" +
                                                                  clip.times.split(
                                                                      "++")[1],
                                                              clip.comment
                                                                  .toString()));
                                                    });
                                                    Navigator.pop(context);
                                                    changedvalue.clear();
                                                    changeC = false;
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        fontFamily: "s1",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _screenH / 29),
                                                  )),
                                              SizedBox(
                                                width: _screenWidth / 40,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" Cancel ",
                                                      style: TextStyle(
                                                          fontFamily: "s1",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              _screenH / 29)))
                                            ],
                                          )
                                        ]);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade100,
                                        size: 45,
                                      ),
                                      label: Text(
                                        "Change value",
                                        style: TextStyle(
                                            color: Colors.grey.shade100,
                                            fontFamily: "s4",
                                            fontSize: 35),
                                      ))
                                ],
                              ),
                              width: _screenWidth / 14,
                              anim:
                                  "ast/animation/5473-loading-21-pencil.json"),
                          delete_button(
                              height: _screenH / 7.3,
                              childs: SimpleDialog(
                                  contentPadding: const EdgeInsets.all(25),
                                  titlePadding: const EdgeInsets.all(15),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Delete ${clip.keys.toString()} ?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "s1",
                                            fontSize: 30,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                  children: [
                                    Row(
                                      children: [
                                        FlatButton.icon(
                                            padding: EdgeInsets.fromLTRB(
                                                48, 15, 48, 15),
                                            splashColor:
                                                Colors.white.withOpacity(0.7),
                                            color: Colors.greenAccent.shade100,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.backspace),
                                            label: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: "s3"),
                                            )),
                                        SizedBox(
                                          width: _screenWidth / 20,
                                        ),
                                        FlatButton.icon(
                                            padding: const EdgeInsets.fromLTRB(
                                                48, 15, 48, 15),
                                            splashColor:
                                                Colors.white.withOpacity(0.7),
                                            color: Colors.redAccent.shade100,
                                            onPressed: () {
                                              clips.deleteAt(index);

                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.delete),
                                            label: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: "s3"),
                                            )),
                                      ],
                                    )
                                  ]),
                              width: _screenWidth / 20,
                              anim: "ast/animation/57979-delete.json")
                        ],
                      ),
                      onTap: () {
                        if (clip.values.toString().contains("http")) {
                          launch(clip.values.toString());
                          Clipboard.setData(
                              ClipboardData(text: clip.values.toString()));
                        } else {
                          Clipboard.setData(
                              ClipboardData(text: clip.values.toString()));
                          OpenFile.open(clip.values.toString());
                        }
                      },
                    ),
                  );
                }
              }));
        });
  }

  changeComment() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return FlatButton(
            onPressed: () {
              setState(() {
                changeC = !changeC;
              });
            },
            child: Text(
              changeC ? "Key" : "Value",
              style: TextStyle(
                  fontFamily: "s3", fontWeight: FontWeight.bold, fontSize: 42),
            ));
      },
    );
  }

  // oldValue(clip) {
  //   return StatefulBuilder(
  //     builder: (BuildContext context, setState) {
  //       return changeV
  //           ? Text(
  //               "Old value:\n${clip.values.toString()}",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontFamily: "b1", fontSize: 30),
  //             )
  //           : changeC
  //               ? Text("Old Comment:\n${clip.comment.toString()}")
  //               : Text("Please select the property you want to change");
  //     },
  //   );

  baner(w) {
    return Container(
      child: ListTile(
        title: Text(w),
      ),
      height: _screenH / 20,
      width: _screenWidth / 5,
      color: Colors.green,
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

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
