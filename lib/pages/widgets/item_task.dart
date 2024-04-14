import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/data/models/task.dart';

class ItemTask extends StatelessWidget {
  final Task task;
  const ItemTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              boxShadow: const [
                BoxShadow(color: Colors.black, blurRadius: 3, offset: Offset(0, 1),),
              ]
            ),
            child: Column(
              children: [
                Text(
                  DateFormat(DateFormat.ABBR_MONTH).format(task.createdAt),
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 3),
                Text(
                  DateFormat(DateFormat.DAY).format(task.createdAt),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  DateFormat(DateFormat.YEAR).format(task.createdAt),
                  style: const TextStyle(color: Colors.white70),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    DateFormat(DateFormat.HOUR_MINUTE).format(task.createdAt),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.green),
                  ),
                ],
              ),
              Text(
                task.description,
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
    );
  }
}
