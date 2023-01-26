import 'package:flutter/material.dart';
import 'package:simple_flutter_app/records.dart';

class DisplayScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? queryRows;

  const DisplayScreen({Key? key, required this.queryRows}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final List<Records> _records = [];

  void _queryAll() async {
    _records.clear();
    widget.queryRows?.forEach((row) => _records.add(Records.fromMap(row)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Display Records"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _records.length + 1,
                    itemBuilder: (context, int index) {
                      if (index == _records.length) {
                        return ElevatedButton(
                          child: const Text('Refresh'),
                          onPressed: () {
                            setState(() {
                              _queryAll();
                            });
                          },
                        );
                      }
                      return SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            '[${_records[index].id}] - ${_records[index].name} - ${_records[index].email} - ${_records[index].address} - ${_records[index].phone}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
