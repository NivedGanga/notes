import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  int keyV;
   @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  int date;

  NoteModel({required this.title, required this.content, required this.date,required this.keyV});
}

ValueNotifier<List<NoteModel>> notesList = ValueNotifier([]);

//buildrunner code\
// flutter packages pub run build_runner build --delete-conflicting-outputs