import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymovie/resources/images.dart';
import '../../../resources/resources.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: const BoxDecoration(
            color: AppColor.bottomNavigationBg,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27), topRight: Radius.circular(27))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.dashboard,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  Kdashboard,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.54),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.watch,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  kwatch,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.54),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.mediaLibrary,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  KmediaLibrary,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.54),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.more,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  Kmore,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.54),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ));
  }
}
