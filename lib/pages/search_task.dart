import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/data/databases/local_database.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/pages/detail_task.dart';
import 'package:task_app/pages/widgets/search_widget.dart';

class SearchTask extends StatefulWidget {
  const SearchTask({super.key});

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  List<Task> tasks = [];

  final searchController = TextEditingController();

  bool isLoading = false;

  void searchTasks(String value) async {
    setState(() {
      isLoading = true;
    });
    try {
      tasks = await LocalDatabase().searchTasks(value);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10.0,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Staatliches',
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  hintText: 'Search Task',
                  suffixIcon: Icon(Icons.search, color: Colors.blue,)
              ),
              onChanged: (value) => searchTasks(value),
              onSubmitted: (value) {
                setState(() => isLoading = true);
                searchTasks(value);
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : tasks.isEmpty
                    ? const Center(
                        child: SearchWidget(),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
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
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat(DateFormat.DAY)
                                              .format(tasks[index].createdAt),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat(DateFormat.YEAR)
                                              .format(tasks[index].createdAt),
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      color: Colors.black),
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
                                                .copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tasks[index].description,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
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
          ),
        ],
      ),
    );
  }
}
