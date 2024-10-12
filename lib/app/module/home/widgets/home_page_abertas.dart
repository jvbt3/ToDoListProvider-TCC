import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:todolistprovider/app/module/home/controller/home_page_controller.dart';

class HomePageAbertas extends StatefulWidget {
  const HomePageAbertas({super.key});

  @override
  State<HomePageAbertas> createState() => _HomePageAbertasState();
}

class _HomePageAbertasState extends State<HomePageAbertas> {
  final bool _hasShownError = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<HomePageController>(context, listen: false).fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<HomePageController>(
            builder: (context, provider, child) {
              if (provider.errorMessage != null && !_hasShownError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        provider.errorMessage!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                });
              } else if (provider.errorMessage == null) {}
              if (provider.todoList.isNotEmpty) {
                return ListView.builder(
                  itemCount: provider.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = provider.todoList[index];
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Título: ${todo.titulo}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Descrição: ${todo.descricao}',
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Modular.to.pushNamed(
                                      'update',
                                      arguments: todo,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await provider.deleteTodo(id: todo.id!);
                                    // Atualizar a lista após a exclusão
                                    provider.fetchTodos();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Prioridade: ${todo.prioridade}'),
                            Text('Status: ${todo.status}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Nenhum item na lista.'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
