import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/login/login_view.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'common/color_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

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

  // Future<void> checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     // Navigator.of(context).pushReplacement(
  //     //     new MaterialPageRoute(builder: (context) => new SignUpView()));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     // Navigator.of(context).pushReplacement(
  //     //     new MaterialPageRoute(builder: (context) => new WelcomeView()));
  //   }
  // }

  // Future<String?> getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('user_id');
  // }
  Future<Tuple2<bool, String?>> checkFirstSeenAndGetUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (!_seen) {
      await prefs.setBool('seen', true);
      return Tuple2(_seen, null);
    }

    String? userId = prefs.getString('user_id');
    return Tuple2(_seen, userId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins",
      ),
      // home: FutureBuilder<String?>(
      //   future: getUserId(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const CircularProgressIndicator();
      //     }
      //     if (snapshot.hasData) {
      //       return const MainTabView();
      //     }
      //     return const LoginView();
      //   },
      // ),
      home: FutureBuilder<Tuple2<bool, String?>>(
        future: checkFirstSeenAndGetUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            bool _seen = snapshot.data!.item1;
            if (!_seen) {
              return const StartedView();
            }

            String? userId = snapshot.data!.item2;
            if (userId != null) {
              return const MainTabView();
            }
          }
          return const LoginView();
        },
      ),
    );
  }
}
