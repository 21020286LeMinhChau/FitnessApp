import 'package:fitness/common/color_extension.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        padding: EdgeInsets.all(50),
        width: 400,
        decoration: BoxDecoration(border: Border.all()),
        child: Text(overflow: TextOverflow.ellipsis, 'ProfileView'),
      ),
    );
  }
}
