import 'package:flutter/material.dart';

class SummaryClass extends StatefulWidget {
  SummaryClass({Key key, this.summaryList}) : super(key: key);
  List summaryList = [];
  @override
  _SummaryClassState createState() => _SummaryClassState();
}

class _SummaryClassState extends State<SummaryClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: ListView.builder(
        itemCount: widget.summaryList.length,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            title:Row(
              children: [
                Text('Question${index + 1}:  '),
                Text(widget.summaryList[index] ? 'Correct' : 'Wrong', style: TextStyle(color: widget.summaryList[index] ? Colors.green : Colors.red),),
              ],
            ),
            onTap: (){
              print(index);
            },
          );
        },
      ),
    );
  }
}