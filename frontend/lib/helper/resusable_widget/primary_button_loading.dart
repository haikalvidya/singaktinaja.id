import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';

class PrimaryButtonLoading extends StatelessWidget {
  const PrimaryButtonLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: ColorHelper.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3))
          ]),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
