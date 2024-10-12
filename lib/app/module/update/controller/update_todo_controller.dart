import 'package:flutter/material.dart';
import 'package:todolistprovider/app/model/todo_model.dart';
import 'package:todolistprovider/app/service/update/update_todo_service.dart';

class UpdateTodoController extends ChangeNotifier {
  final UpdateTodoService _updateTodoService;

  UpdateTodoController(this._updateTodoService);

  String? errorMessage;
  bool isLoading = false;

  Future<void> updateTodos({required TodoModel todoModel}) async {
    isLoading = true;
    notifyListeners();

    try {
      await _updateTodoService.updateTodo(todoModel: todoModel);
      errorMessage = null;
    } catch (e) {
      errorMessage = "Erro ao atualizar tarefa: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
