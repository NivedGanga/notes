import 'package:flutter/material.dart';



class NoteModel {

  int keyV;

  String title;

  String content;

  int date;

  NoteModel({required this.title, required this.content, required this.date,required this.keyV});
}

ValueNotifier<List<NoteModel>> notesList = ValueNotifier([]);
