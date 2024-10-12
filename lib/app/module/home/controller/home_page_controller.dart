import 'package:flutter/material.dart';
import 'package:todolistprovider/app/model/todo_model.dart';
import 'package:todolistprovider/app/service/home/home_page_service.dart';

class HomePageController extends ChangeNotifier {
  final HomePageService _homePageService;

  HomePageController(this._homePageService) {
    fetchTodos();
  }

  List<TodoModel> todoList = [];
  List<TodoModel> todoListExecucao = [];
  List<TodoModel> todoListFechados = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchTodos() async {
    isLoading = true;
    notifyListeners();

    try {
      todoList.clear();
      var todos = await _homePageService.findTodo();

      for (var a in todos) {
        if (a.status == 'Aberto') {
          todoList.add(a);
        }
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = "Erro ao consultar tarefas: $e";
      todoList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTodosExecucao() async {
    isLoading = true;
    notifyListeners();

    try {
      todoListExecucao.clear();
      var todos = await _homePageService.findTodo();

      for (var e in todos) {
        if (e.status == 'Em execução') {
          todoListExecucao.add(e);
        }
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = "Erro ao consultar tarefas: $e";
      todoListExecucao = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTodosFechados() async {
    isLoading = true;
    notifyListeners();

    try {
      todoListFechados.clear();
      var todos = await _homePageService.findTodo();

      for (var e in todos) {
        if (e.status == 'Fechado') {
          todoListFechados.add(e);
        }
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = "Erro ao consultar tarefas: $e";
      todoListFechados = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodo({required String id}) async {
    notifyListeners();

    try {
      await _homePageService.deleteTodo(id: id);
      await fetchTodos();
    } catch (e) {
      errorMessage = "Erro ao deletar tarefa: $e";
    } finally {
      notifyListeners();
    }
  }
}
