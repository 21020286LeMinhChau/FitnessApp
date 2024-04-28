import 'dart:ui';

import 'package:fitness/common/color_extension.dart';
import 'package:fitness/view/heart_bpm/chart.dart';
import 'package:fitness/view/heart_bpm/heart_bpm.dart';
import 'package:flutter/material.dart';

class HeartBpmView extends StatefulWidget {
  const HeartBpmView({super.key});

  @override
  State<HeartBpmView> createState() => _HeartBpmViewState();
}

class _HeartBpmViewState extends State<HeartBpmView> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  //  Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
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
          "Heart BPM Tracker",
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
          isBPMEnabled
              ? dialog = HeartBPMDialog(
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
                  onBPM: (value) => setState(() {
                    if (bpmValues.length >= 100) bpmValues.removeAt(0);
                    bpmValues.add(SensorValue(
                        value: value.toDouble(), time: DateTime.now()));
                  }),
                  // sampleDelay: 1000 ~/ 20,
                  // child: Container(
                  //   height: 50,
                  //   width: 100,
                  //   child: BPMChart(data),
                  // ),
                )
              : SizedBox(),
          // isBPMEnabled && data.isNotEmpty
          //     ? Container(
          //         decoration: BoxDecoration(border: Border.all()),
          //         height: 180,
          //         child: BPMChart(data),
          //       )
          //     : SizedBox(),
          isBPMEnabled && bpmValues.isNotEmpty
              ? () {
                  final latestValue = bpmValues.last.value;
                  // final filteredBpmValues = bpmValues
                  //     .where((sensorValue) =>
                  //         sensorValue.value >= 60 && sensorValue.value <= 120)
                  //     .toList();
                  //  remove last if latestValue < 120 or > 60
                  final filteredBpmValues = bpmValues
                      .where((sensorValue) =>
                          sensorValue.value >= 60 && sensorValue.value <= 120)
                      .toList();
                  return Container(
                    decoration: BoxDecoration(border: Border.all()),
                    constraints: BoxConstraints.expand(height: 180),
                    child: latestValue < 60 || latestValue > 120
                        ? const Center(
                            child: Text(
                              "Please place your finger correctly",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : BPMChart(filteredBpmValues),
                  );
                }()
              : SizedBox(),
          Expanded(
            child: Container(), // Để "đẩy" nút xuống cuối
          ),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.favorite_rounded),
              label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
              onPressed: () => setState(() {
                if (isBPMEnabled) {
                  isBPMEnabled = false;
                  // dialog.
                } else
                  isBPMEnabled = true;
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
