import 'package:fitness/common/color_extension.dart';
import 'package:flutter/material.dart';

class PhotoProgressView extends StatefulWidget {
  const PhotoProgressView({super.key});

  @override
  State<PhotoProgressView> createState() => _PhotoProgressViewState();
}

class _PhotoProgressViewState extends State<PhotoProgressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        padding: EdgeInsets.all(50),
        width: 400,
        decoration: BoxDecoration(border: Border.all()),
        child: Text(overflow: TextOverflow.ellipsis, 'PhotoProgressView'),
      ),
    );
  }
}
