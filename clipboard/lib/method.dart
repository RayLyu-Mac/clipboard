import 'dart:ffi';

import 'package:clipboard/box_info.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:url_launcher/url_launcher.dart';
import 'hive_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'textfield.dart';
import 'inidvi.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

add_entries(String ckey, String cvalue, String storedtime, String Clipcomment) {
  final clip_hive = Hive.box("Clip_board");
  clip_hive.add(ClipBoards(ckey, cvalue, storedtime, Clipcomment));
}

class Clip_search extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? comment;
  final List? searchS;
  final TextEditingController? add_value;
  final List? values;
  final List? clipcomment;
  final List? cliptime;
  Clip_search(
      {@required this.controller,
      @required this.comment,
      @required this.searchS,
      @required this.values,
      @required this.cliptime,
      @required this.clipcomment,
      @required this.add_value,
      Key? key})
      : super(key: key);

  @override
  State<Clip_search> createState() => _Clip_searchState();
}

class _Clip_searchState extends State<Clip_search>
    with SingleTickerProviderStateMixin {
  late final AnimationController acontroller;
  List Search_list = [];
  double _screenWidth = 0;
  double _screenH = 0;
  bool isTab = true;
  bool isChecked = false;
  int isTT = 1;
  TextEditingController saved_date = TextEditingController();
  String cutime = DateFormat('MM/dd/yyyy').format(DateTime.now());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    // TODO: implement initState
    acontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    acontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: TextField(
            autofocus: true,
            controller: widget.controller,
            onChanged: search,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: _screenH / 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Search_list.isNotEmpty && widget.controller!.text.isNotEmpty
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: _screenH / 1.37,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    for (var index = 0; index < Search_list.length; index++)
                      individual_box(
                        fontsize: _screenH / 27,
                        anIconWid: _screenWidth / 8.8,
                        anima: Search_list[index][1].toString().contains("http")
                            ? "https://assets4.lottiefiles.com/packages/lf20_bu69n2ss.json"
                            : "https://assets8.lottiefiles.com/packages/lf20_fx7Gm7.json",
                        title: Search_list[index][0],
                        subtitile: "\n" +
                            Search_list[index][2].toString() +
                            "\n" +
                            "${Search_list[index][3].split("++")[1] != "Perm" ? "Expire after ${(double.parse(Search_list[index][3].toString().split("++")[1]) - daysBetween(DateFormat("MM/dd/yyyy").parse(Search_list[index][3].toString().split("++")[0].split(":")[1]), DateTime.now())).toInt()} days" : ""}",
                        onTap: () {
                          Search_list[index][2] != "Comment"
                              ? setState(() {
                                  if (Search_list[index][1]
                                      .toString()
                                      .contains("http")) {
                                    launch(Search_list[index][1].toString());
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            Search_list[index][1].toString()));
                                  } else {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            Search_list[index][1].toString()));
                                    OpenFile.open(
                                        Search_list[index][1].toString());
                                  }
                                })
                              : widget.controller!.text.isNotEmpty
                                  ? dialog_mode([
                                      Text(
                                        "Create value for: " +
                                            widget.controller!.text,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _screenH / 18,
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: "s4"),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextFieldForm(
                                          screenWidth: _screenWidth,
                                          hint: " Enter value",
                                          prefix: Icons.pending_actions,
                                          value: widget.add_value),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextFieldForm(
                                          screenWidth: _screenWidth,
                                          prefix: Icons.comment_sharp,
                                          hint: " Enter Comment",
                                          value: widget.comment),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      checkBmode(),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        width: _screenWidth / 6,
                                        height: _screenH / 10,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Colors.white,
                                                  offset: const Offset(-5, -5),
                                                  blurRadius: 18,
                                                  spreadRadius: 1.5),
                                              BoxShadow(
                                                  color: Colors.grey.shade500,
                                                  offset: const Offset(5, 5),
                                                  blurRadius: 18,
                                                  spreadRadius: 1.5),
                                            ]),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey.shade400)),
                                          child: Text(
                                            "Add value",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "s3",
                                                fontSize: _screenH / 20),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              add_entries(
                                                widget.controller!.text,
                                                widget.add_value!.text,
                                                "Created on:" +
                                                    cutime +
                                                    "++${isChecked ? saved_date.text : "Perm"}",
                                                widget.comment!.text,
                                              );
                                              widget.controller!.clear();
                                              widget.add_value!.clear();
                                              widget.comment!.clear();

                                              Navigator.pop(context);
                                              Phoenix.rebirth(context);
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ])
                                  : dialog_mode([
                                      const Text(
                                          "Please enter a valid value for the key!")
                                    ]);
                          throw "";
                        },
                      ),
                  ],
                )),
              )
            : Container(
                height: _screenH / 1.75,
                child: Center(
                  child: Lottie.network(
                      "https://assets10.lottiefiles.com/packages/lf20_4wledibb.json"),
                ),
              )
      ],
    );
  }

  void search(String search_string) {
    if (search_string.isNotEmpty) {
      Search_list.clear();

      for (var i = 0; i < widget.searchS!.length; i++) {
        if (widget.searchS![i]
            .toString()
            .toLowerCase()
            .contains(search_string.toLowerCase())) {
          setState(() {
            Search_list.add([
              widget.searchS![i],
              widget.values![i],
              widget.clipcomment![i],
              widget.cliptime![i]
            ]);
          });
        }
      }
      setState(() {
        Search_list.add([
          "Add ${search_string}",
          "Add Value",
          "Comment",
          "Created on:${cutime}++Perm"
        ]);
      });
    }
  }

  dialog_mode(List<Widget> dia) {
    return showGeneralDialog(
        barrierColor: Colors.grey.shade50.withOpacity(0.5),
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
                  child:
                      StatefulBuilder(builder: (context, StateSetter setState) {
                    return SimpleDialog(
                      backgroundColor: Colors.grey.shade300,
                      contentPadding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                      children: dia,
                    );
                  })));
        });
  }

  // checkBmode() {
  //   return StatefulBuilder(
  //     builder: (BuildContext context, setState) {
  //       return CheckboxListTile(
  //           subtitle: Text(
  //               "For short time storage, the entry will automatically delete after 30 days"),
  //           activeColor: Colors.green,
  //           checkColor: Colors.lightGreen,
  //           title: isChecked
  //               ? TextField(
  //                   controller: saved_date,
  //                   decoration: InputDecoration(
  //                       hintText: "How long do you want to save for?"),
  //                   style: TextStyle(
  //                       fontFamily: "s4",
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: _screenH / 27),
  //                 )
  //               : Text(
  //                   "Long Time Storage",
  //                   style: TextStyle(
  //                       fontFamily: "s4",
  //                       color: Colors.green.shade600,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: _screenH / 27),
  //                 ),
  //           value: isChecked,
  //           onChanged: (n) {
  //             setState(() {
  //               isChecked = !isChecked;
  //             });
  //           });
  //     },
  //   );
  // }
  checkBmode() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          width: _screenWidth / 1.1,
          height: _screenH / 10,
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isChecked
                    ? Container(
                        width: _screenWidth / 1.6,
                        child: Text(
                          "Long Time Storage",
                          style: TextStyle(
                              fontFamily: "s4",
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: _screenH / 27),
                        ),
                      )
                    : Container(
                        width: _screenWidth / 1.6,
                        child: TextField(
                          controller: saved_date,
                          decoration: InputDecoration(
                              hintText: "How long do you want to save for?"),
                          style: TextStyle(
                              fontFamily: "s4",
                              fontWeight: FontWeight.bold,
                              fontSize: _screenH / 27),
                        ),
                      ),
                SizedBox(
                  width: _screenWidth / 16,
                ),
                Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_miuJ5n.json",
                    fit: BoxFit.cover,
                    controller: acontroller),
              ],
            ),
            onTap: () {
              setState(
                () {
                  isChecked = !isChecked;
                },
              );

              if (isChecked) {
                acontroller.forward();
              } else {
                acontroller.reverse();
              }
            },
          ),
        );
      },
    );
  }
}
