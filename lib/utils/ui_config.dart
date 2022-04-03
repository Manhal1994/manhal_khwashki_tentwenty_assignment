import 'package:flutter/material.dart';
import 'package:mymovie/utils/size_config.dart';

class UICongig extends StatelessWidget {
  final Widget child;
  const UICongig({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return OrientationBuilder(builder: (contexr, oriention) {
          SizeConfig().init(constraint, oriention);

          return child;
        });
      },
    );
  }
}
