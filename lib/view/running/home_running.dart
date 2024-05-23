import 'package:fitness/model/running_property.dart';
import 'package:flutter/material.dart';
import 'package:fitness/view/running/map_view.dart' as map_view;
import 'package:fitness/view/running/running_property_card.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeRunning extends StatefulWidget {
  const HomeRunning({Key? key}) : super(key: key);

  @override
  _HomeRunningState createState() => _HomeRunningState();
}

class _HomeRunningState extends State<HomeRunning> {
  final List<RunningProperty> _data = [
    RunningProperty(
        id: 1,
        // date: "2024-05-19".padLeft(2, '0'),
        date: DateFormat.yMMMMd('en_US')
            .format(DateTime.now().subtract(const Duration(days: 1))),
        duration:
            "${StopWatchTimer.getDisplayTimeHours(200000 ~/ 6.7)}:${StopWatchTimer.getDisplayTimeMinute(200000 ~/ 6.7)}:${StopWatchTimer.getDisplayTimeSecond(200000 ~/ 6.7)}",
        speed: 6.7,
        distance: 200),
    RunningProperty(
        id: 3,
        date: DateFormat.yMMMd('en_US')
            .format(DateTime.now().subtract(const Duration(days: 1))),
        duration:
            "${StopWatchTimer.getDisplayTimeHours(1200000 ~/ 7.3)}:${StopWatchTimer.getDisplayTimeMinute(1200000 ~/ 7.3)}:${StopWatchTimer.getDisplayTimeSecond(1200000 ~/ 7.3)}",
        speed: 7.3,
        distance: 1200),
    RunningProperty(
        id: 5,
        date: DateFormat.yMMMd('en_US')
            .format(DateTime.now().subtract(const Duration(days: 2))),
        duration:
            "${StopWatchTimer.getDisplayTimeHours(150000 ~/ 5.1)}:${StopWatchTimer.getDisplayTimeMinute(150000 ~/ 5.1)}:${StopWatchTimer.getDisplayTimeSecond(150000 ~/ 5.1)}",
        speed: 5.1,
        distance: 150),
  ];

  List<RunningPropertyCard> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchRunningProperty();
  }

  void _fetchRunningProperty() async {
    _cards = [];

    // for (var element in _data) {
    //   _cards.add(RunningPropertyCard(runningProperty: element));
    // }
    // for ngược
    for (var i = _data.length - 1; i >= 0; i--) {
      _cards.add(RunningPropertyCard(runningProperty: _data[i]));
    }
    setState(() {});
  }

  void _addRunningProperty(RunningProperty newRunningProperty) {
    // DB.insert(Entry.table, en);
    print(1234);

    _data.add(newRunningProperty);
    _fetchRunningProperty();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Running tracker"),
      ),
      body: ListView(
        children: _cards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => map_view.MapView(),
            ),
          ).then((value) => _addRunningProperty(value)),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
