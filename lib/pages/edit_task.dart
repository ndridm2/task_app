import 'package:flutter/material.dart';
import 'package:task_app/data/databases/local_database.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/main.dart';

class EditTask extends StatefulWidget {
  const EditTask({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const MyApp();
            }));
          },
          icon: const Icon(
            Icons.home,
            color: Colors.blueGrey,
          ),
        ),
        titleSpacing: -10.0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.blueGrey,
            fontFamily: 'Staatliches',
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Task task = Task(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdAt: DateTime.now());
                LocalDatabase().updateTask(task);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.blueGrey,
                    content: Text('Task updated successfully',
                        style: TextStyle(color: Colors.white))));
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MyApp();
                }));
              }
            },
            icon: const Icon(Icons.done, color: Colors.green),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}
