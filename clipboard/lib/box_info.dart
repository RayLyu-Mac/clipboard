import 'package:flutter/material.dart';

import 'package:open_file/open_file.dart';
import 'method.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'hive_base.dart';

Widget clip_info() {
  return WatchBoxBuilder(
      box: Hive.box("Clip_board"),
      builder: (context, clips) {
        return ListView.builder(
            itemCount: clips.length,
            itemExtent: 150,
            itemBuilder: ((context, index) {
              final clip = clips.getAt(index);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
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
                  trailing: IconButton(
                    highlightColor: Colors.grey.shade400,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.blueGrey.shade500,
                      size: 30,
                    ),
                    onPressed: () {
                      showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 300),
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
                                        titlePadding: const EdgeInsets.all(15),
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
                                                  splashColor: Colors.white
                                                      .withOpacity(0.7),
                                                  color: Colors
                                                      .greenAccent.shade100,
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
                                                width: 50,
                                              ),
                                              FlatButton.icon(
                                                  padding: EdgeInsets.fromLTRB(
                                                      48, 15, 48, 15),
                                                  splashColor: Colors.white
                                                      .withOpacity(0.7),
                                                  color:
                                                      Colors.redAccent.shade100,
                                                  onPressed: () {
                                                    clips.deleteAt(index);

                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.delete),
                                                  label: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        fontSize: 32,
                                                        fontFamily: "s3"),
                                                  )),
                                            ],
                                          )
                                        ])));
                          });
                    },
                  ),
                  onTap: () {
                    if (clip.values.toString().split("+")[0].substring(0, 4) ==
                        "http") {
                      launch(clip.values.toString().split("+")[0]);
                    } else {
                      Clipboard.setData(ClipboardData(
                          text: clip.values.toString().split("+")[0]));
                      OpenFile.open(clip.values.toString().split("+")[0]);
                    }
                  },
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
                    " \n" + clip.values.toString().split("+")[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "b1",
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }));
      });
}
