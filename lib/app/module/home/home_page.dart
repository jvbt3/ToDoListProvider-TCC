import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/module/home/controller/home_page_controller.dart';
import 'package:todolistprovider/app/module/home/widgets/home_page_abertas.dart';
import 'package:todolistprovider/app/module/home/widgets/home_page_execucao.dart';
import 'package:todolistprovider/app/module/home/widgets/home_page_fechadas.dart';

class HomePage extends StatefulWidget {
  final HomePageController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Exibir mensagens de erro
    if (widget.controller.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              widget.controller.errorMessage!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      });
    }

    // Estrutura principal da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do-List'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Abertas'),
            Tab(text: 'Em Execução'),
            Tab(text: 'Fechadas'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('register');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomePageAbertas(),
          HomePageExecucao(),
          HomePageFechadas(),
        ],
      ),
    );
  }
}
