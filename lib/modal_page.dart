import 'package:db_notes/db_helper.dart';

class noteModel {
  int? nId;
  String nTitle;
  String nDesc;
  String nCreatedAt;

  noteModel(
      {this.nId,
      required this.nTitle,
      required this.nDesc,
      required this.nCreatedAt});

  ///From Map to Model

  //factory noteModel.fromMap(Map<String, dynamic> fmap) {
  static fromMap(Map<String, dynamic> fmap) {
    return noteModel(
        nId: fmap[DbHelper.COLUMN_ID],
        nTitle: fmap[DbHelper.COLUMN_TITLE],
        nDesc: fmap[DbHelper.COLUMN_DESC],
        nCreatedAt: fmap[DbHelper.COLUMN_CREATED_AT]);
  }

  /// toMap from Model

  Map<String, dynamic> toMap(){
    return{
      DbHelper.COLUMN_TITLE : nTitle,
      DbHelper.COLUMN_DESC : nDesc,
      DbHelper.COLUMN_CREATED_AT :nCreatedAt
    };
  }
}
