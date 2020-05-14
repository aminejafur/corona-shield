import 'package:mcovidshield/util/style.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String msg;
  final Function onTap;

  const CustomButton({Key key, this.msg, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: MyColors.grey.withOpacity(0.3),
                offset: Offset(2, 1),
                blurRadius: 2)
          ], color: MyColors.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14),
                child: CustomText(
                  text: msg,
                  color: MyColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}