import 'package:db_notes/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class detailedPage extends StatelessWidget{
  String nTitle;
  String nDesc;
  int index;
  String flag;
  detailedPage({required this.nTitle,required this.nDesc,required this.flag,required this.index});

  @override
  Widget build(BuildContext context) {
    TextEditingController nTitleController = TextEditingController();
    TextEditingController nDescController = TextEditingController();
    nTitleController.text= nTitle;
    nDescController.text= nDesc;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 15,),
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
              ElevatedButton(onPressed: (){
                /*if(nTitleController.text.isNotEmpty && nDescController.text.isNotEmpty){
                  if (flag == "add") {
                    context.read<dbProvider>().addValue({
                      "name": nTitleController.text,
                      "msg": nDescController.text
                    });
                    Navigator.pop(context);
                  } else {
                   context.read<dbProvider>().updateValue(index, {
                      "name": nTitleController.text,
                      "msg": nDescController.text
                    });
                    Navigator.pop(context);
                  }
                }*/
              }, child: Text("Save",style: TextStyle(color: Colors.black),)),
            ],
          ),
        ),
      ),
    );
  }
}