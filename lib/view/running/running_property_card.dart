import 'package:fitness/model/running_property.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RunningPropertyCard extends StatelessWidget {
  final RunningProperty runningProperty;
  const RunningPropertyCard({super.key, required this.runningProperty});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(runningProperty.date,
                      style: GoogleFonts.montserrat(fontSize: 18)),
                  Text(
                      "${(runningProperty.distance / 1000).toStringAsFixed(2)} km",
                      style: GoogleFonts.montserrat(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(runningProperty.duration,
                      style: GoogleFonts.montserrat(fontSize: 14)),
                  Text("${runningProperty.speed.toStringAsFixed(2)} km/h",
                      style: GoogleFonts.montserrat(fontSize: 14)),
                ],
              )
            ],
          )),
    );
  }
}
