class ToDoItemModel {
  ToDoItemModel(this.header, this.description);

  String header;
  String description;

  static Map<String, dynamic> toJson(ToDoItemModel model) {
    return {'title': model.header, 'body': model.description, 'userId': 1};
  }
}

class ToDoModel {
  static List<ToDoItemModel> getAll(List<dynamic> json) {
    List<ToDoItemModel> results = [];
    for (int i = 0; i < 10; i++) {
      results.add(ToDoItemModel(json[i]['title'], json[i]['body']));
    }
    return results;
  }
}
