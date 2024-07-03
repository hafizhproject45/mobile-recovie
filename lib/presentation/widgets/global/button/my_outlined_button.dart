import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class MyOutlinedButtonWidget extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final double borderRadius;
  final Color buttonColor;
  final Color textColor;
  final Function()? onPressed;

  const MyOutlinedButtonWidget({
    required this.name,
    this.width = 300,
    this.height = 50,
    this.borderRadius = 5,
    this.buttonColor = AppColor.primary,
    this.textColor = AppColor.primary,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        side: BorderSide(color: buttonColor),
        foregroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
