import 'package:fitness/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/setting_row.dart';
import '../../common_widget/title_subtitle_cell.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../../model/user.dart';
import '../show_history/activity_history_view.dart';
import '../show_history/workout_history_view.dart';
import 'edit_profile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  String userId = '';
  static User user = User();
  static double BMI = 0;

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? 'No user ID found'; // If 'id_user' doesn't exist, show a default message
    });
  }

  Future<void> fetchUser() async {
    await _loadUserId();
    try {
      User? fetchedUser = await User.getUserById(userId);
      if (fetchedUser != null) {
        user = fetchedUser;
        double height = double.parse(user.height) / 100;
        BMI = double.parse(user.weight) / (height * height);
        BMI = double.parse((BMI).toStringAsFixed(1));
        setState(() {});
      } else {
        logger.i('User not found');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  bool positive = false;

  @override
  Widget build(BuildContext context) {
    // Define the accountArr list inside the build method to use context
    List<Map<String, dynamic>> accountArr = [
      {
        "image": "assets/img/p_personal.png",
        "name": "Personal Data",
        "tag": "1",
        "onPressed": () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PersonalDataView(userId: userId), // Example
          //   ),
          // );
        },
      },
      {
        "image": "assets/img/p_achi.png",
        "name": "Achievement",
        "tag": "2",
        "onPressed": () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AchievementView(userId: userId), // Example
          //   ),
          // );
        },
      },
      {
        "image": "assets/img/p_activity.png",
        "name": "Activity History",
        "tag": "3",
        "onPressed": () {
          // Add your navigation logic for Activity History here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityHistoryView(userId: userId),
            ),
          );
        },
      },
      {
        "image": "assets/img/p_workout.png",
        "name": "Workout Progress",
        "tag": "4",
        "onPressed": () {
          // Add your navigation logic for Workout Progress here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutHistoryView(userId: userId),
            ),
          );
        },
      }
    ];

    List otherArr = [
      {"image": "./assets/img/p_contact.png", "name": "Contact Us", "tag": "5"},
      {"image": "assets/img/p_privacy.png", "name": "Privacy Policy", "tag": "6"},
      {"image": "assets/img/p_setting.png", "name": "Setting", "tag": "7"},
      {"image": "assets/img/p_logout.png", "name": "Logout", "tag": "8"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      user.gender == 'male'
                          ? 'assets/img/u1.png'
                          : 'assets/img/u2.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          bodyStatus(BMI),
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundButton(
                      title: "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: user.height,
                      subtitle: "Height",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: user.weight,
                      subtitle: "Weight",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: user.dateOfBirth != null
                          ? '${DateTime.now().year - DateFormat('dd/MM/yyyy').parse(user.dateOfBirth).year}yo'
                          : 'Loading...',
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: accountArr.length,
                      itemBuilder: (context, index) {
                        var iObj = accountArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: iObj["onPressed"] as void Function(),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/img/p_notification.png",
                                height: 15, width: 15, fit: BoxFit.contain),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                "Pop-up Notification",
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            CustomAnimatedToggleSwitch<bool>(
                              current: positive,
                              values: [false, true],
                              dif: 0.0,
                              indicatorSize: Size.square(30.0),
                              animationDuration:
                              const Duration(milliseconds: 200),
                              animationCurve: Curves.linear,
                              onChanged: (b) => setState(() => positive = b),
                              iconBuilder: (context, local, global) {
                                return const SizedBox();
                              },
                              defaultCursor: SystemMouseCursors.click,
                              onTap: () => setState(() => positive = !positive),
                              iconsTappable: false,
                              wrapperBuilder: (context, global, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                        left: 10.0,
                                        right: 10.0,
                                        height: 30.0,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: TColor.secondaryG),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(50.0)),
                                          ),
                                        )),
                                    child,
                                  ],
                                );
                              },
                              foregroundIndicatorBuilder: (context, global) {
                                return SizedBox.fromSize(
                                  size: const Size(10, 10),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: TColor.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black38,
                                            spreadRadius: 0.05,
                                            blurRadius: 1.1,
                                            offset: Offset(0.0, 0.8))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: otherArr.length,
                      itemBuilder: (context, index) {
                        var iObj = otherArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () async {
                            if (iObj["tag"] == "8") {
                              // set user_id to null
                              await SharedPreferences.getInstance().then((prefs) {
                                prefs.remove("user_id");
                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                                    (Route<dynamic> route) => false, // Never allow user to go back
                              );
                            } else {
                              // Add your navigation logic for other items here
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String bodyStatus(double BMI) {
    if (BMI < 18.5) {
      return "Gain weight plan"; // You are underweight
    }
    if (BMI >= 18.5 && BMI <= 22.9) {
      return "Maintain shape"; // You have a normal weight
    } else {
      return "Weight loss plan"; // You are overweight
    }
  }
}
