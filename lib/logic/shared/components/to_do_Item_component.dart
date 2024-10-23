import 'package:flutter/material.dart';
import 'package:todo_app/logic/providers/to_do_provider.dart';
import '../../models/to_do_item_model.dart';
import 'package:provider/provider.dart';

Widget toDoItemComponent(ToDoItemModel model, int index) {
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 5),
    decoration: BoxDecoration(
      color: Colors.purple,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.header,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              model.description,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        const Spacer(),
        Consumer(
          builder: (context,ToDoProvider provider, child) => IconButton(
              onPressed: () {
                  provider.removeItem(index);
              },
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              )),
        )
      ],
    ),
  );
}
