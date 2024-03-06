import 'package:fitness/common/color_extension.dart';
import 'package:flutter/material.dart';

class SelectView extends StatefulWidget {
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        padding: EdgeInsets.all(50),
        width: 400,
        decoration: BoxDecoration(border: Border.all()),
        child: Text(overflow: TextOverflow.ellipsis, 'SelectView'),
      ),
    );
  }
}
