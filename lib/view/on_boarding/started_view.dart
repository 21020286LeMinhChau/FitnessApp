import 'package:fitness/common/color_extension.dart';
import 'package:fitness/view/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StatefulWidget> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: TColor.primaryG,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(),
              Text(
                "Fitness",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Everybody Can Train",
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 15,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnBoardingView()),
                          );
                        },
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        textColor: TColor.primaryColor1,
                        minWidth: double.maxFinite,
                        color: TColor.white,
                        child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                      colors: TColor.primaryG,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)
                                  .createShader(Rect.fromLTRB(
                                      0, 0, bounds.width, bounds.height));
                            },
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  color: TColor.primaryColor1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                      ))),
            ])
          ],
        ),
      ),
    );
  }
}
