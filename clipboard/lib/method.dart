import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'hive_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 12, color: Colors.grey.shade200),
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
        SizedBox(
          height: _screenH / 70,
        ),
        Search_list.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                children: [
                  for (var index = 0; index < Search_list.length; index++)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(width: 10, color: Colors.green)),
                      child: ListTile(
                        onTap: () {
                          Search_list[index][1] != "Add Value"
                              ? Clipboard.setData(
                                  ClipboardData(text: Search_list[index][1]))
                              : dialog_mode([
                                  TextField(
                                    controller: widget.add_value,
                                  ),
                                  RaisedButton(
                                      child: Text("Add value"),
                                      onPressed: (() {
                                        setState(() {
                                          add_entries(widget.controller!.text,
                                              widget.add_value!.text);
                                          widget.controller!.clear();
                                          widget.add_value!.clear();
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
            : Container(
                child: Text(Search_list.toString()),
              )
      ],
    );
  }

  void search(String search_string) {
    if (search_string.isNotEmpty) {
      Search_list.clear();
      setState(() {
        Search_list.add(["Add ${search_string}", "Add Value"]);
      });

      for (var i = 0; i < widget.searchS!.length; i++) {
        if (widget.searchS![i]
            .toString()
            .toLowerCase()
            .contains(search_string.toLowerCase())) {
          setState(() {
            print("A");
            Search_list.add([widget.searchS![i], widget.values![i]]);
          });
        }
      }
    }
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
