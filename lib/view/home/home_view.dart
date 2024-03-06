import 'package:fitness/common/color_extension.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        padding: EdgeInsets.all(50),
        width: 400,
        decoration: BoxDecoration(border: Border.all()),
        child: Text(overflow: TextOverflow.ellipsis, 'Home View'),
      ),
    );
  }
}
