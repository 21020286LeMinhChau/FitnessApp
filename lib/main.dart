import 'package:fitness/view/login/login_view.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'common/color_extension.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins",
      ),
      home: const SignUpView(),
    );
  }
}
