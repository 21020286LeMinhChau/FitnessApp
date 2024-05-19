import 'package:fitness/model/running_property.dart';
import 'package:flutter/material.dart';
import 'package:fitness/view/running/map_view.dart' as map_view;
import 'package:fitness/view/running/running_property_card.dart';

class HomeRunning extends StatefulWidget {
  const HomeRunning({Key? key}) : super(key: key);

  @override
  _HomeRunningState createState() => _HomeRunningState();
}

class _HomeRunningState extends State<HomeRunning> {
  late List<RunningProperty> _data;
  List<RunningPropertyCard> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchRunningProperty();
  }

  void _fetchRunningProperty() async {
    _cards = [];
    // List<Map<String, dynamic>> _results = await DB.query(RunningProperty.table);
    // List<Map<String, dynamic>> _results = [];
    // _data = _results.map((item) => RunningProperty.fromMap(item)).toList();

    _data = List.generate(10, (index) {
      return RunningProperty(
        id: index,
        date: "2022-01-${index + 1}".padLeft(2, '0'),
        duration: "${(index + 1) * 10}:00",
        speed: (index + 1) * 2.0,
        distance: (index + 1) * 1.0,
      );
    });

    for (var element in _data) {
      _cards.add(RunningPropertyCard(runningProperty: element));
    }

    setState(() {});
  }

  void _updateRunningProperty() async {}

  void _addRunningProperty(RunningProperty en) async {
    // DB.insert(Entry.table, en);

    _updateRunningProperty();

    _cards.add(RunningPropertyCard(runningProperty: en));
    setState(() {});

    // _fetchRunningProperty();
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
