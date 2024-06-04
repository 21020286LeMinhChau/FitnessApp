
import 'package:fitness/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../common/request_status.dart';
import '../service/notification_service.dart';

class NotificationRow extends StatefulWidget {
  final Map nObj;
  const NotificationRow({super.key, required this.nObj});

  @override
  _NotificationRowState createState() => _NotificationRowState();
}

class _NotificationRowState extends State<NotificationRow> {
  bool isNew = true;
  var logger = Logger();

  Future<void> updateNotification(String notificationId, Map<String, dynamic> updatedData) async {
    NotificationService notificationService = NotificationService();
    logger.d(notificationId);
    var result = await notificationService.updateNotification(notificationId,updatedData);
    if (result['status'] == RequestStatus.request200Ok) {
      logger.d("Notification updated with ID: ${result['data']}");
    } else {
      logger.e("Failed to update notification: ${result['data']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isNew = false;
          });
          await updateNotification(widget.nObj["id"].toString(), {'state':false});
        },
        child: Row(
          children: [
            if (isNew)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.fiber_new_outlined,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                widget.nObj["image"].toString(),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nObj["message"].toString(),
                    style: TextStyle(
                      color: TColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    getTimeDifferenceString(widget.nObj["time"]),
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: SizedBox(
                    width: 100,
                    height: 55,
                    child: Center(
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: const Text(
                          "Delete",
                          style: TextStyle(fontSize: 12),
                        ),
                        onTap: () {
                          // Thực hiện xóa notification
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTimeDifferenceString(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} giây trước";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else {
      return DateFormat('dd-MM-yyyy').format(time);
    }
  }
}
