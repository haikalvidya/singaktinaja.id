import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color? borderColor;
  final Function(String)? onChanged;
  const PrimaryTextField(
      {Key? key,
      this.textEditingController,
      this.obscureText,
      this.hintText,
      this.hintStyle,
      this.prefixIcon,
      this.keyboardType,
      this.inputFormatters,
      this.fillColor,
      this.borderColor,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText ?? '',
        hintStyle: hintStyle ?? const TextStyle(color: Colors.black),
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
    );
  }
}
