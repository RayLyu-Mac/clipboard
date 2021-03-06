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

  final List<List>? tagss;
  Clip_search(
      {@required this.controller,
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
    super.dispose();
    acontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        tag_rec(),
        Container(
          width: widget.containwidth! - _screenWidth / 7,
          height: _screenH / 1.2,
          child: Column(
            children: [
              Container(
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextField(
                  autofocus: true,
                  controller: widget.controller,
                  onChanged: search,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: _screenH / 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              widget.controller!.text.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: _screenH / 1.4,
                      child: SingleChildScrollView(
                          controller: scrol,
                          child: Column(
                            children: [
                              for (var index = 0;
                                  index < Search_list.length;
                                  index++)
                                individual_box(
                                  fontsize: _screenH / 27,
                                  anIconWid: _screenWidth / 16,
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
                                    Search_list[index][2] != "Comment"
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
                  : Container(
                      height: _screenH / 1.75,
                      child: Center(
                        child: Lottie.asset(
                            "ast/animation/64947-working-man.json"),
                      ),
                    )
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
          "Comment",
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
          width: _screenWidth / 9,
          height: _screenH / 1.2,
          child: SingleChildScrollView(
            controller: hast,
            child: Column(
              children: [
                Text(
                  "Tags Used Most frequently",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _screenH / 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "b1"),
                ),
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
            width: _screenWidth / 21,
            child: Text(
              wholenew.isNotEmpty
                  ? (wholenew[pops][0] + "(${wholenew[pops][1]})")
                  : (widget.tagss![pops][0].toString() +
                      " (${widget.tagss![pops][1].toString()})"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _screenH / 55,
                  color: Colors.grey.shade700),
            )));
  }
}
