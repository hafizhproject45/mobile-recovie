// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class MyTextFieldText extends StatelessWidget {
  final String name;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? type;
  final bool? isDate;
  final double? width;
  final IconData? iconz;
  final TextEditingController? controller;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String? value)? validator;

  const MyTextFieldText({
    super.key,
    required this.name,
    this.initialValue,
    this.focusNode,
    this.isDate = false,
    this.textInputAction,
    this.iconz,
    this.controller,
    required this.onFieldSubmitted,
    this.validator,
    this.width = 300,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: width,
      child: TextFormField(
        validator: validator,
        controller: controller,
        initialValue: initialValue,
        focusNode: isDate! ? null : focusNode,
        textInputAction: isDate! ? null : textInputAction,
        enableInteractiveSelection: !isDate!,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: isDate! ? null : type,
        readOnly: isDate!,
        onTap: isDate!
            ? () async {
                DateTime? _picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1500),
                  lastDate: DateTime(DateTime.now().year + 1),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColor.primary,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );
                if (_picked != null && controller != null) {
                  controller!.text = _picked.toString().split(" ")[0];
                }
              }
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconz,
            color: AppColor.textSmall,
          ),
          hintText: name,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
