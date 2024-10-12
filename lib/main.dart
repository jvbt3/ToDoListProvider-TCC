import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/app_module.dart';
import 'package:todolistprovider/app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
