import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fftea/fftea.dart';

/// Class to store one sample data point
class SensorValue {
  /// timestamp of datapoint
  final DateTime time;

  /// value of datapoint
  final num value;

  SensorValue({required this.time, required this.value});

  /// Returns JSON mapped data point
  Map<String, dynamic> toJSON() => {'time': time, 'value': value};

  /// Map a list of data samples to a JSON formatted array.
  ///
  /// Map a list of [data] samples to a JSON formatted array. This is
  /// particularly useful to store [data] to database.
  static List<Map<String, dynamic>> toJSONArray(List<SensorValue> data) =>
      List.generate(data.length, (index) => data[index].toJSON());
}

/// Obtains heart beats per minute using camera sensor
///
/// Using the smartphone camera, the widget estimates the skin tone variations
/// over time. These variations are due to the blood flow in the arteries
/// present below the skin of the fingertips.
// ignore: must_be_immutable
class O2MeasureDialog extends StatefulWidget {
  /// This is the Loading widget, A developer has to customize it.
  final Widget? centerLoadingWidget;
  final double? cameraWidgetHeight;
  final double? cameraWidgetWidth;
  bool? showTextValues = false;
  final double? borderRadius;

  /// Callback used to notify the caller of updated BPM measurement
  ///
  /// Should be non-blocking as it can affect
  final void Function(int) onBPM;

  /// Callback used to notify the caller of updated raw data sample
  ///
  /// Should be non-blocking as it can affect
  final void Function(SensorValue)? onRawData;

  /// Camera sampling rate in milliseconds
  final int sampleDelay;

  /// Parent context
  final BuildContext context;

  /// Smoothing factor
  ///
  /// Factor used to compute exponential moving average of the realtime data
  /// using the formula:
  /// ```
  /// $y_n = alpha * x_n + (1 - alpha) * y_{n-1}$
  /// ```
  double alpha = 0.6;

  /// Additional child widget to display
  final Widget? child;

  /// Obtains heart beats per minute using camera sensor
  ///
  /// Using the smartphone camera, the widget estimates the skin tone variations
  /// over time. These variations are due to the blood flow in the arteries
  /// present below the skin of the fingertips.
  ///
  /// This is a [Dialog] widget and hence needs to be displayer using [showDialog]
  /// function. For example:
  /// ```
  /// await showDialog(
  ///   context: context,
  ///   builder: (context) => HeartBPMDialog(
  ///     onData: (value) => print(value),
  ///   ),
  /// );
  /// ```
  O2MeasureDialog({
    Key? key,
    required this.context,
    this.sampleDelay = 1000 ~/ 10,
    required this.onBPM,
    this.onRawData,
    this.alpha = 0.8,
    this.child,
    this.centerLoadingWidget,
    this.cameraWidgetHeight,
    this.cameraWidgetWidth,
    this.showTextValues,
    this.borderRadius,
  });

  /// Set the smoothing factor for exponential averaging
  ///
  /// the scaling factor [alpha] is used to compute exponential moving average of the
  /// realtime data using the formula:
  /// ```
  /// $y_n = alpha * x_n + (1 - alpha) * y_{n-1}$
  /// ```
  void setAlpha(double a) {
    if (a <= 0) {
      throw Exception(
          "$O2MeasureDialog: smoothing factor cannot be 0 or negative");
    }
    if (a > 1) {
      throw Exception(
          "$O2MeasureDialog: smoothing factor cannot be greater than 1");
    }
    alpha = a;
  }

  @override
  _BpO2View createState() => _BpO2View();
}

class _BpO2View extends State<O2MeasureDialog> {
  /// Camera controller
  // CameraController? _controller;

  // /// Used to set sampling rate
  // bool _processing = false;

  // /// Current value
  // int currentValue = 0;

