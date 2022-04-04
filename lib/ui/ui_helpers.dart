import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/resources/resources.dart';
import 'package:mymovie/utils/size_config.dart';

Widget toggleOrientationWidget(
    {required Widget portait, required Widget landscape}) {
  return SizeConfig.isPortrait ? portait : landscape;
}

String toDate(String releseDate) {
  final DateFormat formatter = DateFormat("yyyy-MM-dd");
  var formatted = formatter.parse(releseDate);
  final DateFormat toFormate = DateFormat("MMMM dd, yyyy");
  return toFormate.format(formatted); // something like 2013-04-20
}

Widget responsiveWidget(List<Widget> children) {
  return SizeConfig.isPortrait
      ? Column(
          children: children,
        )
      : Row(
          children: children,
        );
}

Widget mapGenersIdsToWidgets(
  List<Genres> geners,
  int id,
) {
  return Container(
    height: 24,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        color: mapGenersIdToColor(id), borderRadius: BorderRadius.circular(16)),
    child: Center(
      child: Text(
        geners.firstWhere((element) => element.id == id).name ?? "",
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );
}

Color mapGenersIdToColor(int id) {
  var color = Colors.white;
  switch (id) {
    case 28:
      color = AppColor.lightGreen;
      break;
    case 878:
      color = AppColor.darkYellow;
      break;
    case 53:
      color = AppColor.lightPink;
      break;
    default:
      color = Colors.black;
  }
  return color;
}

String mapGenersIdsToText(List<Genres?> geners, int id) {
  String name = "";
  if (geners.isNotEmpty) {
    geners.forEach((element) {
      if (element!.id == id) {
        name = element.name!;
      }
    });
  }
  return name;
}
