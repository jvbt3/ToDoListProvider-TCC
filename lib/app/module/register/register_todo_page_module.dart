import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/module/register/controller/register_todo_controller.dart';
import 'package:todolistprovider/app/module/register/register_todo_page.dart';
import 'package:todolistprovider/app/service/register/register_todo_service.dart';
import 'package:todolistprovider/app/service/register/register_todo_service_impl.dart';

class RegisterTodoPageModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<RegisterTodoController>(RegisterTodoController.new);
    i.addLazySingleton<RegisterTodoService>(RegisterTodoServiceImpl.new);
  }

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => const RegisterTodoPage(),
      ),
    ];
  }
}
