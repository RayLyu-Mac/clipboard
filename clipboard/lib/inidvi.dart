import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class individual_box extends StatefulWidget {
  final Void Function()? onTap;
  final String? title;
  final String? subtitile;
  final double? fontsize;
  final String? anima;
  final double? anIconWid;

  individual_box(
      {@required this.onTap,
      @required this.subtitile,
      @required this.anIconWid,
      @required this.title,
      @required this.fontsize,
      @required this.anima,
      Key? key})
      : super(key: key);

  @override
  State<individual_box> createState() => _individual_boxState();
}

class _individual_boxState extends State<individual_box>
    with SingleTickerProviderStateMixin {
  late final AnimationController acon;
  bool hover = false;

  ishover(hovering) {
    setState(() {
      hover = hovering;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    acon = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2100));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        acon.forward();
        ishover(true);
      },
      onExit: (e) {
        acon.reverse();
        ishover(false);
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: ListTile(
            trailing: Lottie.network(widget.anima!,
                controller: acon, width: widget.anIconWid),
            subtitle: Text(
              widget.subtitile!,
              style: TextStyle(
                fontFamily: "s4",
                fontSize: widget.fontsize! * 0.75,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              widget.title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "s1",
                  fontSize: widget.fontsize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  decoration: TextDecoration.underline),
            ),
            onTap: widget.onTap,
          ),
          margin: EdgeInsets.symmetric(
              vertical: widget.anIconWid! * 0.045, horizontal: 12),
          padding: EdgeInsets.symmetric(
              horizontal: widget.anIconWid! * 0.01,
              vertical: widget.anIconWid! * 0.065),
          decoration: BoxDecoration(
            color: hover ? Colors.green.shade50 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                width: 4,
                color: hover ? Colors.green.shade300 : Colors.transparent),
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
          )),
    );
  }
}
