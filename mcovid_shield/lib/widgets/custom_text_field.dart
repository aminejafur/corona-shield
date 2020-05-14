import 'package:mcovidshield/util/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType type;
  final bool enabled;
  final TextEditingController controller;
  final bool padding;

  const CustomTextField({Key key, this.hintText, this.icon, this.type, this.enabled, this.controller, this.padding = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: padding ? const EdgeInsets.only(left:12, right: 12, bottom: 12) : EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: MyColors.black, width: 0.2),
             boxShadow: [
              BoxShadow(
                  color: MyColors.grey.withOpacity(0.3),
                  offset: Offset(2, 1),
                  blurRadius: 2
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: TextField(
            enabled: enabled ?? true,
            keyboardType: type,
            controller: controller,
            decoration: InputDecoration(
                icon: Icon(icon, color: MyColors.primary),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: MyColors.primary,
                    fontFamily: "Sen",
                    fontSize: 18
                )
            ),
          ),
        ),
      ),
    );

  }
}