// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';

class LoadingPagination extends StatefulWidget {
  const LoadingPagination({Key? key}) : super(key: key);

  @override
  State<LoadingPagination> createState() => _LoadingPaginationState();
}

class _LoadingPaginationState extends State<LoadingPagination> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: ColorHelper.primary,
      ),
    );
  }
}
