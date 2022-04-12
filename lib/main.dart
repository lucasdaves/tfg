import 'package:arquitect/util/colors.dart';
import 'package:arquitect/view/home/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arquitect',
      theme: ThemeData(
        primaryColor: Pallete.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
