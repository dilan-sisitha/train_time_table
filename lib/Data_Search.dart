import 'package:flutter/material.dart';
import 'package:train_time_table/Results_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSearch extends SearchDelegate<String>{

  final refno = ["1173B","1173C","1173D","1173E","1173F","1173H","1173I","1173J","1173K","1173L","1173M","1173N"];
  final recent = ["1173B","1173C","1173D" ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  String selectedResult ="";
  @override
  Widget buildResults(BuildContext context) {
    debugPrint("select");
    return Container(
      child: Column(
        children: [
          Text(query),
          Text(selectedResult)
        ],
      )

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    if(query.isEmpty){
      suggestionList = refno;
    }else if(query.length>=3){
      suggestionList.addAll(refno.where(
        // In the false case
            (element) => element.contains(query),
      ));
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },

        );
      },
    );
  }

}