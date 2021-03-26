import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrude/displayPage.dart';
import 'package:flutter/material.dart';

import 'model/data-model.dart';
class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ref = Firestore.instance.collection("City");
  TextEditingController CityNameController = TextEditingController();
  TextEditingController CityImgController = TextEditingController();
  Map<String,dynamic>cityToAdd;
  addData(){
    cityToAdd ={
      "cityName": CityNameController.text,
      "cityUrl": CityImgController.text,
    };
    ref.add(cityToAdd).whenComplete((){
      Navigator.pop(context);
      CityNameController.text ="";
      CityImgController.text="";
      print("added to the database");
    }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Page"),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapShot) {
          if(snapShot.hasData){
             
            List<Data> dataList = snapShot.data.documents.map((e) => Data.fromJson(e.data)).toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DisplayPage(dataList[index])));
                        },
                        child: Card(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(

                                  icon: Icon(Icons.edit),
                                onPressed: (){

                                  CityNameController.text = snapShot
                                      .data.documents[index].data['cityName'];
                                  CityImgController.text = snapShot
                                      .data.documents[index].data['cityUrl'];


                                  showDialog(context: context,builder:(_)=>Dialog(
                                    child: Container(
                                      height: 300,
                                      child:
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: CityNameController,
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  labelText: "Name"
                                              ),

                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: CityImgController,
                                              decoration: InputDecoration(
                                                  hintText: "Image",
                                                  labelText: "Image"
                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Container(
                                            height: 50,
                                            width: 120,
                                            color: Colors.blueAccent,
                                            child: MaterialButton(
                                              onPressed: (){
                                               snapShot.data.documents[index].reference.updateData({
                                                 "cityName": CityNameController.text,
                                                 "cityUrl": CityImgController.text,

                                               });


                                              },
                                              child: Text("Upadte"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));

                                },
                              ),
                              SizedBox(width: 10,),
                              Image.network(snapShot.data.documents[index].data["cityUrl"],width: 100,height: 100,),
                              SizedBox(width: 10,),
                              Text(snapShot.data.documents[index].data["cityName"]),
                              InkWell(onTap: (){
                                snapShot.data.documents[index].reference.delete().whenComplete(() => Navigator.pop);
                              },
                                  child: Icon(Icons.clear))

                            ],
                          ),
                        ),
                      );
                    },


                  ),
                  Container(
                    height: 50,
                      width: 300,
                      color: Colors.blue,
                      child: MaterialButton(onPressed: (){
                        showDialog(context: context,builder:(_)=>Dialog(
                          child: Container(
                            height: 300,
                            child:
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: CityNameController,
                                    decoration: InputDecoration(
                                        hintText: "Name",
                                        labelText: "Name"
                                    ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: CityImgController,
                                    decoration: InputDecoration(
                                        hintText: "Image",
                                        labelText: "Image"
                                    ),

                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  height: 50,
                                  width: 120,
                                  color: Colors.blueAccent,
                                  child: FlatButton(
                                    onPressed: (){
                                      addData();

                                    },
                                    child: Text("Add"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                      }, child: Text("Add New")))
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

    );
  }
}
