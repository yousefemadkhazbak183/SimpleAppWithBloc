import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_bloc/controller/cubit/task_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: BlocProvider(
        create: (BuildContext context) => TaskCubit(),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (BuildContext context, state) {
            final controllerCubit = context.read<TaskCubit>();
            return Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "Enter a Task"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    controllerCubit.addTask(controller.text);
                    controller.clear();
                  },
                  child: Text("Add"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(state.tasksList[index].title),
                        leading: Checkbox(
                          value: state.tasksList[index].isCompleted,
                          onChanged: (value) {
                            controllerCubit.toggleTask(
                              state.tasksList[index].id,
                            );
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controllerCubit.removeTask(
                              state.tasksList[index].id,
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
