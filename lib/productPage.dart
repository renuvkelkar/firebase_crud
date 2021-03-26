import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String subCatName;



 ProductPage({this.subCatName}) ;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final prodRef = Firestore.instance.collection("Product");
  @override
  Widget build(BuildContext context) {
   // print(widget.subCatName);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCatName),
      ),
      body: StreamBuilder(
        stream: prodRef.where("subCatName",isEqualTo: widget.subCatName).snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
                return Text(snapshot.data.documents[index].data['prodName']);
              });

        }else{
          return CircularProgressIndicator();
        }
      }
      ),

    );
  }
}
