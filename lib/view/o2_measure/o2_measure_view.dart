import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:fitness/common/color_extension.dart';
import 'package:fitness/view/o2_measure/o2_measure.dart';
import 'package:flutter/material.dart';

class O2MeasureView extends StatefulWidget {
  const O2MeasureView({super.key});

  @override
  State<O2MeasureView> createState() => _O2MeasureViewState();
}

class _O2MeasureViewState extends State<O2MeasureView> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];

  Timer? _timer; // Declare a Timer variable
  int remainingTime = 15;

  void startMeasurement() {
    isBloodPressureMeasure = true;
    remainingTime = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        final latestValue = bpmValues.isNotEmpty ? bpmValues.last.value : null;
        if (latestValue != null && (latestValue < 60 || latestValue > 120)) {
          // If the latest value is out of range, don't decrement remainingTime
          return;
        }
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        finishMeasurement();
      }
    });
  }

  void finishMeasurement() {
    isBloodPressureMeasure = false;
    // x(); // Call your function here
    if (bpmValues.isNotEmpty) {
      final latestValue = bpmValues.last.value;
      setBloodPressure(latestValue.toInt());
    }
    setState(() {});
  }

  int systolicPressure = 0;
  int diastolicPressure = 0;
  void setBloodPressure(int heartRate,
      {int age = 18,
      String sex = 'male',
      int weight = 55,
      int height = 154,
      String position = "sitting"}) {
    double R = 18.5;
    double Q =
        (sex.toLowerCase() == "male" || sex.toLowerCase() == "m") ? 5 : 4.5;
    double ejectionTime = (position.toLowerCase() != "laying down")
        ? 386 - 1.64 * heartRate
        : 364.5 - 1.23 * heartRate;
    double bodySurfaceArea = 0.007184 * pow(weight, 0.425) * pow(height, 0.725);
    double strokeVolume = -6.6 +
        0.25 * (ejectionTime - 35) -
        0.62 * heartRate +
        40.4 * bodySurfaceArea -
        0.51 * age;
    double pulsePressure = strokeVolume.abs() /
        ((0.013 * weight - 0.007 * age - 0.004 * heartRate) + 1.307);
    double meanPulsePressure = Q * R;

    systolicPressure = (meanPulsePressure + 4.5 / 3 * pulsePressure).round();
    diastolicPressure = (meanPulsePressure - pulsePressure / 3).round();

    // Save systolicPressure and diastolicPressure to shared preferences
    // You need to implement the saveSharedPreference function
    // saveSharedPreference("systolicPressure", systolicPressure);
    // saveSharedPreference("diastolicPressure", diastolicPressure);
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Always cancel timers in the dispose method to prevent memory leaks
    super.dispose();
  }

  bool isBloodPressureMeasure = false;
  Widget? dialog;
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
          "SpO2 Tracker",
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isBloodPressureMeasure
              ? dialog = O2MeasureDialog(
                  context: context,
                  showTextValues: true,
                  borderRadius: 10,
                  onRawData: (value) {
                    setState(() {
                      if (data.length >= 100) data.removeAt(0);
                      data.add(value);
                    });
                    // chart = BPMChart(data);
                  },
                  onBPM: (value) => setState(
                    () {
                      if (bpmValues.length >= 100) bpmValues.removeAt(0);
                      bpmValues.add(SensorValue(
                          value: value.toDouble(), time: DateTime.now()));
                    },
                  ),
                )
              : const SizedBox(),
          isBloodPressureMeasure && bpmValues.isNotEmpty
              ? () {
                  final latestValue = bpmValues.last.value;
                  return Container(
                    decoration: BoxDecoration(border: Border.all()),
                    constraints: const BoxConstraints.expand(height: 180),
                    child: latestValue < 60 || latestValue > 120
                        ? const Center(
                            child: Text(
                            "Please place your finger correctly",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        : Center(
                            child: Text(
                              "Please wait for a moment. Remaining time: $remainingTime seconds",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  );
                }()
              : const SizedBox(),

          // Display systolicPressure and diastolicPressure
          if (!isBloodPressureMeasure && systolicPressure != 0)
            Column(
              children: [
                Text(
                  "Systolic Pressure: $systolicPressure",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Diastolic Pressure: $diastolicPressure",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          Expanded(
            child: Container(), // Để "đẩy" nút xuống cuối
          ),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.favorite_rounded),
              label: Text(
                isBloodPressureMeasure ? "Stop measurement" : "Measure SpO2",
              ),
              onPressed: () => setState(() {
                if (isBloodPressureMeasure) {
                  _timer?.cancel();
                  isBloodPressureMeasure = false;
                  // dialog.
                } else {
                  startMeasurement();
                }
              }),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
