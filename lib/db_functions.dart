import 'package:hive_flutter/adapters.dart';
import 'package:notes_demo/note_model.dart';

addNotes(NoteModel model) async {
  final notesDb = await Hive.openBox<NoteModel>('notes');
  notesList.value.add(model);
  notesList.notifyListeners();
  await notesDb.put(model.keyV, model);
}

getNotes() async {
  final notesDb = await Hive.openBox<NoteModel>('notes');
  notesList.value.addAll(notesDb.values.toList());
  notesList.notifyListeners();
}

deleteNote(int key) async {
  final notesDb = await Hive.openBox<NoteModel>('notes');
  notesList.value.clear();
  notesList.notifyListeners();
  await notesDb.delete(key);
  await getNotes();
}
