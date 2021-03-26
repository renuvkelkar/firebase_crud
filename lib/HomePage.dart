import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController CityNameController = TextEditingController();
  TextEditingController CityImgController = TextEditingController();
  final ref = Firestore.instance.collection("City");//i am connecting with my books collection

  Map<String,dynamic> cityToAdd;// firestore always need Map to add it key should always String and value will anything so it should be dyanamic
  addCity(){
    cityToAdd ={
      "cityName": CityNameController.text,
      "cityUrl": CityImgController.text,
    };
    ref.add(cityToAdd).whenComplete(() {
      Navigator.pop(context);
       CityNameController.text ="";
        CityImgController.text="";

      print("added to the database");
    });//=> print("added to the database"));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Firebase Crude"),),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: (){
                                      CityNameController.text = snapshot
                                          .data.documents[index].data['cityName'];
                                      CityImgController.text = snapshot
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
                                                child: FlatButton(
                                                  onPressed: (){
                                                    snapshot.data.documents[index].reference.updateData({
                                                      "cityName": CityNameController.text,
                                                      "cityUrl": CityImgController.text,

                                                    }).whenComplete(() => Navigator.pop);
                                                  },
                                                  child: Text("Update"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                     
                                    },                                  
                                    child: Icon(Icons.edit)),
                                Image.network(snapshot.data.documents[index].data["cityUrl"].toString(),height: 100,width: 100,fit: BoxFit.cover,),
                                Text(snapshot.data.documents[index].data["cityName"].toString()),
                                InkWell(onTap: (){
                                  snapshot.data.documents[index].reference.delete().whenComplete(() => Navigator.pop);
                                },
                                    child: Icon(Icons.clear))
                              ],
                            ),
                          ),
                        );

                      }),
                  Container(
                    height: 30,
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
                                      addCity();
                                    },
                                    child: Text("Add"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));

                      }, child: Text("Add")))
                ],
              ),
            );
          }
          else{return CircularProgressIndicator();}
          return Container();
        }
      ),
    );
  }
}
