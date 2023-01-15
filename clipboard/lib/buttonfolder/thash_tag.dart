import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class hashTagButton extends StatefulWidget {
  final void Function()? pres;
  final Widget? label;
  final double? animatWidht;
  final MaterialStateProperty<Color>? istab;

  hashTagButton(
      {@required this.pres,
      @required this.label,
      @required this.istab,
      @required this.animatWidht,
      Key? key})
      : super(key: key);

  @override
  State<hashTagButton> createState() => _hashTagButtonState();
}

class _hashTagButtonState extends State<hashTagButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController hascontroller;

  @override
  void initState() {
    // TODO: implement initState
    hascontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    hascontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        hascontroller.forward();
      },
      onExit: (e) {
        hascontroller.reverse();
      },
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                    side: BorderSide(color: Colors.grey.shade700, width: 4))),
            backgroundColor: widget.istab),
        child: Row(
          children: [
            Lottie.asset("ast/animation/hash.json",
                controller: hascontroller,
                repeat: false,
                width: widget.animatWidht),
            widget.label!
          ],
        ),
        onPressed: widget.pres,
      ),
    );
  }
}
