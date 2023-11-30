import 'package:flutter/material.dart';
import 'package:notes_demo/db_functions.dart';
import 'package:notes_demo/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.title, this.content});
  final String? title;
  final String? content;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  late final int flag;
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    if (widget.title != null || widget.content != null) {
      flag = 1;
    } else {
      flag = 0;
    }
    titleController.text = widget.title ?? "";
    descriptionController.text = widget.content ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          flag == 0 ? "Add Note" : "",
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          flag == 0
              ? GestureDetector(
                  child: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      return;
                    }
                    final NoteModel noteModel = NoteModel(
                        keyV: notesList.value.length,
                        title: titleController.text,
                        content: descriptionController.text,
                        date: DateTime.now().millisecondsSinceEpoch);
                    await addNotes(noteModel);
                    Navigator.of(context).pop();
                  },
                )
              : const SizedBox(),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              enabled: flag == 1 ? false : true,
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
              ),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: TextField(
                enabled: flag == 1 ? false : true,
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
