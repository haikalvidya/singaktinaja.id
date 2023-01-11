import 'package:flutter/material.dart';

import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class SecoundaryButton extends StatelessWidget {
  String? text;
  final Function()? onPressed;

  SecoundaryButton({
    super.key,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorHelper.primary,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: ColorHelper.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
