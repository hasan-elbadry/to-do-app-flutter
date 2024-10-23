import 'package:flutter/material.dart';

import '../models/to_do_item_model.dart';

class ToDoProvider extends ChangeNotifier {
  var header = TextEditingController();
  var description = TextEditingController();

  var lists = [
    ToDoItemModel('Play Sport', 'play on sunday'),
    ToDoItemModel('study math', '2 lessons')
  ];

  void removeItem(int index) {
    lists.removeAt(index);
    notifyListeners();
  }

  void addItem(ToDoItemModel model) {
    lists.add(model);
    notifyListeners();
  }
}
