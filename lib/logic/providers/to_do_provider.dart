import 'package:flutter/material.dart';
import 'package:todo_app/logic/api_service.dart';

import '../models/to_do_item_model.dart';

class ToDoProvider extends ChangeNotifier {
  var header = TextEditingController();
  var description = TextEditingController();

  List<ToDoItemModel> data = [];

  Future<void> getAllData() async {
    data = await ApiService.getAll();
    notifyListeners();
  }

  void removeItem(int index) {
    data.removeAt(index);
    notifyListeners();
  }

  Future<void> addItem(ToDoItemModel model) async {
    await ApiService.addAsync(model);
    await getAllData();
    notifyListeners();
  }
}
