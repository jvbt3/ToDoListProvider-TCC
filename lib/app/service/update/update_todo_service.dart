import 'package:dio/dio.dart';
import 'package:todolistprovider/app/model/todo_model.dart';

abstract class UpdateTodoService {
  Future<Response> updateTodo({
    required TodoModel todoModel,
  });
}
