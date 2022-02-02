import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'hive_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

add_entries(String ckey, String cvalue) {
  final clip_hive = Hive.box("Clip_board");
  clip_hive.add(ClipBoards(ckey, cvalue));
}

class Clip_search extends StatefulWidget {
  final TextEditingController? controller;
  final List? searchS;
  final TextEditingController? add_value;
  final List? values;
  Clip_search(
      {@required this.controller,
      @required this.searchS,
      @required this.values,
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
            border: Border.all(width: 8, color: Colors.blueAccent.shade200),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: search,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade100,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 6,
                              color: Colors.lightBlueAccent.shade400)),
                      child: ListTile(
                        onTap: () {
                          Search_list[index][1] != "Add Value"
                              ? setState(() {
                                  Clipboard.setData(ClipboardData(
                                      text: Search_list[index][1]));
                                  OpenFile.open(
                                      Search_list[index][1].toString());
                                })
                              : dialog_mode([
                                  Text(
                                    "Create value for: " +
                                        widget.controller!.text,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "Enter value"),
                                    controller: widget.add_value,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RaisedButton(
                                      child: Text("Add value"),
                                      onPressed: (() {
                                        setState(() {
                                          add_entries(widget.controller!.text,
                                              widget.add_value!.text);
                                          widget.controller!.clear();
                                          widget.add_value!.clear();
                                          Navigator.pop(context);
                                        });
                                      }))
                                ]);
                        },
                        title: Text(Search_list[index][0]),
                        subtitle: Text(Search_list[index][1]),
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
            Search_list.add([widget.searchS![i], widget.values![i]]);
          });
        }
      }
      setState(() {
        Search_list.add(["Add ${search_string}", "Add Value"]);
      });
    }
  }

  dialog_mode(List<Widget> dia) {
    return showGeneralDialog(
        barrierColor: Colors.blue.shade300.withOpacity(0.8),
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
