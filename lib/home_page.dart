import 'package:db_notes/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget{
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController nTitleController = TextEditingController();
  TextEditingController nDescController = TextEditingController();

  DbHelper? mdb;
  List<Map<String,dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    mdb = DbHelper.getIns();
    getAllNotes();
  }

  void getAllNotes() async{
    mData =await mdb!.fetchAllNotes();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mData.isNotEmpty ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_,index){
            return ListTile(
              title: Text(mData[index][DbHelper.COLUMN_TITLE]),
              subtitle: Text(mData[index][DbHelper.COLUMN_DESC]),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: (){

                      nTitleController.text = mData[index][DbHelper.COLUMN_TITLE];
                      nDescController.text = mData[index][DbHelper.COLUMN_DESC];

                      showModalBottomSheet(context: context, builder: (_){
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                          ),
                          child: Column(
                            children: [
                              Text("Add Note",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              TextField(
                                controller: nTitleController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    label: Text('Title'),
                                    hintText: "Enter Title here",
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder()
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextField(
                                controller: nDescController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    label: Text('Description'),
                                    hintText: "Enter Description here",
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder()
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(onPressed: ()async{
                                    bool check = await mdb!.updatesNotes(id: mData[index][DbHelper.COLUMN_ID], title: nTitleController.text, desc: nDescController.text);
                                    if(check){
                                      getAllNotes();
                                      Navigator.pop(context);
                                    }

                                  }, child: Text('Update')),
                                  SizedBox(width: 10,),
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text('Cancel'))
                                ],
                              )
                            ],
                          ),
                        );
                      });

                    }, icon: Icon(Icons.edit,)),
                    IconButton(onPressed: ()async{
                      bool check =await mdb!.deleteNote(mData[index][DbHelper.COLUMN_ID]);
                      if(check){
                        getAllNotes();
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                  ],
                ),
              ),
            );
      }) : Center(child: Text("No Notes Avaiable")),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        /*bool check = await mdb!.addNote(title: "new notes", desc: "my name is aditya");
        if(check){
          print(("note added"));
          getAllNotes();
        }*/

        nTitleController.clear();
        nDescController.clear();

        showModalBottomSheet(context: context, builder: (_){
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
            ),
            child: Column(
              children: [
                Text("Add Note",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextField(
                  controller: nTitleController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('Title'),
                    hintText: "Enter Title here",
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: nDescController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      label: Text('Description'),
                      hintText: "Enter Description here",
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: ()async{
                    bool check = await mdb!.addNote(title: nTitleController.text, desc: nDescController.text);
                      if(check){
                        getAllNotes();
                      Navigator.pop(context);
                      }

                    }, child: Text('Add')),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel'))
                  ],
                )
              ],
          ),
          );
        });

      },child: Icon(Icons.add),),
    );
  }
}