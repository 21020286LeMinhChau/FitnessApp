import 'package:fitness/common/color_extension.dart';
import 'package:fitness/model/food.dart';
import 'package:fitness/model/mealSchedule.dart';
import 'package:fitness/service/meal.dart';
import 'package:fitness/view/meal_planner/meal_food_details_view.dart';
import 'package:fitness/view/meal_planner/meal_schedule_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/today_meal_row.dart';
import 'package:flutter/widgets.dart';
import 'package:fitness/common_widget/find_sth_eat.dart';
import 'package:fitness/service/foodStuff.dart';
import 'package:intl/intl.dart';
class MealPlannerView extends StatefulWidget {
  const MealPlannerView({super.key});

  @override
  State<MealPlannerView> createState() => _MealPlannerViewState();
}

class _MealPlannerViewState extends State<MealPlannerView> {
  MealStuff mealStuff = MealStuff();
  FoodStuff foodStuff = FoodStuff();
  String category = "Breakfast";
  Future<List<dynamic>> getListTodayMeals(String category) async {
    // Fetch the meals
    var meals = await mealStuff.getMealByCategoryDay(category, DateTime.now());
    List food_list = [];
    for(var food in meals[0]["food"]){
      var foodObj = await foodStuff.getFoodById(food);
      var date = meals[0]["date"];
      food_list.add([foodObj['data']['name'],foodObj['data']['image'] , date]);
    }
    print(food_list); 
    return food_list;
  }
  void updateCategory(String newCategory) {
    setState(() {
      category = newCategory;
    });
  }

  // List todayMealArr = [
  //   {
  //     "name": "Salmon Nigiri",
  //     "image": "assets/img/Salmon.png",
  //     "time": "26/03/2024 08:00 AM"
  //   },
  //   {
  //     "name": "Lowfat Milk",
  //     "image": "assets/img/Milk.png",
  //     "time": "26/03/2024 10:00 AM"
  //   }
  // ];
  List findEatArr = [
    {
      "name": "Breakfast",
      "image": "assets/img/pie.png",
      "number": "120+ Foods"
    },
    {"name": "Lunch", "image": "assets/img/bread.png", "number": "200+"}
  ];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
            "Meal Planner",
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
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Meal Nutrition",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(
                                15), // Removed 'const' here
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: ["Weekly", "Monthly"]
                                  .map((name) => DropdownMenuItem(
                                        value: name,
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                              color: TColor.gray, fontSize: 14),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                              icon:
                                  Icon(Icons.expand_more, color: TColor.white),
                              hint: Text(
                                "Weekly",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: TColor.white, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 15),
                        height: media.width * 0.5,
                        width: double.maxFinite,
                        child: LineChart(
                          LineChartData(
                            // showingTooltipIndicators:
                            //     showingTooltipOnSpots.map((index) {
                            //   return ShowingTooltipIndicators([
                            //     LineBarSpot(
                            //       tooltipsOnBar,
                            //       lineBarsData.indexOf(tooltipsOnBar),
                            //       tooltipsOnBar.spots[index],
                            //     ),
                            //   ]);
                            // }).toList(),
                            lineTouchData: LineTouchData(
                              enabled: true,
                              handleBuiltInTouches: false,
                              touchCallback: (FlTouchEvent event,
                                  LineTouchResponse? response) {
                                // if (response == null || response.lineBarSpots == null) {
                                //   return;
                                // }
                                // if (event is FlTapUpEvent) {
                                //   final spotIndex =
                                //       response.lineBarSpots!.first.spotIndex;
                                //   showingTooltipOnSpots.clear();
                                //   setState(() {
                                //     showingTooltipOnSpots.add(spotIndex);
                                //   });
                                // }
                              },
                              mouseCursorResolver: (FlTouchEvent event,
                                  LineTouchResponse? response) {
                                if (response == null ||
                                    response.lineBarSpots == null) {
                                  return SystemMouseCursors.basic;
                                }
                                return SystemMouseCursors.click;
                              },
                              getTouchedSpotIndicator:
                                  (LineChartBarData barData,
                                      List<int> spotIndexes) {
                                return spotIndexes.map((index) {
                                  return TouchedSpotIndicatorData(
                                    FlLine(
                                      color: Colors.transparent,
                                    ),
                                    FlDotData(
                                      show: true,
                                      getDotPainter:
                                          (spot, percent, barData, index) =>
                                              FlDotCirclePainter(
                                        radius: 3,
                                        color: Colors.white,
                                        strokeWidth: 3,
                                        strokeColor: TColor.secondaryColor1,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: TColor.secondaryColor1,
                                tooltipRoundedRadius: 20,
                                getTooltipItems:
                                    (List<LineBarSpot> lineBarsSpot) {
                                  return lineBarsSpot.map((lineBarSpot) {
                                    return LineTooltipItem(
                                      "${lineBarSpot.x.toInt()} mins ago",
                                      const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            lineBarsData: lineBarsData1,
                            minY: -0.5,
                            maxY: 110,
                            titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                                bottomTitles: AxisTitles(
                                  sideTitles: bottomTitles,
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: rightTitles,
                                )),
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              horizontalInterval: 25,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: TColor.gray.withOpacity(0.15),
                                  strokeWidth: 2,
                                );
                              },
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor1.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daily Meal Schedule",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 90,
                            height: 25,
                            child: RoundButton(
                              title: "Check",
                              type: RoundButtonType.bgGradient,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MealScheduleView()
                                  ),
                                );
                                
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today Meals",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(
                                15), // Removed 'const' here
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              // value: category,
                              items: ["Breakfast", "Lunch", "Snack", "Dinner"]
                                  .map((name) => DropdownMenuItem<String>(
                                        value: name,
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                              color: TColor.gray, fontSize: 14),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                if (value != null) {
                                  updateCategory(value);
                                  print(value);
                                }
                              },
                              icon: Icon(Icons.expand_more, color: TColor.white),
                              hint: Text(
                                category,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: TColor.white, fontSize: 12),

                            ),
                          ),
                        )
                        )
                      ],
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    FutureBuilder<List>(
                      future: getListTodayMeals(category),
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = snapshot.data![index][2].toDate();
                              String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
                              print(formattedDate);
                              Map<String, dynamic> mObj = {
                                'name': snapshot.data![index][0],
                                'image': snapshot.data![index][1],
                                'time': formattedDate,
                              };
                              return TodayMealRow(
                                mObj: mObj,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Text(
                      "Find Sth to eat",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: findEatArr.length,
                          itemBuilder: (context, index) {
                            var fObj = findEatArr[index] as Map? ?? {};
                            return InkWell(
                              onTap: () {
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MealFoodDetailsView(eObj: fObj),
                                    ),
                                  );
                                }
                              },
                              child: FindSthToEat(
                                fObj: fObj,
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                  ],
                ))));
  }

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.primaryColor2,
          TColor.primaryColor1,
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: TColor.primaryColor2,
          ),
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 35),
          FlSpot(2, 70),
          FlSpot(3, 40),
          FlSpot(4, 80),
          FlSpot(5, 25),
          FlSpot(6, 70),
          FlSpot(7, 35),
        ],
      );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.gray,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
