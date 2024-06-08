import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/target.dart';
import '../../common_widget/today_target_cell.dart';

class AddTarget extends StatefulWidget {
  const AddTarget({super.key});

  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  final List<Map<String, String>> water = [
    {
      "icon": "assets/img/water.png",
      "value": "8L",
      "title": "Water Intake",
    },
    {
      "icon": "assets/img/water.png",
      "value": "6L",
      "title": "Water Intake",
    },
  ];

  final List<Map<String, String>> step = [
    {
      "icon": "assets/img/foot.png",
      "value": "1000",
      "title": "Foot Steps",
    },
    {
      "icon": "assets/img/foot.png",
      "value": "1500",
      "title": "Foot Steps",
    },
    {
      "icon": "assets/img/foot.png",
      "value": "2400",
      "title": "Foot Steps",
    },
    {
      "icon": "assets/img/foot.png",
      "value": "3000",
      "title": "Foot Steps",
    },
  ];
  final List<Map<String, String>> calo = [
    {
      "icon": "assets/img/calories.png",
      "value": "1800kcal",
      "title": "Calorie Intake",
    },
    {
      "icon": "assets/img/calories.png",
      "value": "2000kcal",
      "title": "Calorie Intake",
    },
    {
      "icon": "assets/img/calories.png",
      "value": "2200kcal",
      "title": "Calorie Intake",
    },
    {
      "icon": "assets/img/calories.png",
      "value": "24000kcal",
      "title": "Calorie Intake",
    },
    {
      "icon": "assets/img/calories.png",
      "value": "2800kcal",
      "title": "Calorie Intake",
    },
  ];
  final List<Map<String, String>> exercise = [
    {
      "icon": "assets/img/exercise.png",
      "value": "1hr",
      "title": "Exercise",
    },
    {
      "icon": "assets/img/yoga.png",
      "value": "45min",
      "title": "Yoga",
    },
    {
      "icon": "assets/img/cycling.png",
      "value": "15km",
      "title": "Cycling",
    },
    {
      "icon": "assets/img/reading.png",
      "value": "1hr",
      "title": "Reading",
    },
  ];

  final List<Map<String, String>> sleep = [
    {
      "icon": "assets/img/sleep.png",
      "value": "6hrs",
      "title": "Sleep",
    },
    {
      "icon": "assets/img/sleep.png",
      "value": "7hrs",
      "title": "Sleep",
    },
    {
      "icon": "assets/img/sleep.png",
      "value": "7.5hrs",
      "title": "Sleep",
    },
    {
      "icon": "assets/img/sleep.png",
      "value": "8hrs",
      "title": "Sleep",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TColor.white,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/black_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            "Target setting ",
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
                  "assets/img/save.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        TColor.primaryColor2.withOpacity(0.3),
                        TColor.primaryColor1.withOpacity(0.3)
                      ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Water intake",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTarget(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    textColor: TColor.primaryColor1,
                                    minWidth: double.maxFinite,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Số cột
                              crossAxisSpacing: 15,
                              // Khoảng cách giữa các cột
                              mainAxisSpacing: 15,
                              // Khoảng cách giữa các dòng
                              childAspectRatio: 5 / 2,
                            ),
                            itemCount: water.length,
                            itemBuilder: (context, index) {
                              var item = water[index];
                              return TargetCell(
                                icon: item['icon']!,
                                value: item['value']!,
                                title: item['title']!,
                                onSelect: (String value, String title) {},
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        TColor.primaryColor2.withOpacity(0.3),
                        TColor.primaryColor1.withOpacity(0.3)
                      ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Foot steps",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTarget(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    textColor: TColor.primaryColor1,
                                    minWidth: double.maxFinite,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Số cột
                              crossAxisSpacing: 15,
                              // Khoảng cách giữa các cột
                              mainAxisSpacing: 15,
                              // Khoảng cách giữa các dòng
                              childAspectRatio: 5 / 2,
                            ),
                            itemCount: step.length,
                            itemBuilder: (context, index) {
                              var item = step[index];
                              return TargetCell(
                                icon: item['icon']!,
                                value: item['value']!,
                                title: item['title']!,
                                onSelect: (String value, String title) {},
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        TColor.primaryColor2.withOpacity(0.3),
                        TColor.primaryColor1.withOpacity(0.3)
                      ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories intake",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTarget(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    textColor: TColor.primaryColor1,
                                    minWidth: double.maxFinite,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Số cột
                              crossAxisSpacing: 15,
                              // Khoảng cách giữa các cột
                              mainAxisSpacing: 15,
                              // Khoảng cách giữa các dòng
                              childAspectRatio: 5 / 2,
                            ),
                            itemCount: calo.length,
                            itemBuilder: (context, index) {
                              var item = calo[index];
                              return TargetCell(
                                icon: item['icon']!,
                                value: item['value']!,
                                title: item['title']!,
                                onSelect: (String value, String title) {},
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        TColor.primaryColor2.withOpacity(0.3),
                        TColor.primaryColor1.withOpacity(0.3)
                      ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Activities",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTarget(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    textColor: TColor.primaryColor1,
                                    minWidth: double.maxFinite,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Số cột
                              crossAxisSpacing: 15,
                              // Khoảng cách giữa các cột
                              mainAxisSpacing: 15,
                              // Khoảng cách giữa các dòng
                              childAspectRatio: 5 / 2,
                            ),
                            itemCount: exercise.length,
                            itemBuilder: (context, index) {
                              var item = exercise[index];
                              return TargetCell(
                                icon: item['icon']!,
                                value: item['value']!,
                                title: item['title']!,
                                onSelect: (String value, String title) {},
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        TColor.primaryColor2.withOpacity(0.3),
                        TColor.primaryColor1.withOpacity(0.3)
                      ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sleep time",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddTarget(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    textColor: TColor.primaryColor1,
                                    minWidth: double.maxFinite,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Số cột
                              crossAxisSpacing: 15,
                              // Khoảng cách giữa các cột
                              mainAxisSpacing: 15,
                              // Khoảng cách giữa các dòng
                              childAspectRatio: 5 / 2,
                            ),
                            itemCount: sleep.length,
                            itemBuilder: (context, index) {
                              var item = sleep[index];
                              return TargetCell(
                                icon: item['icon']!,
                                value: item['value']!,
                                title: item['title']!,
                                onSelect: (String value, String title) {},
                              );
                            }),
                      ],
                    ),
                  ),
                ]))));
  }
}
