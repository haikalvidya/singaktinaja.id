// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';

class ErrorButton extends StatefulWidget {
  final Function()? onPressed;
  const ErrorButton({Key? key, this.onPressed}) : super(key: key);

  @override
  State<ErrorButton> createState() => _ErrorButtonState();
}

class _ErrorButtonState extends State<ErrorButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: PrimaryButton(
          onPressed: widget.onPressed,
          text: 'Coba Lagi',
        ),
      ),
    );
  }
}
