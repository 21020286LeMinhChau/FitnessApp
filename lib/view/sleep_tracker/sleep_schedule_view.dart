import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitness/common/color_extension.dart';
import 'package:fitness/common_widget/today_sleep_schedule.dart';
import 'package:fitness/view/sleep_tracker/sleep_add_alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class SleepScheduleView extends StatefulWidget {
  const SleepScheduleView({super.key});

  @override
  State<SleepScheduleView> createState() => _SleepScheduleViewState();
}

class _SleepScheduleViewState extends State<SleepScheduleView> {
  CalendarAgendaController controller = CalendarAgendaController();
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    List todaySleepArr = [
      {
        "name": "Bedtime",
        "image": "assets/img/bed.png",
        "time": "13/04/2024 09:00 PM",
        "duration": "in 6 hours 22 minutes"
      },
      {
        "name": "Alarm",
        "image": "assets/img/alaarm.png",
        "time": "02/06/2023 05:10 AM",
        "duration": "in 14 hours 30 minutes"
      },
    ];
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
            "Sleep Schedule",
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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ideal Sleep Time",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "8 hours",
                            style: TextStyle(
                                color: Color(0xff436850),
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700),
                          ),
                          ButtonBar(
                            children: [
                              TextButton(
                                onPressed: null,
                                style: ButtonStyle(
                                    // backgroundColor: MaterialStateProperty.all(TColor.secondaryColor1),
                                    backgroundColor: MaterialStateProperty.all(
                                        TColor.secondaryColor1),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                child: const Text(
                                  "Lean More",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          )
                        ]),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/img/sleep_slot.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your Sleep Schedule",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
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
                selectedDate = date;
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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: todaySleepArr.length,
                    itemBuilder: (context, index) {
                      var kObj = todaySleepArr[index] as Map? ?? {};
                      return InkWell(
                        child: TodaySleepSchedule(
                          sObj: kObj,
                        ),
                      );
                    })),
            Container(
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      TColor.primaryColor1.withOpacity(0.4),
                      TColor.primaryColor2.withOpacity(0.4)
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You will get 8hours 10minutes\nfor tonight",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SimpleAnimationProgressBar(
                          height: 15,
                          width: media.size.width - 80,
                          backgroundColor: Colors.grey.shade100,
                          foregrondColor: Colors.purple,
                          ratio: 0.96,
                          direction: Axis.horizontal,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(seconds: 3),
                          borderRadius: BorderRadius.circular(7.5),
                          gradientColor: LinearGradient(
                              colors: TColor.secondaryG,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                        Text(
                          "96%",
                          style: TextStyle(
                            color: TColor.white,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: media.size.height * 0.2,
            ),
          ],
        )),
        floatingActionButton: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  
                  MaterialPageRoute(
                      builder: (context) =>
                          SleepAddAlarmView(date: selectedDate)
                      // SleepAddAlarmView()
                      )
                  // SleepAddAlarmView()
                  );
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.secondaryColor1,
                  borderRadius: BorderRadius.circular(27.5)),
              child: Icon(
                Icons.add,
                color: TColor.white,
                size: 30,
              ),
            )));
  }
}
