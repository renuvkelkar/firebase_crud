import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrude/SubCategoryPage.dart';
import 'package:flutter/material.dart';
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ref = Firestore.instance.collection("Category");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Page"),

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
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SubCategory(snapShot.data.documents[index].data["catName"])));
                                  },
                                  child: Card(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(child: Text(snapShot.data.documents[index].data["catName"],style: TextStyle(fontSize: 30),)),


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

