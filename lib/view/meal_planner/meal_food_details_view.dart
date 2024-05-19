import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common_widget/meal_recommend_cell.dart';
import 'package:fitness/model/food.dart';
import 'package:fitness/service/foodStuff.dart';
import 'package:fitness/service/meal.dart';
import 'package:fitness/view/meal_planner/food_info_details_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/color_extension.dart';
import 'package:fitness/common_widget/meal_category_cell.dart';
import 'package:fitness/common_widget/popular_meal_row.dart';

class MealFoodDetailsView extends StatefulWidget {
  final Map eObj;
  const MealFoodDetailsView({super.key, required this.eObj});

  @override
  State<MealFoodDetailsView> createState() => _MealFoodDetailsViewState();
}

class _MealFoodDetailsViewState extends State<MealFoodDetailsView> {
  TextEditingController txtSearch = TextEditingController();
  MealStuff mealStuff = MealStuff();
  FoodStuff foodStuff = FoodStuff();
  Future <List<dynamic>> getPopular(String category) async {
    var food_list = await mealStuff.getMealByCategory(category);
    List popularArr = [];
    
    for (var food in food_list['data'][0]['food']) {
      var foodObj = await foodStuff.getFoodById(food);
      var foodId = await foodStuff.getFoodIdByName(foodObj['data']['name']);
      // print(foodId['data']);
      popularArr.add([foodObj['data']['name'], foodObj['data']['image'], foodObj['data']['time'], foodObj['data']['kcal'], foodObj['data']['size'], foodObj['data']['b_image'], foodId['data'], foodObj['data']['description']]);
    }
    print(popularArr);
    return popularArr;
  }


  List popularArr = [
    {
      "name": "Blueberry Pancake",
      "image": "assets/img/f_1.png",
      "b_image": "assets/img/pancake_1.png",
      "size": "Medium",
      "time": "30mins",
      "kcal": "230kCal"
    },
    {
      "name": "Salmon Nigiri",
      "image": "assets/img/f_2.png",
      "b_image": "assets/img/nigiri.png",
      "size": "Medium",
      "time": "20mins",
      "kcal": "120kCal"
    },
  ];

  List recommendArr = [
    {
      "name": "Honey Pancake",
      "image": "assets/img/rd_1.png",
      "size": "Easy",
      "time": "30mins",
      "kcal": "180kCal"
    },
    {
      "name": "Canai Bread",
      "image": "assets/img/m_4.png",
      "size": "Easy",
      "time": "20mins",
      "kcal": "230kCal"
    },
  ];
  List categoryArr = [
    {
      "name": "Salad",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/c_4.png",
    },
    {
      "name": "Salad",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/c_4.png",
    },
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
          widget.eObj["name"].toString(),
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {getPopular(widget.eObj["name"].toString());},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Image.asset(
                          "assets/img/search.png",
                          width: 25,
                          height: 25,
                        ),
                        hintText: "Search Pancake"),
                  )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 25,
                    color: TColor.gray.withOpacity(0.3),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/img/Filter.png",
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:  Text(
                  "Category",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryArr.length,
                  itemBuilder: (context, index) {
                    var fObj = categoryArr[index] as Map? ?? {};
                    return MealCategoryCell(
                      cObj: fObj,
                    );
                  }),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
              "Recommendation for Diet",
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            )
            ,
            SizedBox(
              height: 239,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendArr.length,
                  itemBuilder: (context, index) {
                    var fObj = recommendArr[index] as Map? ?? {};
                    return MealRecommendCell(
                      fObj: fObj,
                    );
                  }),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
              "Popular",
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder<List<dynamic>>(
                future: getPopular(widget.eObj["name"].toString()),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> fObj = {
                          "name": snapshot.data![index][0],
                          "image": snapshot.data![index][1],
                          "time": snapshot.data![index][2],
                          "kcal": snapshot.data![index][3],
                          "b_image": snapshot.data![index][5], // "b_image": "assets/img/pancake_1.png
                          "size": snapshot.data![index][4],
                          "id": snapshot.data![index][6],
                          "description": snapshot.data![index][7]
                        };
                        
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodInfoDetailView( dObj: fObj, mObj: widget.eObj,)));
                          },
                          child: PopularMealRow(
                            mObj: fObj,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ), 

            
            
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
