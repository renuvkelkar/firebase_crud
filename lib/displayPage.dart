import 'package:flutter/material.dart';

import 'model/data-model.dart';
class DisplayPage extends StatefulWidget {

  final Data  dataList;

   DisplayPage(this.dataList) ;
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
           children: [
             Text(widget.dataList.cityName),
           Image.network(widget.dataList.cityUrl)
           ],
        ),
      )
//      Column(
//        children: [
//          Text(widget.name),
//          Image.network(widget.image)
//        ],
//      ),
    );
  }
}