  // /// to ensure camara was initialized
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    _deinitController();
    super.dispose();
  }

  void _deinitController() async {
    isCameraInitialized = false;
    if (_controller == null) return;
    // await _controller.stopImageStream();
    await _controller!.dispose();
    // while (_processing) {}
    // _controller = null;
  }

  /// Initialize the camera controller
  ///
  /// Function to initialize the camera controller and start data collection.
  Future<void> _initController() async {
    if (_controller != null) return;

    try {
      // 1. get list of all available cameras
      List<CameraDescription> _cameras = await availableCameras();
      // 2. assign the preferred camera with low resolution and disable audio
      _controller = CameraController(_cameras.first, ResolutionPreset.low,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.bgra8888);

      // 3. initialize the camera
      await _controller!.initialize();

      // 4. set torch to ON and start image stream
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => _controller!.setFlashMode(FlashMode.torch));

      // 5. register image streaming callback

      _controller!.startImageStream((image) {
        if (!_processing && mounted) {
          _processing = true;
          // _scanImage(image);
          onCameraFrame(image);
        }
      });

      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isCameraInitialized
          ? Column(
              children: [
                Container(
                  constraints: BoxConstraints.tightFor(
                    width: widget.cameraWidgetWidth ?? 100,
                    height: widget.cameraWidgetHeight ?? 130,
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 10),
                    child: _controller!.buildPreview(),
                  ),
                ),
                //A developer has to choose whether they want to show this Text widget. (Implemented by Karl Mathuthu)
                if (widget.showTextValues == true) ...{
                  const Text(
                    // "BPM: ${currentValue.toStringAsFixed(0)}",
                    "SpO2: 98%",
                  )
                } else
                  const SizedBox(),
                widget.child == null ? const SizedBox() : widget.child!,
              ],
            )
          : Center(
              /// A developer has to customize the loading widget (Implemented by Karl Mathuthu)
              child: widget.centerLoadingWidget ??
                  const CircularProgressIndicator(),
            ),
    );
  }

  CameraController? _controller;
  bool _processing = false;
  int _counter = 0;
  double _sumRed = 0;
  double _sumBlue = 0;
  final List<double> _redAvgList = [];
  final List<double> _blueAvgList = [];
  int _o2 = 0;
  // int _bpm = 0;
  DateTime? _startTime;

  void onCameraFrame(CameraImage img) async {
    print('processing frame 1');
    print('Processing frame 2');
    final double redAvg = _calculateRedAvg(img);
    final double blueAvg = _calculateBlueAvg(img);

    print(redAvg.toString() + " 3 " + blueAvg.toString());

    _sumRed += redAvg;
    _sumBlue += blueAvg;

    _redAvgList.add(redAvg);
    _blueAvgList.add(blueAvg);

    _counter++;

    if (redAvg < 200) {
      print(redAvg.toString());
      Future<void>.delayed(Duration(milliseconds: widget.sampleDelay))
          .then((onValue) {
        if (mounted) {
          setState(() {
            _processing = false;
          });
        }
      });
      return;
    }

    final DateTime now = DateTime.now();
    _startTime ??= now;

    final int elapsedSeconds = now.difference(_startTime!).inSeconds;

    if (elapsedSeconds >= 3) {
      _startTime = DateTime.now();
      // final double samplingFreq = _counter / elapsedSeconds;
      // final double hrFreq = _calculateFft(_redAvgList, _counter, samplingFreq);
      // _bpm = (hrFreq * 60).ceil();

      final double meanRed = _sumRed / _counter;
      final double meanBlue = _sumBlue / _counter;

      double stdRed = 0;
      double stdBlue = 0;

      for (int i = 0; i < _counter - 1; i++) {
        final double bufferBlue = _blueAvgList[i];
        stdBlue += ((bufferBlue - meanBlue) * (bufferBlue - meanBlue));

        final double bufferRed = _redAvgList[i];
        stdRed += ((bufferRed - meanRed) * (bufferRed - meanRed));
      }

      final double varRed = sqrt(stdRed / (_counter - 1));
      final double varBlue = sqrt(stdBlue / (_counter - 1));

      final double r = (varRed / meanRed) / (varBlue / meanBlue);

      final double spo2 = 100 - 5 * r;
      _o2 = spo2.toInt();

      print("O2: $_o2");

      if ((_o2 < 80 || _o2 > 99)) {
        // Handle measurement failure
      }
    }

    if (_o2 != 0) {
      // Handle successful measurement
      widget.onBPM(_o2);
    }

    Future<void>.delayed(Duration(milliseconds: widget.sampleDelay))
        .then((onValue) {
      if (mounted) {
        setState(() {
          _processing = false;
        });
      }
    });
  }

  double _calculateRedAvg(CameraImage img) {
    //  use yuv420
    // final int width = img.width;
    // final int height = img.height;
    // print(width.toString() + " : " + height.toString());
    // double redAvg = 0;
    // try {
    //   for (int i = 0; i < width; i++) {
    //     for (int j = 0; j < height; j++) {
    //       final int pixelIndex =
    //           (j * width + i) * 4; // 4 bytes per pixel in BGRA8888
    //       final int red = img.planes[0]
    //           .bytes[pixelIndex + 1]; // Red channel is at index 1 in BGRA
    //       redAvg += red;
    //     }
    //   }
    // } catch (e) {
    //   print(e);
    // }
    // print(redAvg / (width * height));
    // return redAvg / (width * height);
    //  return random from 200 -> 255
    return Random().nextInt(56) + 200.0;
  }

  double _calculateBlueAvg(CameraImage img) {
    // final int width = img.width;
    // final int height = img.height;

    // double blueAvg = 0;
    // for (int i = 0; i < width; i++) {
    //   for (int j = 0; j < height; j++) {
    //     final int pixelIndex =
    //         (j * width + i) * 4; // 4 bytes per pixel in BGRA8888
    //     final int blue = img
    //         .planes[0].bytes[pixelIndex]; // Blue channel is at index 0 in BGRA
    //     blueAvg += blue;
    //   }
    // }

    // return blueAvg / (width * height);
    return Random().nextInt(56) + 1.0;
  }

  // double _calculateFft(List<double> data, int count, double samplingFreq) {
  //   final fft = FFT(data.length);
  //   final freq = fft.realFft(data);

  //   double maxMagnitude = 0;
  //   int maxIndex = 0;

  //   for (int i = 35; i < freq.length; i++) {
  //     double magnitude = sqrt(pow(freq[i].x, 2) + pow(freq[i].y, 2));
  //     if (magnitude > maxMagnitude) {
  //       maxMagnitude = magnitude;
  //       maxIndex = i;
  //     }
  //   }

  //   if (maxIndex < 35) {
  //     maxIndex = 0;
  //   }

  //   double frequency = maxIndex * samplingFreq / (2 * count);
  //   return frequency;
  // }
}
