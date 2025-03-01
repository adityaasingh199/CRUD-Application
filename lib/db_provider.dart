import 'package:db_notes/db_helper.dart';
import 'package:db_notes/modal_page.dart';
import 'package:flutter/foundation.dart';

class dbProvider extends ChangeNotifier{

  DbHelper dbHelper;
  dbProvider({required this.dbHelper});

  List<noteModel> _mNotes = [];
  List<noteModel> getAllNotes() => _mNotes;

  void addNotes(noteModel newNote)async{
    bool check = await dbHelper.addNote(newNote: newNote);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void deleteNotes(int id)async{
    bool check = await dbHelper.deleteNote(id);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }
  void updateNotes({required int id, required String title, required String desc})async{
    bool check =await dbHelper.updatesNotes(id: id, title: title, desc: desc);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void getInitialNotes() async{
  _mNotes = await dbHelper.fetchAllNotes();
  notifyListeners();
 }

}