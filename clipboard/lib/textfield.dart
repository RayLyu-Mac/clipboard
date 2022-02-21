import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  final double? screenWidth;
  final TextEditingController? value;
  final String? hint;
  final IconData? prefix;

  TextFieldForm(
      {@required this.screenWidth,
      @required this.value,
      @required this.hint,
      @required this.prefix,
      Key? key})
      : super(key: key);

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool istab = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
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
      width: widget.screenWidth! / 2,
      child: TextField(
        autofocus: true,
        style: TextStyle(
            fontSize: 35,
            color: Colors.grey.shade800,
            fontFamily: "b1",
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(widget.prefix),
            hintText: widget.hint),
        controller: widget.value,
      ),
    );
  }
}
