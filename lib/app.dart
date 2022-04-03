import 'package:flutter/material.dart';
import 'package:mymovie/ui/screens/home.dart';
import 'package:mymovie/utils/ui_config.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UICongig(
        child: MaterialApp(
      title: 'MyMovies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const Home(),
    ));
  }
}
