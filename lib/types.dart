import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrude/SubType.dart';
import 'package:flutter/material.dart';
class Types extends StatefulWidget {
  @override
  _TypesState createState() => _TypesState();
}

class _TypesState extends State<Types> {
  @override
  Widget build(BuildContext context) {
    final ref = Firestore.instance.collection("Types");
    return Scaffold(
      appBar: AppBar(
        title: Text("Types"),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>snapShot) {
                if(snapShot.hasData){

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapShot.data.documents.length,
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (_)=>DisplayPage(dataList[index])));
                              },
                              child: Center(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SubType(typeName:snapShot.data.documents[index].data["typeName"])));
                                  },
                                  child: Card(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(child: Text(snapShot.data.documents[index].data["typeName"],style: TextStyle(fontSize: 30),)),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },


                        ),

                      ],
                    ),
                  );
                }
                else{
                  return CircularProgressIndicator();
                }

                return Column(
                  children: [

                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}
