import 'package:flutter/material.dart';
import 'textfield.dart';
import 'package:open_file/open_file.dart';
import 'method.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'hive_base.dart';
import 'package:intl/intl.dart';

class clip_info extends StatefulWidget {
  clip_info({Key? key}) : super(key: key);

  @override
  State<clip_info> createState() => _clip_infoState();
}

class _clip_infoState extends State<clip_info> {
  TextEditingController changedvalue = TextEditingController();
  bool changeV = false;
  bool changeC = false;
  String cutime = DateFormat('MM/dd/yyyy').format(DateTime.now());
  @override
  double _screenWidth = 0;
  double _screenH = 0;
  DateTime tod = DateTime.now();
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
              itemCount: clips.length,
              itemExtent: 150,
              itemBuilder: ((context, index) {
                final clip = clips.getAt(index);

                if (clip.times.split("++")[1] == "30") {
                  if (daysBetween(
                          DateFormat("MM/dd/yyyy")
                              .parse(clip.times.split("++")[0].split(":")[1]),
                          tod) >
                      30) {
                    clips.deleteAt(index);
                  }
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    subtitle: Text(
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
                    trailing: Container(
                      width: _screenWidth / 14,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    context: context,
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Container();
                                    },
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: SimpleDialog(
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        43, 33, 43, 33),
                                                title: Row(
                                                  children: [
                                                    const Text(
                                                      "Change ",
                                                      style: TextStyle(
                                                          fontFamily: "s3",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 42),
                                                    ),
                                                    changeValue(),
                                                    changeComment()
                                                    // FlatButton(
                                                    //     color: changeC
                                                    //         ? Colors.lightGreen
                                                    //         : Colors
                                                    //             .grey.shade300,
                                                    //     onPressed: () {
                                                    //       setState(() {
                                                    //         changeV = false;
                                                    //         changeC = true;
                                                    //       });
                                                    //     },
                                                    //     child: const Text(
                                                    //       "Comment ",
                                                    //       style: TextStyle(
                                                    //           fontFamily: "s3",
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .bold,
                                                    //           fontSize: 42),
                                                    //     ))
                                                  ],
                                                ),
                                                children: [
                                                  //oldValue(clip),

                                                  TextFieldForm(
                                                      screenWidth: _screenWidth,
                                                      value: changedvalue,
                                                      hint:
                                                          "Please Enter the new value",
                                                      prefix:
                                                          Icons.change_history),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  RaisedButton.icon(
                                                      color:
                                                          Colors.grey.shade600,
                                                      onPressed: () {
                                                        setState(() {
                                                          clips.putAt(
                                                              index,
                                                              ClipBoards(
                                                                  clip.keys
                                                                      .toString(),
                                                                  changeV
                                                                      ? changedvalue
                                                                          .text
                                                                      : clip
                                                                          .values
                                                                          .toString(),
                                                                  "Updated on:" +
                                                                      cutime
                                                                          .toString() +
                                                                      "++" +
                                                                      clip.times
                                                                              .split("++")[
                                                                          1],
                                                                  changeC
                                                                      ? changedvalue
                                                                          .text
                                                                      : clip
                                                                          .comment
                                                                          .toString()));
                                                        });
                                                        Navigator.pop(context);
                                                        changedvalue.clear();
                                                        changeC = false;
                                                        changeV = false;
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Colors
                                                            .grey.shade100,
                                                        size: 45,
                                                      ),
                                                      label: Text(
                                                        "Change value",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade100,
                                                            fontFamily: "s4",
                                                            fontSize: 35),
                                                      ))
                                                ],
                                              )));
                                    });
                              },
                              icon: Icon(Icons.change_circle_outlined)),
                          IconButton(
                            highlightColor: Colors.grey.shade400,
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.blueGrey.shade500,
                              size: 30,
                            ),
                            onPressed: () {
                              showGeneralDialog(
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionDuration:
                                      Duration(milliseconds: 300),
                                  barrierDismissible: true,
                                  barrierLabel: '',
                                  context: context,
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return Container();
                                  },
                                  transitionBuilder: (context, a1, a2, widget) {
                                    return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                            opacity: a1.value,
                                            child: SimpleDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(25),
                                                titlePadding:
                                                    const EdgeInsets.all(15),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.warning,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Delete ${clip.keys.toString()} ?",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                          padding: EdgeInsets
                                                              .fromLTRB(48, 15,
                                                                  48, 15),
                                                          splashColor: Colors
                                                              .white
                                                              .withOpacity(0.7),
                                                          color: Colors
                                                              .greenAccent
                                                              .shade100,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Icon(
                                                              Icons.backspace),
                                                          label: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 32,
                                                                fontFamily:
                                                                    "s3"),
                                                          )),
                                                      SizedBox(
                                                        width: 40,
                                                      ),
                                                      FlatButton.icon(
                                                          padding: EdgeInsets
                                                              .fromLTRB(48, 15,
                                                                  48, 15),
                                                          splashColor: Colors
                                                              .white
                                                              .withOpacity(0.7),
                                                          color: Colors
                                                              .redAccent
                                                              .shade100,
                                                          onPressed: () {
                                                            clips.deleteAt(
                                                                index);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Icon(
                                                              Icons.delete),
                                                          label: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                fontSize: 32,
                                                                fontFamily:
                                                                    "s3"),
                                                          )),
                                                    ],
                                                  )
                                                ])));
                                  });
                            },
                          ),
                        ],
                      ),
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
              }));
        });
    ;
  }

  changeValue() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return FlatButton(
            color: changeV ? Colors.greenAccent.shade200 : Colors.grey.shade200,
            onPressed: () {
              setState(() {
                changeV = !changeV;
              });
            },
            child: Text(
              "Value",
              style: TextStyle(
                  fontFamily: "s3", fontWeight: FontWeight.bold, fontSize: 42),
            ));
      },
    );
  }

  changeComment() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return FlatButton(
            color: changeC ? Colors.greenAccent.shade200 : Colors.grey.shade200,
            onPressed: () {
              setState(() {
                changeC = !changeC;
              });
            },
            child: Text(
              "Comment",
              style: TextStyle(
                  fontFamily: "s3", fontWeight: FontWeight.bold, fontSize: 42),
            ));
      },
    );
  }

  oldValue(clip) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return changeV
            ? Text(
                "Old value:\n${clip.values.toString()}",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "b1", fontSize: 30),
              )
            : changeC
                ? Text("Old Comment:\n${clip.comment.toString()}")
                : Text("Please select the property you want to change");
      },
    );
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
