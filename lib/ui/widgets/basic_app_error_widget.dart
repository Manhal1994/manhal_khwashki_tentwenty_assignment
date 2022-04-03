import 'package:flutter/material.dart';

class BasicAppErrorWidget extends StatelessWidget {
  final String message;
  BasicAppErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red.shade700),
      ),
    );
  }
}
