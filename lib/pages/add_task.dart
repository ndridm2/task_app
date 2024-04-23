import 'package:flutter/material.dart';
import 'package:task_app/data/databases/local_database.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/main.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: -10.0,
        title: const Text(
          'Add',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Staatliches',
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Task task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  createdAt: DateTime.now(),
                );
                LocalDatabase().insertTask(task);
                titleController.clear();
                descriptionController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.blueGrey,
                    content: Text(
                      'Task successfully saved',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MyApp();
                }));
              }
            },
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a task title";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              maxLines: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please write a task description";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
