import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/color_extension.dart';
import '../../common/request_status.dart';
import '../../common_widget/notification_row.dart';
import '../../model/notification.dart';
import '../../service/notification_service.dart';

class NotificationView extends StatefulWidget {
  final String userId;
  const NotificationView({super.key,required this.userId});


  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<AppNotification> notificationArr = [];
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    // _createRandomNotifications();
    fetchNotifications();
  }


  Future<void> fetchNotifications() async {
    NotificationService notificationService = NotificationService();
    List<AppNotification> notifications = (await notificationService
        .findNotificationsByUserId(widget.userId))
        .cast<AppNotification>();
    setState(() {
      notificationArr = notifications;
      logger.d(notificationArr.length);
    });
  }

  Future<void> createNotification(AppNotification notification) async {
    NotificationService notificationService = NotificationService();
    var result = await notificationService.createNotification(notification);
    if (result['status'] == RequestStatus.request201Created) {
      logger.d("Notification created with ID: ${result['data']}");
      // Optionally refresh the notifications list
      fetchNotifications();
    } else {
      logger.e("Failed to create notification: ${result['data']}");
    }
  }

  void _createRandomNotifications() {
    for (int i = 0; i < 5; i++) {
      _createRandomNotification();
    }
  }

  void _createRandomNotification() {
    var newNotification = AppNotification(
      message: "New Notification",
      image: "assets/img/Workout1.png",
      userId: widget.userId,
      type: "info",
      time: DateTime.now(),
      state: true,
    );
    createNotification(newNotification); // Call method to create the new notification
  }

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
          "Notification",
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
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          itemBuilder: ((context, index) {
            var nObj = notificationArr[index];
            return NotificationRow(nObj: nObj.toMap());
          }), separatorBuilder: (context, index){
        return Divider(color: TColor.gray.withOpacity(0.5), height: 1, );
      }, itemCount: notificationArr.length),
    );
  }
}