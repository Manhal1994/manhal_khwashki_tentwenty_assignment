import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_nav.dart';

class BasicWidget extends StatelessWidget {
  final Widget child;
  const BasicWidget({required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      child,
      const Align(alignment: Alignment.bottomCenter, child: BottomNavigation())
    ])));
  }
}
