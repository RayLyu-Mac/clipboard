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

class _Clip_searchState extends State<Clip_search> {
  List Search_list = [];
  double _screenWidth = 0;
  double _screenH = 0;
  bool isTab = true;
  bool isChecked = false;
  int isTT = 1;
  String cutime = DateFormat('MM/dd/yyyy').format(DateTime.now());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
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
            ? SingleChildScrollView(
                child: Column(
                children: [
                  for (var index = 0; index < Search_list.length; index++)
                    individual_box(
                      child: ListTile(
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
                                                    "++${isChecked ? 30 : 999}",
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
                        },
                        title: Text(
                          Search_list[index][0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "s1",
                              fontSize: _screenH / 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          "\n" + Search_list[index][2].toString() + "\n",
                          style: TextStyle(
                            fontFamily: "s4",
                            fontSize: _screenH / 34,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                ],
              ))
            : Container()
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
        Search_list.add(["Add ${search_string}", "Add Value", "Comment", ""]);
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

  checkBmode() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return CheckboxListTile(
            subtitle: Text(
                "For short time storage, the entry will automatically delete after 30 days"),
            activeColor: Colors.green,
            checkColor: Colors.lightGreen,
            title: Text(
              isChecked ? "Long Time Storage" : "Short Time Storage(30 days)",
              style: TextStyle(
                  fontFamily: "s4",
                  color: isChecked
                      ? Colors.lime.shade800
                      : Colors.redAccent.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: _screenH / 28),
            ),
            value: isChecked,
            onChanged: (n) {
              setState(() {
                isChecked = !isChecked;
              });
            });
      },
    );
  }
}
