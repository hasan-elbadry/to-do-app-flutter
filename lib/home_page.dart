import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var header = TextEditingController();

  var description = TextEditingController();

  var lists = [
    ToDoModel('Play Sport', 'play on sunday'),
    ToDoModel('study math', '2 lessons')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'To Do App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) => toDoItem(
              ToDoModel(lists[index].header, lists[index].description), index),
          itemCount: lists.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget toDoItem(ToDoModel model, int index) {
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
          IconButton(
              onPressed: () {
                setState(() {
                  lists.removeAt(index);
                });
              },
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  void modalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 35,
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
              const Text(
                "Add Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: header,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13)),
                    labelText: 'Header'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: description,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13)),
                    labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (description.text.trim() == '' ||
                      header.text.trim() == '') {
                    return;
                  }
                  setState(() {
                    lists.add(ToDoModel(header.text, description.text));
                    Navigator.of(context).pop();
                  });
                },
                label: const Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
      barrierLabel: 'Add Task',
    );
  }
}

class ToDoModel {
  ToDoModel(this.header, this.description);

  String header;
  String description;
}
