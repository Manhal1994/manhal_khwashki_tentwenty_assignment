import 'package:flutter/material.dart';
import 'package:mymovie/resources/resources.dart';

Widget topResultsLabelWidget() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const Text(
          KtopResults,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.searchTextColor),
        )),
    Container(
      height: 1,
      width: double.infinity,
      color: Colors.white.withOpacity(0.11),
    )
  ]);
}
