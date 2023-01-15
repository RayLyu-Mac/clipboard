import 'dart:ffi';

import 'package:clipboard/box_info.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'buttonfolder/thash_tag.dart';
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
import 'math/mostfrq.dart';

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
  final int? tag_num;
  final double? containwidth;
  final bool? fold;

  final List<List>? tagss;
  Clip_search(
      {@required this.controller,
      @required this.fold,
      @required this.comment,
      @required this.searchS,
      @required this.tagss,
      @required this.containwidth,
      @required this.tag_num,
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
  List<String> newtag = [];
  List<List> wholenew = [];
  int isTT = 1;

  List<List> meetingTile = [
    [
      "Meeting With Supervisor",
      "work",
      "2 day",
      1,
      "UI construction",
      "D:/SteamLibrary/Control"
    ],
    [
      "Dept Presentation",
      "work",
      "7 days",
      2,
      "Innovation Presentation",
      "D:/SteamLibrary/Control"
    ],
    [
      "Vector Calculus",
      "study",
      "Inf",
      4,
      "Fundamental for Machine Learning and Deep Learning",
      "https://www.youtube.com/watch?v=4C2PeYoDGpA&t=3006s"
    ],
    [
      "Guitar Lesson",
      "Leisure",
      "Inf",
      5,
      "Learn a new song",
      "https://www.youtube.com/watch?v=4C2PeYoDGpA&t=3006s"
    ]
  ];

  Map<String, String> listTileAni = {
    "work": "ast/animation/work.json",
    "study": "ast/animation/study.json",
    "Leisure": "ast/animation/play.json"
  };

  List<Color> priorityC = [
    Colors.red.shade600,
    Colors.redAccent.shade200,
    Colors.orange.shade300,
    Colors.lightGreenAccent,
    Colors.green.shade400
  ];

  TextEditingController saved_date = TextEditingController();
  String cutime = DateFormat('MM/dd/yyyy').format(DateTime.now());
  ScrollController scrol = ScrollController();
  ScrollController hast = ScrollController();

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
        vsync: this, duration: const Duration(milliseconds: 850));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    acontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.controller!.text.isNotEmpty ? tag_rec() : Container(),
        Container(
          width: widget.containwidth! -
              (widget.controller!.text.isNotEmpty ? _screenWidth / 7 : 0),
          height: _screenH / 1.2,
          child: Column(
            children: [
              Container(
                width: _screenWidth / 1.2,
                height: _screenH / 13,
                margin: EdgeInsets.symmetric(
                    horizontal: _screenWidth / 60, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextField(
                  cursorHeight: 0,
                  autofocus: true,
                  controller: widget.controller,
                  onChanged: search,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: _screenH / 25,
                    fontFamily: "co",
                    color: Colors.black,
                  ),
                ),
              ),
              widget.controller!.text.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: _screenH / 1.35,
                      child: SingleChildScrollView(
                          controller: scrol,
                          child: Column(
                            children: [
                              for (var index = 0;
                                  index < Search_list.length;
                                  index++)
                                individual_box(
                                  fontsize: _screenH / 27,
                                  anIconWid: _screenWidth / 12,
                                  anima: Search_list[index][1]
                                          .toString()
                                          .contains("http")
                                      ? "ast/animation/28595-website-building-lottie-animation.json"
                                      : "ast/animation/21928-folder.json",
                                  title: Search_list[index][0],
                                  subtitile: "\n" +
                                      Search_list[index][2].toString() +
                                      "\n" +
                                      "${Search_list[index][3].split("++")[1] != "Perm" ? "Expire after ${(double.parse(Search_list[index][3].toString().split("++")[1]) - daysBetween(DateFormat("MM/dd/yyyy").parse(Search_list[index][3].toString().split("++")[0].split(":")[1]), DateTime.now())).toInt()} days" : ""}",
                                  onTap: () {
                                    Search_list[index][2] != "Add New Entry"
                                        ? setState(() {
                                            if (Search_list[index][1]
                                                .toString()
                                                .contains("http")) {
                                              launch(Search_list[index][1]
                                                  .toString());
                                              Clipboard.setData(ClipboardData(
                                                  text: Search_list[index][1]
                                                      .toString()));
                                            } else {
                                              Clipboard.setData(ClipboardData(
                                                  text: Search_list[index][1]
                                                      .toString()));
                                              OpenFile.open(Search_list[index]
                                                      [1]
                                                  .toString());
                                            }
                                          })
                                        : widget.controller!.text.isNotEmpty
                                            ? dialog_mode([
                                                Text(
                                                  "Create value for: " +
                                                      widget.controller!.text,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _screenH / 18,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontFamily: "s4"),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                TextFieldForm(
                                                    screenWidth: _screenWidth,
                                                    hint: " Enter value",
                                                    prefix:
                                                        Icons.pending_actions,
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
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        const BoxShadow(
                                                            color: Colors.white,
                                                            offset:
                                                                Offset(-5, -5),
                                                            blurRadius: 18,
                                                            spreadRadius: 1.5),
                                                        BoxShadow(
                                                            color: Colors
                                                                .grey.shade500,
                                                            offset:
                                                                const Offset(
                                                                    5, 5),
                                                            blurRadius: 18,
                                                            spreadRadius: 1.5),
                                                      ]),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors.grey
                                                                    .shade400)),
                                                    child: Text(
                                                      "Add value",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "s3",
                                                          fontSize:
                                                              _screenH / 20),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        add_entries(
                                                          widget
                                                              .controller!.text,
                                                          widget
                                                              .add_value!.text,
                                                          "Created on:" +
                                                              cutime +
                                                              "++${isChecked ? "Perm" : saved_date.text.isNotEmpty ? saved_date.text : 0}",
                                                          widget.comment!.text,
                                                        );
                                                        widget.controller!
                                                            .clear();
                                                        widget.add_value!
                                                            .clear();
                                                        widget.comment!.clear();

                                                        Navigator.pop(context);
                                                        Phoenix.rebirth(
                                                            context);
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
                  : tag_row()
              // Container(
              //     height: _screenH / 1.75,
              //     child: Center(
              //       child: Lottie.asset(
              //           "ast/animation/64947-working-man.json"),
              //     ),
              //   )
            ],
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
                .split(" ")
                .toSet()
                .containsAll(search_string.toLowerCase().split(" ").toSet()) ||
            widget.searchS![i]
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
          "Add New Entry",
          "Created on:${cutime}++Perm"
        ]);
      });
    } else {
      setState(() {
        wholenew = widget.tagss!;
      });
    }
  }

  dialog_mode(List<Widget> dia) {
    return showGeneralDialog(
      barrierColor: Colors.grey.shade50.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 70),
      barrierDismissible: true,
      barrierLabel: "Test",
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return SimpleDialog(
          backgroundColor: Colors.grey.shade300,
          contentPadding: EdgeInsets.fromLTRB(40, 30, 40, 30),
          children: dia,
        );
      },
    );
  }

  checkBmode() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          width: _screenWidth / 1.1,
          height: _screenH / 10,
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
              TextButton(
                  onPressed: (() {
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
                  }),
                  child: Lottie.asset("ast/animation/28294-bookmark.json",
                      fit: BoxFit.cover, controller: acontroller)),
            ],
          ),
        );
      },
    );
  }

  tag_rec() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          width: _screenWidth / 8,
          height: _screenH / 1.2,
          child: SingleChildScrollView(
            controller: hast,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var pops = 0;
                    pops <
                        (newtag.isNotEmpty
                            ? wholenew.length - 1
                            : widget.tag_num!);
                    pops++)
                  Container(
                      margin: EdgeInsets.only(bottom: _screenH / 60),
                      child: hashTag(pops)),
              ],
            ),
          ),
        );
      },
    );
  }

  tag_row() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: _screenH / 25, horizontal: _screenWidth / 60),
          width: _screenWidth / 1.2,
          height: _screenH / 1.5,
          child: SingleChildScrollView(
            controller: hast,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Quick Access",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: _screenH / 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "cd"),
                  ),
                  children: [
                    for (var i = 0; i < meetingTile.length; i++)
                      Container(
                        height: _screenH / 10.5,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: priorityC[meetingTile[i][3] - 1]
                                .withOpacity(0.7),
                            border: Border.all(
                                color: priorityC[meetingTile[i][3] - 1],
                                width: 7),
                            borderRadius: BorderRadius.circular(15)),
                        width: _screenWidth / 1.3,
                        child: ListTile(
                            onTap: () {
                              setState(() {
                                if (meetingTile[i][5]
                                    .toString()
                                    .contains("http")) {
                                  launch(meetingTile[i][5].toString());
                                  Clipboard.setData(ClipboardData(
                                      text: meetingTile[i][5].toString()));
                                } else {
                                  Clipboard.setData(ClipboardData(
                                      text: meetingTile[i][5].toString()));
                                  OpenFile.open(meetingTile[i][5].toString());
                                }
                              });
                            },
                            minLeadingWidth: _screenWidth / 16,
                            title: Text(
                              meetingTile[i][0],
                              style: TextStyle(
                                  fontFamily: "co",
                                  fontWeight: FontWeight.bold,
                                  fontSize: _screenH / 33),
                            ),
                            subtitle: Text(meetingTile[i][4],
                                style: TextStyle(
                                    fontFamily: "co",
                                    fontWeight: FontWeight.bold,
                                    fontSize: _screenH / 40)),
                            leading: Container(
                              width: _screenWidth / 24,
                              child: Lottie.asset(
                                  listTileAni[meetingTile[i][1]]!,
                                  fit: BoxFit.fitWidth),
                            )),
                      )
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Newly Added Tags",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: _screenH / 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "cd"),
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _screenH / 30),
                      width: _screenWidth / 1.2,
                      height: _screenH / 6,
                      child: GridView.count(
                        crossAxisCount: 5,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          for (var pops = 0; pops < 5; pops++) hashTag(pops)
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Most Frequent Used Tags",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: _screenH / 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "cd"),
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _screenH / 30),
                      width: _screenWidth / 1.2,
                      height: _screenH / 3.8,
                      child: GridView.count(
                        crossAxisCount: 5,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          for (var pops = 0;
                              pops <
                                  (newtag.isNotEmpty
                                      ? wholenew.length - 1
                                      : widget.tag_num!);
                              pops++)
                            hashTag(pops)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  hashTag(int pops) {
    return hashTagButton(
        animatWidht: _screenWidth / 24,
        pres: (() {
          setState(() {
            widget.controller!.text.isNotEmpty
                ? widget.controller!.text = widget.controller!.text +
                    " " +
                    (wholenew.isNotEmpty
                        ? wholenew[pops][0].toString()
                        : widget.tagss![pops][0].toString())
                : widget.controller!.text = widget.tagss![pops][0].toString();
          });
          search(widget.controller!.text);
          newtag.clear();
          Search_list.forEach((element) {
            newtag.addAll(element[0].toString().split(" "));
          });
          wholenew = get_most_freq(newtag);
        }),
        istab: MaterialStateProperty.all(Colors.grey.shade300.withOpacity(0.9)),
        label: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            width: _screenWidth / 15,
            child: Text(
              wholenew.isNotEmpty
                  ? (wholenew[pops][0] + "(${wholenew[pops][1]})").toUpperCase()
                  : ((widget.tagss![pops][0].toString() +
                          " (${widget.tagss![pops][1].toString()})"))
                      .toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "co",
                  fontSize: _screenH / 65,
                  color: Colors.grey.shade700),
            )));
  }
}
