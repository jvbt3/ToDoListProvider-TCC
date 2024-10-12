import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/module/home/home_page_module.dart';
import 'package:todolistprovider/app/module/initial_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => const InitialPage(),
      ),
      r.module(
        '/home',
        module: HomePageModule(),
      ),
    ];
  }
}
