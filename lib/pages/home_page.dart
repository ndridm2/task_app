
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/data/databases/local_database.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/pages/add_task.dart';
import 'package:task_app/pages/detail_task.dart';
import 'package:task_app/pages/search_task.dart';
import 'package:task_app/pages/widgets/notask_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Color> lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
  ];
  
  List<Task> tasks = [];

  bool isLoading = false;

  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
    });
    tasks = await LocalDatabase().getTasks();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.black, fontFamily: 'Staatliches'),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SearchTask();
              }));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () => setState(() {
              getTasks();
            }),
            icon: const Icon(
              Icons.refresh,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? const Center(
                  child: NoTaskWidget(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailTask(task: tasks[index]);
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: lightColors[index],
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat(DateFormat.ABBR_MONTH)
                                        .format(tasks[index].createdAt),
                                    style:
                                        const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat(DateFormat.DAY)
                                        .format(tasks[index].createdAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat(DateFormat.YEAR)
                                        .format(tasks[index].createdAt),
                                    style:
                                        const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        tasks[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontFamily: 'Jersey20',
                                                fontSize: 24),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(DateFormat.HOUR_MINUTE)
                                          .format(tasks[index].createdAt),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Text(
                                  tasks[index].description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    fontFamily: 'Oxygen',
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: tasks.length,
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTask();
          }));
          getTasks();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
