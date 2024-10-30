import 'package:dio/dio.dart';
import 'package:todo_app/logic/models/to_do_item_model.dart';

class ApiService {
  static var dio = Dio();

  static Future<List<ToDoItemModel>> getAll() async {
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    return ToDoModel.getAll(response.data);
  }

  static Future<void> addAsync(ToDoItemModel model) async {
    var response = await dio.post('https://jsonplaceholder.typicode.com/posts',
        data: ToDoItemModel.toJson(model));
    print(response.statusCode);
    print(response.data);
  }
}
