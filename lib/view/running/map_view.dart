// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:fitness/model/running_property.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:fitness/model/entry.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  print('onStart SERVICE 1');
  DartPluginRegistrant.ensureInitialized();
  print('onStart SERVICE 2');
  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  // bring to foreground
  Timer.periodic(const Duration(milliseconds: 500), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        // flutterLocalNotificationsPlugin.show(
        //   888,
        //   'COOL SERVICE',
        //   'Awesome ${DateTime.now()}',
        //   const NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       'my_foreground',
        //       'MY FOREGROUND SERVICE',
        //       icon: 'ic_bg_service_small',
        //       ongoing: true,
        //     ),
        //   ),
        // );

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.reload();
        double distance = preferences.getDouble("distance_running") ?? 0;
        int time = preferences.getInt("time_running") ?? 0;
        double speed = preferences.getDouble("speed_running") ?? 0;

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "Running tracking",
          content:
              "Distance: ${(distance / 1000).toStringAsFixed(2)} km   Time: ${(time ~/ 1000 + 1).toString()} s   Speed: ${speed.toStringAsFixed(2)} km/h",
        );
      }
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }
    //  get time_, distance_, speed_ from shared preferences

    service.invoke(
      'update',
      {
        'device': device,
      },
    );
  });
}

class MapView extends StatefulWidget {
  // const MapView({super.key});

  @override
  State<StatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_bg_service_small'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    print('initializeService SERVICE 3');
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: true,

        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'FITNESS APP',
        initialNotificationContent: 'Start tracking your running now!',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
  }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.reload();
    // final log = preferences.getStringList('log') ?? <String>[];
    // log.add(DateTime.now().toIso8601String());
    // await preferences.setStringList('log', log);

    return true;
  }

  final Set<Polyline> polyline = {};
  final Location _location = Location();
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(0, 0);
  List<LatLng> route = [];

  double _dist = 0;
  late String _displayTime;
  late int _time;
  late int _lastTime;
  double _speed = 0;
  double _avgSpeed = 0;
  int _speedCounter = 0;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  bool _isDisposed = false;
  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onStartTimer();

    initializeService();
  }

  @override
  void dispose() async {
    super.dispose();
    _isDisposed = true;
    // stop service
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  Future<void> moveToCurrentLocation() async {
    try {
      // Lấy vị trí hiện tại của người dùng
      LocationData currentLocation = await _location.getLocation();
      LatLng currentLatLng =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      // Cập nhật vị trí camera tới vị trí hiện tại của người dùng
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 20),
      ));
    } catch (e) {
      // Xử lý lỗi nếu không lấy được vị trí
      print("Không thể lấy được vị trí hiện tại: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    await moveToCurrentLocation();

    double appendDist;

    _location.onLocationChanged.listen((event) async {
      if (_isDisposed) return; // Check if the widget is disposed
      LatLng loc = LatLng(event.latitude!, event.longitude!);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: loc, zoom: 20)));

      if (route.isNotEmpty) {
        appendDist = Geolocator.distanceBetween(route.last.latitude,
            route.last.longitude, loc.latitude, loc.longitude);
        _dist = _dist + appendDist;
        int timeDuration = (_time - _lastTime);

        if (timeDuration != 0) {
          _speed = (appendDist / (timeDuration / 100)) * 3.6;
          if (_speed != 0) {
            _avgSpeed = _avgSpeed + _speed;
            _speedCounter++;
          }
        }
      }
      _lastTime = _time;
      route.add(loc);

      //  save time, distance, speed to shared preferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setDouble("distance_running", _dist);
      await preferences.setInt("time_running", _time);
      await preferences.setDouble("speed_running", _speed);

      polyline.add(Polyline(
          polylineId: PolylineId(event.toString()),
          visible: true,
          points: route,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          color: Colors.deepOrange));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              polylines: polyline,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(target: _center, zoom: 11),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                height: 150,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("SPEED (KM/H)",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w300)),
                            Text(_speed.toStringAsFixed(2),
                                style: GoogleFonts.montserrat(
                                    fontSize: 30, fontWeight: FontWeight.w300))
                          ],
                        ),
                        Column(
                          children: [
                            Text("TIME",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w300)),
                            StreamBuilder<int>(
                              stream: _stopWatchTimer.rawTime,
                              initialData: 0,
                              builder: (context, snap) {
                                _time = snap.data!;
                                _displayTime = StopWatchTimer
                                        .getDisplayTimeHours(_time) +
                                    ":" +
                                    StopWatchTimer.getDisplayTimeMinute(_time) +
                                    ":" +
                                    StopWatchTimer.getDisplayTimeSecond(_time);
                                return Text(_displayTime,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300));
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("DISTANCE (KM)",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w300)),
                            Text((_dist / 1000).toStringAsFixed(2),
                                style: GoogleFonts.montserrat(
                                    fontSize: 30, fontWeight: FontWeight.w300))
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    IconButton(
                      icon: Icon(
                        Icons.stop_circle_outlined,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        RunningProperty en = RunningProperty(
                            //  set random id by the time
                            id: DateTime.now().millisecondsSinceEpoch,
                            date: DateFormat.yMMMMd('en_US')
                                .format(DateTime.now()),
                            duration: _displayTime,
                            speed: _speedCounter == 0
                                ? 0
                                : _avgSpeed / _speedCounter,
                            distance: _dist);

                        Navigator.pop(context, en);
                      },
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
