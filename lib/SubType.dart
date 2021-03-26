import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrude/productPage.dart';
import 'package:flutter/material.dart';
class SubType extends StatefulWidget {

  final  typeName;
  SubType({this.typeName}) ;
  @override
  _SubTypeState createState() => _SubTypeState();
}

class _SubTypeState extends State<SubType> {
  final ref = Firestore.instance.collection("Types");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Type"),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: ref.where("typeName",isEqualTo: widget.typeName).snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                List subCatList =[];
                print(snapshot.data.documents[0].data['subType']);
                    subCatList = snapshot.data.documents[0].data['subType'];


                return Container(
                  height: 400,
                  child: ListView.builder(

                      itemCount: subCatList.length,
                      itemBuilder:(context,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductPage(subCatName :subCatList[index])));
                          },
                          child: Text(subCatList[index],style: TextStyle(
                            fontSize: 20
                          ),),
                        );
                      }),
                );
              }
              else{
                return CircularProgressIndicator();
              }
              }
          )
        ],
      ),
    );
  }
}
