import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrude/productPage.dart';

import 'package:flutter/material.dart';


class SubCategory extends StatefulWidget {
  final catname;

  SubCategory(this.catname);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final catRef = Firestore.instance.collection("Category");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SubCategory"),
      ),
      body: StreamBuilder(
          stream: catRef.where("catName", isEqualTo: widget.catname).snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List SubCatList = [];

              SubCatList = snapshot.data.documents[0].data['subCat'];
              print("SubCatelist" + SubCatList.toString());
              return Container(
                  height:300,
                  child: ListView.builder(

                    itemCount: SubCatList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductPage(subCatName :SubCatList[index])));
                        },
                        child: Card(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(SubCatList[index]),
                        )),
                      );
                    },
                  ));
            } else {
              return Text('loading');
            }
          }),
    );
  }
}
