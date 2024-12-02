import 'package:find_flames_project/home/models/todo_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title) {
    state = [...state, Todo(title: title)];
  }

  void toggleTodo(int index) {
    final updatedTodos = state.map((todo) {
      if (state.indexOf(todo) == index) {
        return Todo(title: todo.title, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    state = updatedTodos;
  }

  void deleteTodo(int index) {
    state = state.where((todo) => state.indexOf(todo) != index).toList();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
