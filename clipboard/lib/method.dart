import 'package:hive/hive.dart';
import 'hive_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

add_entries(String ckey, String cvalue) {
  final clip_hive = Hive.box("Clip_board");
  clip_hive.add(ClipBoards(ckey, cvalue));
}

class Clip_search extends StatefulWidget {
  final TextEditingController? controller;
  final List<String>? searchS;
  final List<String>? values;
  Clip_search(
      {@required this.controller,
      @required this.searchS,
      @required this.values,
      Key? key})
      : super(key: key);

  @override
  State<Clip_search> createState() => _Clip_searchState();
}

class _Clip_searchState extends State<Clip_search> {
  double _screenWidth = 0;
  double _screenH = 0;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
  }

  List Search_list = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              color: Colors.grey.shade200,
            ),
          ),
        ),
        Search_list.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: Search_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: _screenWidth / 75),
                        margin: EdgeInsets.only(top: _screenH / 65),
                        child: ListTile(
                          title: Search_list[index][0],
                          subtitle: Search_list[index][1],
                        ),
                      );
                    }))
            : Container()
      ],
    );
  }

  void search(String search_string) {
    Search_list.clear();
    for (var i = 0; i < widget.searchS!.length; i++) {
      if (widget.searchS![i]
          .toLowerCase()
          .contains(search_string.toLowerCase())) ;
      setState(() {
        Search_list.add([widget.searchS![i], widget.values![i]]);
      });
    }
  }
}
