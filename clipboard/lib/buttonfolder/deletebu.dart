import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class delete_button extends StatefulWidget {
  final Widget? childs;
  final String? anim;
  final double? width;
  final double? height;
  delete_button(
      {@required this.childs,
      @required this.width,
      @required this.height,
      @required this.anim,
      Key? key})
      : super(key: key);

  @override
  State<delete_button> createState() => _delete_buttonState();
}

class _delete_buttonState extends State<delete_button>
    with SingleTickerProviderStateMixin {
  late final AnimationController acontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    acontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: MouseRegion(
        onEnter: (event) {
          acontroller.forward();
        },
        onExit: (e) {
          acontroller.reverse();
        },
        child: TextButton(
            child: Lottie.asset(
              widget.anim!,
              fit: BoxFit.cover,
              frameRate: FrameRate(40),
              height: widget.width,
              controller: acontroller,
            ),
            onPressed: () {
              showGeneralDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 300),
                  barrierDismissible: true,
                  barrierLabel: '',
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Container();
                  },
                  transitionBuilder: (context, a1, a2, widgets) {
                    return Transform.scale(
                      scale: a1.value,
                      child: Opacity(opacity: a1.value, child: widget.childs),
                    );
                  });
            }),
      ),
    );
  }
}
