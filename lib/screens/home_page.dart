import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/models/to_do_item_model.dart';
import '../logic/providers/to_do_provider.dart';
import '../logic/shared/components/to_do_Item_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context, listen: false);
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
        child: Consumer(builder: (context, ToDoProvider provider, child) {
          while (provider.data.isEmpty) {
            provider.getAllData();
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemBuilder: (context, index) => toDoItemComponent(
                ToDoItemModel(provider.data[index].header,
                    provider.data[index].description),
                index),
            itemCount: provider.data.length,
          );
        }),
      ),
      floatingActionButton: Consumer(
        builder: (context, ToDoProvider prov, child) => FloatingActionButton(
          onPressed: () {
            modalSheet(context, prov);
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void modalSheet(BuildContext context, ToDoProvider provider) {
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
                controller: provider.header,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13)),
                    labelText: 'Header'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: provider.description,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13)),
                    labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ToDoProvider provider, child) =>
                    ElevatedButton.icon(
                  onPressed: () {
                    if (provider.description.text.trim() == '' ||
                        provider.header.text.trim() == '') {
                      return;
                    }
                    provider.addItem(ToDoItemModel(
                        provider.header.text, provider.description.text));
                    Navigator.of(context).pop();
                  },
                  label: const Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
      barrierLabel: 'Add Task',
    );
  }
}
