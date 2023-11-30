import 'package:flutter/material.dart';
import 'package:notes_demo/add_note.dart';
import 'package:notes_demo/note_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final colors = const [
    Color.fromRGBO(205, 255, 166, 1),
    Color.fromRGBO(243, 224, 158, 1),
    Color.fromRGBO(165, 234, 255, 1),
    Color.fromRGBO(242, 157, 224, 1),
    Color.fromRGBO(213, 157, 255, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: AppBar(
          toolbarHeight: 120,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Notes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNote(),
          ));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(34, 36, 51, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: notesList,
              builder: (context, notesList, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            children: List.generate(notesList.length, (index) {
                              if (index.isEven) {
                                return NoteWidget(
                                  title: notesList[index].title,
                                  content: notesList[index].content,
                                  color: colors[index % (colors.length)],
                                );
                              }
                              return const SizedBox(
                                height: 15,
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(notesList.length, (index) {
                              if (index.isOdd) {
                                return Column(
                                  children: [
                                    NoteWidget(
                                      title: notesList[index].title,
                                      content: notesList[index].content,
                                      color: colors[index % (colors.length)],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                );
                              }
                              return const SizedBox();
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.title,
    required this.content,
    required this.color,
  });

  void showPopupMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Animation<double> scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.fastOutSlowIn,
      ),
    );

    final RelativeRect positionRect = RelativeRect.fromRect(
      Rect.fromPoints(position, position.translate(0.0, 1.0)),
      Offset.zero & overlay.size,
    );

    showMenu(
      color: Colors.white,
      context: context,
      position: positionRect,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 'item3',
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Theme.of(context).colorScheme.tertiary,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    elevation: MaterialStateProperty.all(50),
                  ),
                  //speaking the mispronounced word
                  onPressed: () {},
                  icon: Icon(
                    Icons.multitrack_audio_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {});
  }

  final String title;
  final String content;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNote(
            title: title,
            content: content,
          ),
        ));
      },
      onLongPressEnd: (details) {
        showPopupMenu(
          context,
          details.globalPosition,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              content,
              maxLines: 8,
              overflow: TextOverflow.fade,
              style: const TextStyle(height: 1.4),
            )
          ],
        ),
      ),
    );
  }
}
