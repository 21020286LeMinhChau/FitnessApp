import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'common/color_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig

  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCUi9eIq5KurHVH7avmnpPNpvamTaFmN0s",
      appId: "1:641894441936:android:0a32ccaa07577dcb890fd5",
      messagingSenderId: "641894441936",
      projectId: "fitnessapp-93613",
    ));
    print('Firebase initialized successfully');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
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
