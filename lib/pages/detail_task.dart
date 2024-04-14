import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:task_app/data/databases/local_database.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/main.dart';
import 'package:task_app/pages/edit_task.dart';

class DetailTask extends StatefulWidget {
  const DetailTask({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedFloatingActionButtonState> key =
        GlobalKey<AnimatedFloatingActionButtonState>();

    Widget float1() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return EditTask(task: widget.task);
            }));
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          heroTag: "btn1",
          tooltip: 'Edit',
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget float2() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete task',
                        style: TextStyle(color: Colors.black)),
                    content: const Text('Are you sure?',
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: () async {
                          await LocalDatabase().deleteTask(widget.task.id!);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const MyApp();
                          }));
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                });
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.red,
          heroTag: "btn2",
          tooltip: 'Delete',
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(
              Icons.refresh,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.task.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Oxygen',
            ),
          ),
          const SizedBox(height: 30),
          Text(
            widget.task.description,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Oxygen',
            ),
          )
        ],
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[float1(), float2()],
          key: key,
          colorStartAnimation: Colors.blueGrey,
          colorEndAnimation: Colors.white,
          animatedIconData: AnimatedIcons.menu_close),
    );
  }
}
