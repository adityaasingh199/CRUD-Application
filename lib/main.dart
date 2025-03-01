import 'package:db_notes/db_helper.dart';
import 'package:db_notes/db_provider.dart';
import 'package:db_notes/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context){
    return dbProvider(dbHelper: DbHelper.getIns());
    },
  child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

