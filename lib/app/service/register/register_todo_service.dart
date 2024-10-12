import 'package:dio/dio.dart';
import 'package:todolistprovider/app/model/todo_model.dart';

abstract class RegisterTodoService {
  Future<Response> registerTodo({
    required TodoModel todoModel,
  });
}
