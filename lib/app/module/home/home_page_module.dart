import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/module/home/controller/home_page_controller.dart';
import 'package:todolistprovider/app/module/home/home_page.dart';
import 'package:todolistprovider/app/module/register/register_todo_page_module.dart';
import 'package:todolistprovider/app/module/update/update_todo_module.dart';
import 'package:todolistprovider/app/service/home/home_page_service.dart';
import 'package:todolistprovider/app/service/home/home_page_service_impl.dart';
import 'package:provider/provider.dart';

class HomePageModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomePageService>(HomePageServiceImpl.new);
  }

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) {
          final controller = HomePageController(Modular.get<HomePageService>());
          return ChangeNotifierProvider<HomePageController>(
            create: (_) => controller,
            child: HomePage(controller: controller),
          );
        },
      ),
      r.module(
        '/register',
        module: RegisterTodoPageModule(),
      ),
      r.module(
        '/update',
        module: UpdateTodoModule(),
      ),
    ];
  }
}
