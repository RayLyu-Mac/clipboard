import 'package:flutter/material.dart';

class individual_box extends StatefulWidget {
  final Widget? child;
  individual_box({@required this.child, Key? key}) : super(key: key);

  @override
  State<individual_box> createState() => _individual_boxState();
}

class _individual_boxState extends State<individual_box> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        child: widget.child,
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ));
  }
}
