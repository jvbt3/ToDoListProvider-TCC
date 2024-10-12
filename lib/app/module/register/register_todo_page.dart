import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistprovider/app/model/todo_model.dart';
import 'package:todolistprovider/app/module/register/controller/register_todo_controller.dart';

const List<String> list = <String>['Baixa', 'Média', 'Alta'];

class RegisterTodoPage extends StatefulWidget {
  const RegisterTodoPage({super.key});

  @override
  State<RegisterTodoPage> createState() => _RegisterTodoPageState();
}

class _RegisterTodoPageState extends State<RegisterTodoPage> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;
  bool isLoading = false;

  TodoModel todoModel = TodoModel();

  late RegisterTodoController controller; // Defina o controller como "late"

  @override
  void initState() {
    super.initState();
    controller = Modular.get<
        RegisterTodoController>(); // Obtenha o controller via Modular
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Tarefa')),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o título da tarefa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira a descrição da tarefa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Prioridade',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            todoModel.titulo = tituloController.text;
                            todoModel.descricao = descricaoController.text;
                            todoModel.prioridade = dropdownValue;

                            try {
                              await controller.registerTodos(
                                  todoModel: todoModel);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Tarefa registrada com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Modular.to.popAndPushNamed('/home');
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Falha ao registrar a tarefa!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
