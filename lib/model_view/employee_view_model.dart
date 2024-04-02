import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rest_api_employee/model/object_box_entity_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_view_model.g.dart';

@riverpod
class Data extends _$Data {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  EmployeeObjectBoxRepository repository = EmployeeObjectBoxRepository();

  @override
  Future<List<ObjectboxEntityModel>> build(BuildContext context) {
    return repository.getDataFromBox();
  }

  Future<void> deleteData(ObjectboxEntityModel model) async {
    final currentState = state;
    if (currentState is AsyncData) {
      final newData =
          currentState.value?.where((item) => item.id != model.id).toList();

      try {
        if (newData!.isEmpty) {
          newData.addAll(await repository.addData());
        }
      } catch (e) {
        Future.sync(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.redAccent,
            ),
          ),
        );
      }

      state = AsyncValue.data(newData!);
    }
    await repository.deleteData(model);
  }

  Future<void> updateData(ObjectboxEntityModel model) async {
    final currentState = state;
    if (currentState is AsyncData) {
      final newData = currentState.value
          ?.map((item) => item.id == model.id ? model : item)
          .toList();
      state = AsyncValue.data(newData!);
    }
    await repository.updateData(model);
  }
}
