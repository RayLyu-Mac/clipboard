import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class hashTagButton extends StatefulWidget {
  hashTagButton({Key? key}) : super(key: key);

  @override
  State<hashTagButton> createState() => _hashTagButtonState();
}

class _hashTagButtonState extends State<hashTagButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController hascontroller;

  @override
  void initState() {
    // TODO: implement initState
    hascontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
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
      onEnter: (event) {},
    );
  }
}
