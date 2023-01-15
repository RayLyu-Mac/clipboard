import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'math/mostfrq.dart';
import 'method.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'box_info.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  TextEditingController clip__add_key = TextEditingController();
  TextEditingController clip__add_value = TextEditingController();
  TextEditingController clip_comment = TextEditingController();
  double _screenWidth = 0;
  double _screenH = 0;
  List clip_keys = [];
  List clip_Value = [];
  List clip_comments = [];
  List clip_times = [];
  List<String> tags = [];
  int popular = 0;

  bool isfold = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    // TODO: implement initState

    for (var i = 0; i < Hive.box("Clip_board").length; i++) {
      String k = Hive.box("Clip_board").getAt(i).keys;
      clip_keys.add(k);
      tags.addAll(k.split(" "));
      clip_Value.add(Hive.box("Clip_board").getAt(i).values);
      clip_comments.add(Hive.box("Clip_board").getAt(i).comment);
      clip_times.add(Hive.box("Clip_board").getAt(i).times);
    }
    tags.length > 10 ? popular = 10 : popular = tags.length;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    clip__add_key.dispose();
    clip__add_value.dispose();
    clip_comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        height: _screenH,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: Curves.easeInCirc,
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                  border: Border.all(width: 10, color: Colors.grey.shade300)),
              width: isfold ? _screenWidth / 2.18 : _screenWidth / 1.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Find U File & Web",
                        style: TextStyle(
                          fontFamily: "cd",
                          fontWeight: FontWeight.w900,
                          fontSize: _screenH / 17,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Container(
                        width: _screenWidth / 14,
                        child: TextButton(
                          onPressed: (() {
                            setState(() {
                              isfold = !isfold;
                            });
                          }),
                          child: Lottie.asset(
                              "ast/animation/94539-order-history.json",
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                      // Container(
                      //   width: _screenWidth / 14,
                      //   child: TextButton(
                      //     onPressed: (() {
                      //       setState(() {
                      //         isfold = !isfold;
                      //       });
                      //     }),
                      //     child: Lottie.asset("ast/animation/met.json",
                      //         fit: BoxFit.fitWidth),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //     child: Text("Test"),
                      //     onPressed: (() {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => animate_try()));
                      //     }))
                    ],
                  ),
                  Clip_search(
                      controller: clip__add_key,
                      fold: isfold,
                      tagss: get_most_freq(tags),
                      searchS: clip_keys,
                      containwidth:
                          isfold ? _screenWidth / 2.18 : _screenWidth / 1.2,
                      values: clip_Value,
                      comment: clip_comment,
                      clipcomment: clip_comments,
                      tag_num: popular,
                      cliptime: clip_times,
                      add_value: clip__add_value)
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              width: isfold ? _screenWidth / 2.38 : 0,
              child: clip_info(),
            ),
          ],
        ),
      ),
    );
  }

  dialog_mode(List<Widget> dia) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
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
                  contentPadding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
                  children: dia,
                ),
              ));
        });
  }
}
