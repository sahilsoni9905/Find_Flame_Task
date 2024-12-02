import 'package:find_flames_project/home/controllers/home_controller.dart';
import 'package:find_flames_project/home/models/todo_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(todoProvider);
    final todoNotifier = ref.read(todoProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: buildTodoSection(todoState, todoNotifier),
    );
  }

  Widget buildTodoSection(List<Todo> todoState, TodoNotifier todoNotifier) {
    TextEditingController controller = TextEditingController();
    String warningMessage = '';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        todoNotifier.addTodo(value);
                        controller.clear();
                      } else {
                        warningMessage = 'Please enter a todo!';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Add a Todo',
                      border: OutlineInputBorder(),
                      hintText: 'Enter a todo item...',
                      errorText: warningMessage.isNotEmpty ? warningMessage : null,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.deepPurple),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      todoNotifier.addTodo(controller.text);
                      controller.clear();
                    } else {
                      warningMessage = 'Please enter a todo!';
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoState.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  title: Text(
                    todoState[index].title,
                    style: TextStyle(
                      decoration: todoState[index].isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => todoNotifier.deleteTodo(index),
                  ),
                  onTap: () => todoNotifier.toggleTodo(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}