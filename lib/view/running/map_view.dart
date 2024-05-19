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
import 'package:flutter_background/flutter_background.dart'
    as FlutterBackground;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MapView extends StatefulWidget {
  // const MapView({super.key});

  @override
  State<StatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void updateNotification(String title, String body) {
    showNotification(title, body);
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
    initBackgroundService();
    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    _isDisposed = true;
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  Future<void> initBackgroundService() async {
    const androidConfig = FlutterBackground.FlutterBackgroundAndroidConfig(
      notificationTitle: 'Fitness Tracker',
      notificationText: 'Your location is being tracked',
      notificationImportance:
          FlutterBackground.AndroidNotificationImportance.Default,
      notificationIcon: FlutterBackground.AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Tạo một biểu tượng nhỏ trong drawable
    );
    await FlutterBackground.FlutterBackground.initialize(
        androidConfig: androidConfig);
    await FlutterBackground.FlutterBackground.enableBackgroundExecution();
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

    _location.onLocationChanged.listen((event) {
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

      polyline.add(Polyline(
          polylineId: PolylineId(event.toString()),
          visible: true,
          points: route,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          color: Colors.deepOrange));

      updateNotification(
        'Fitness Tracker',
        'Distance: ${(_dist / 1000).toStringAsFixed(2)} km, Speed: ${_speed.toStringAsFixed(2)} km/h',
      );

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
