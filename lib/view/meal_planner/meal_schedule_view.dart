import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitness/common/color_extension.dart';
import 'package:fitness/common_widget/food_schedule.dart';
import 'package:fitness/model/food.dart';
import 'package:fitness/service/foodStuff.dart';
import 'package:fitness/service/meal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealScheduleView extends StatefulWidget {
  const MealScheduleView({super.key});

  @override
  State<MealScheduleView> createState() => _MealScheduleViewState();
}

class _MealScheduleViewState extends State<MealScheduleView> {
  @override
  Widget build(BuildContext context) {
    MealStuff mealStuff = MealStuff();
    FoodStuff foodStuff = FoodStuff();
    Future<List<dynamic>> getBreakfast(DateTime date) async {
      var meals = await mealStuff.getMealByCategoryDay("Breakfast", date);
      List food_list = [];
      for (var food in meals[0]["food"]) {
        var foodObj = await foodStuff.getFoodById(food);

        food_list
            .add([foodObj['data']['name'], foodObj['data']['image'], date]);
      }
      print("breakfast");
      print(food_list);
      return food_list;
    }

    Future<List<dynamic>> getLunch(DateTime date) async {
      var meals = await mealStuff.getMealByCategoryDay("Lunch", date);
      List food_list = [];
      for (var food in meals[0]["food"]) {
        var foodObj = await foodStuff.getFoodById(food);

        food_list
            .add([foodObj['data']['name'], foodObj['data']['image'], date]);
      }
      print("lunch");
      print(food_list);
      return food_list;
    }

    Future<List<dynamic>> getSnacks(DateTime date) async {
      var meals = await mealStuff.getMealByCategoryDay("Snack", date);
      List food_list = [];
      for (var food in meals[0]["food"]) {
        var foodObj = await foodStuff.getFoodById(food);

        food_list
            .add([foodObj['data']['name'], foodObj['data']['image'], date]);
      }
      print("snacks");
      print(food_list);
      return food_list;
    }

    Future<List<dynamic>> getDinner(DateTime date) async {
      var meals = await mealStuff.getMealByCategoryDay("Dinner", date);
      List food_list = [];
      for (var food in meals[0]["food"]) {
        var foodObj = await foodStuff.getFoodById(food);

        food_list
            .add([foodObj['data']['name'], foodObj['data']['image'], date]);
      }
      print("dinner");
      print(food_list);
      return food_list;
    }

    // List breakfastArr = [
    //   {
    //     "name": "Honey Pancake",
    //     "time": "07:00am",
    //     "image": "assets/img/honey_pan.png"
    //   },
    //   {"name": "Coffee", "time": "07:30am", "image": "assets/img/coffee.png"},
    // ];

    // List lunchArr = [
    //   {
    //     "name": "Chicken Steak",
    //     "time": "01:00pm",
    //     "image": "assets/img/chicken.png"
    //   },
    //   {
    //     "name": "Milk",
    //     "time": "01:20pm",
    //     "image": "assets/img/glass-of-milk 1.png"
    //   },
    // ];
    // List snacksArr = [
    //   {"name": "Orange", "time": "04:30pm", "image": "assets/img/orange.png"},
    //   {
    //     "name": "Apple Pie",
    //     "time": "04:40pm",
    //     "image": "assets/img/apple_pie.png"
    //   },
    // ];
    // List dinnerArr = [
    //   {"name": "Salad", "time": "07:10pm", "image": "assets/img/salad.png"},
    //   {"name": "Oatmeal", "time": "08:10pm", "image": "assets/img/oatmeal.png"},
    // ];

    List nutritionArr = [
      {
        "title": "Calories",
        "image": "assets/img/burn.png",
        "unit_name": "kCal",
        "value": "350",
        "max_value": "500",
      },
      {
        "title": "Proteins",
        "image": "assets/img/proteins.png",
        "unit_name": "g",
        "value": "300",
        "max_value": "1000",
      },
      {
        "title": "Fats",
        "image": "assets/img/egg.png",
        "unit_name": "g",
        "value": "140",
        "max_value": "1000",
      },
      {
        "title": "Carbo",
        "image": "assets/img/carbo.png",
        "unit_name": "g",
        "value": "140",
        "max_value": "1000",
      },
    ];
    CalendarAgendaController controller = CalendarAgendaController();
    late DateTime _selectedDate;
    var media = MediaQuery.of(context);
    void initState(initState) {
      super.initState();
      _selectedDate = DateTime.now();
    }

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
          "Meal Schedule",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarAgenda(
            controller: controller,
            appbar: false,
            selectedDayPosition: SelectedDayPosition.center,
            leading: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/ArrowLeft.png",
                  width: 15,
                  height: 15,
                )),
            training: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/ArrowRight.png",
                  width: 15,
                  height: 15,
                )),
            weekDay: WeekDay.short,
            dayNameFontSize: 12,
            dayNumberFontSize: 16,
            dayBGColor: Colors.grey.withOpacity(0.15),
            titleSpaceBetween: 15,
            backgroundColor: Colors.transparent,
            // fullCalendar: false,
            fullCalendarScroll: FullCalendarScroll.horizontal,
            fullCalendarDay: WeekDay.short,
            selectedDateColor: Colors.white,
            dateColor: Colors.black,
            locale: 'en',

            initialDate: DateTime.now(),
            calendarEventColor: TColor.primaryColor2,
            firstDate: DateTime.now().subtract(const Duration(days: 140)),
            lastDate: DateTime.now().add(const Duration(days: 60)),

            onDateSelected: (date) {
              _selectedDate = date;
            },
            selectedDayLogo: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: TColor.primaryG,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List>(
                future: getBreakfast(DateTime.now()),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Breakfast",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "${snapshot.data!.length} meals | 230 calories",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(snapshot.data![index][2]);
                            Map<String, dynamic> hObj = {
                              "name": snapshot.data![index][0],
                              "time": formattedDate,
                              "image": snapshot.data![index][1]
                            };

                            return FoodSchedule(mObj: hObj);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getLunch(DateTime.now()),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lunch",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "${snapshot.data!.length} meals | 230 calories",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(snapshot.data![index][2]);
                            Map<String, dynamic> lObj = {
                              "name": snapshot.data![index][0],
                              "time": formattedDate,
                              "image": snapshot.data![index][1]
                            };
                            return FoodSchedule(mObj: lObj);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getSnacks(DateTime.now()),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Snacks",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "${snapshot.data!.length} meals | 230 calories",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(snapshot.data![index][2]);
                            Map<String, dynamic> sObj = {
                              "name": snapshot.data![index][0],
                              "time": formattedDate,
                              "image": snapshot.data![index][1]
                            };
                            return FoodSchedule(mObj: sObj);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List>(
                future: getDinner(DateTime.now()),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dinner",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "${snapshot.data!.length} meals | 230 calories",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(snapshot.data![index][2]);
                            Map<String, dynamic> dObj = {
                              "name": snapshot.data![index][0],
                              "time": formattedDate,
                              "image": snapshot.data![index][1]
                            };
                            return FoodSchedule(mObj: dObj);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Lunch",
              //           style: TextStyle(
              //               color: TColor.black,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w700),
              //         ),
              //         TextButton(
              //           onPressed: () {},
              //           child: Text(
              //             "${lunchArr.length} meals | 230 calories",
              //             style: TextStyle(
              //                 color: TColor.black,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         )
              //       ],
              //     )),
              // ListView.builder(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: lunchArr.length,
              //     itemBuilder: (context, index) {
              //       var lObj = lunchArr[index];
              //       return FoodSchedule(mObj: lObj);
              //     }),
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Snacks",
              //           style: TextStyle(
              //               color: TColor.black,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w700),
              //         ),
              //         TextButton(
              //           onPressed: () {},
              //           child: Text(
              //             "${snacksArr.length} meals | 230 calories",
              //             style: TextStyle(
              //                 color: TColor.black,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         )
              //       ],
              //     )),
              // ListView.builder(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: snacksArr.length,
              //     itemBuilder: (context, index) {
              //       var sObj = snacksArr[index];
              //       return FoodSchedule(mObj: sObj);
              //     }),
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Dinner",
              //           style: TextStyle(
              //               color: TColor.black,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w700),
              //         ),
              //         TextButton(
              //           onPressed: () {},
              //           child: Text(
              //             "${dinnerArr.length} meals | 230 calories",
              //             style: TextStyle(
              //                 color: TColor.black,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         )
              //       ],
              //     )),
              // ListView.builder(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: dinnerArr.length,
              //     itemBuilder: (context, index) {
              //       var dObj = dinnerArr[index];
              //       return FoodSchedule(mObj: dObj);
              //     }),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today Meal Nutritions",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: nutritionArr.length,
                  itemBuilder: (context, index) {
                    var nObj = nutritionArr[index];
                    // return progress bar
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                nObj["title"].toString(),
                                style: TextStyle(
                                    color: TColor.black, fontSize: 12),
                              ),
                              SizedBox(width: 8),
                              Image.asset(
                                nObj["image"].toString(),
                                width: 15,
                                height: 15,
                                fit: BoxFit.contain,
                              ),
                              const Spacer(),
                              Text(
                                "${nObj["value"].toString()} ${nObj["unit_name"].toString()}",
                                style:
                                    TextStyle(color: TColor.gray, fontSize: 11),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 10,
                            width: media.size.width * 0.9,
                            decoration: BoxDecoration(
                              color: TColor.lightGray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // progress bar with value and max value
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: double.parse(
                                      nObj["value"].toString()) /
                                  double.parse(nObj["max_value"].toString()),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      TColor.primaryColor2,
                                      TColor.secondaryColor1
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          )))
        ],
      ),
    );
  }
}
