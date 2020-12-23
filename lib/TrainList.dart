import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:train_time_table/TrainDetails.dart';
import 'package:http/http.dart' as http;

class TrainList extends StatefulWidget {
  @override
  _TrainListState createState() => _TrainListState();
}

class _TrainListState extends State<TrainList> {

  List<TrainDetails> _traindetails = List<TrainDetails>();
  Future fetchNotes() async{
    var url = 'http://192.168.1.100:8080/demo/shedules?refno=1105';
    var response = await http.get(url);

    var traindetails = List<TrainDetails>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        traindetails.add(TrainDetails.fromJson(noteJson));
      }
    }
    return traindetails;
  }
  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _traindetails.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter listview with json'),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(

            children: [
              Text("details",

                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,

              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20.0, right: 0),
                child: Align(

                  alignment:Alignment.topLeft ,

                  child: Text("form no",
                    style: TextStyle(
                        fontSize: 20

                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20.0, right: 0),
                child: Align(
                  alignment:Alignment.topLeft ,
                  child: Text("pt",
                    style: TextStyle(
                        fontSize: 20
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: <Widget>[
                            Text(
                              _traindetails[index].arrival,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(

                              _traindetails[index].departure,
                              style: TextStyle(
                                  color: Colors.grey.shade600
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _traindetails.length,
                ),
              )

            ],
          ),
        )
    );
  }
}
