import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_bloc/task_model.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      final model = TaskModel(
        id: Uuid().v4(),
        title: event.title,
        isCompleted: false,
      );
      emit(
        TaskUpdated(List.from(state.tasksList)..add(model)),
        // TaskUpdated([...state.tasksList, model])
      );
    });
    on<RemoveTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.tasksList
          .where((task) => task.id != event.id)
          .toList();
      emit(TaskUpdated(newList));
    });

    on<ToggleTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.tasksList.map((task) {
        return task.id == event.id
            ? task.copyWith(isCompleted: !task.isCompleted)
            : task;
      }).toList();

      emit(TaskUpdated(newList));
    });
  }
}
