import 'package:db_notes/db_helper.dart';
import 'package:db_notes/db_provider.dart';
import 'package:db_notes/detailed_page.dart';
import 'package:db_notes/modal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget{


  @override
  State<homePage> createState() => _homePageState();
}
class _homePageState extends State<homePage> {
  TextEditingController nTitleController = TextEditingController();
  TextEditingController nDescController = TextEditingController();

  // DbHelper? mdb;
  List<noteModel> mData = [];

  @override
  void initState() {
    super.initState();
    context.read<dbProvider>().getInitialNotes();
   /* mdb = DbHelper.getIns();
    getAllNotes();*/
  }
 /* void getAllNotes() async{
    mData =await mdb!.fetchAllNotes();
    setState(() {
      
    });
  }*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<dbProvider>(builder: (_, provider,__){
        mData = provider.getAllNotes();
        return mData.isNotEmpty ? ListView.builder(
            itemCount: mData.length,
            itemBuilder: (_,index){
              return Container(
                margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2
                      )
                    ]
                ),
                child: ListTile(
                  title: Text(mData[index].nTitle),
                  subtitle: Text(mData[index].nDesc),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [

                        ///Delete and Edit data

                        IconButton(onPressed: ()async{

                        nTitleController.text = mData[index].nTitle;
                        nDescController.text = mData[index].nDesc;

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

                                      context.read<dbProvider>().updateNotes(id: mData[index].nId!, title: nTitleController.text, desc: nDescController.text);
                                      Navigator.pop(context);
                                      /*bool check = await mdb!.updatesNotes(id: mData[index].nId!, title: nTitleController.text, desc: nDescController.text);
                                      if(check){
                                        getAllNotes();
                                        Navigator.pop(context);
                                      }*/
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

                        context.read<dbProvider>().deleteNotes(mData[index].nId!);

                        /*bool check =await mdb!.deleteNote(mData[index].nId!);
                        if(check){
                          getAllNotes();
                        }*/
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      ],
                    ),
                  ),
                ),
              );
            })
            : Center(
            child: Text("No Notes Avaiable")
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        nTitleController.clear();
        nDescController.clear();

        showModalBottomSheet(context: context, builder: (_){
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2)
                  ),
                ),
                SizedBox(height: 8,),
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

                  /// Disable Long Press on textfield
                  /*contextMenuBuilder: (context,editableTextState){
                    return Container();
                  },*/
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
                      context.read<dbProvider>().addNotes(noteModel(nTitle: nTitleController.text,
                          nDesc: nDescController.text,
                          nCreatedAt: DateTime.now().millisecondsSinceEpoch.toString()));
                      Navigator.pop(context);
                    /*bool check = await mdb!.addNote(newNote: noteModel(
                        nTitle: nTitleController.text,
                        nDesc: nDescController.text,
                        nCreatedAt: DateTime.now().millisecondsSinceEpoch.toString()));
                      if(check){
                        getAllNotes();
                      Navigator.pop(context);
                      }*/

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