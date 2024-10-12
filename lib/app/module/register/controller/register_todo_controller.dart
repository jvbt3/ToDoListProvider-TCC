import 'package:flutter/material.dart';
import 'package:todolistprovider/app/model/todo_model.dart';
import 'package:todolistprovider/app/service/register/register_todo_service.dart';

class RegisterTodoController extends ChangeNotifier {
  final RegisterTodoService _registerTodoService;

  RegisterTodoController(this._registerTodoService);

  String? errorMessage;
  bool isLoading = false;

  Future<void> registerTodos({required TodoModel todoModel}) async {
    isLoading = true;
    notifyListeners();

    try {
      await _registerTodoService.registerTodo(todoModel: todoModel);
      errorMessage = null;
    } catch (e) {
      errorMessage = "Erro ao cadastrar tarefas: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
