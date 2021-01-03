import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hint;
  final bool obsecure;
  const TextFieldContainer({
    Key key, this.icon, this.hint, this.obsecure, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      width: size.width*0.8,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(29)
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: icon,
          hintText: hint,
          border: InputBorder.none,


        ),
        obscureText: obsecure,
        controller: controller,

      ),
    );
  }
}