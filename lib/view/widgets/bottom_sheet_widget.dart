import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_employee/model/object_box_entity_model.dart';
import 'package:rest_api_employee/model_view/employee_view_model.dart';
import 'package:rest_api_employee/view/widgets/text_field_widget.dart';

class BottomsheetWidget extends ConsumerWidget {
  final int id;
  const BottomsheetWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController =
        ref.read(dataProvider(context).notifier).nameController;
    final salaryController =
        ref.read(dataProvider(context).notifier).salaryController;
    final ageController =
        ref.read(dataProvider(context).notifier).ageController;
    void cancelAction() {
      Navigator.pop(context);
    }

    return Material(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFieldWidget(controller: nameController),
              TextFieldWidget(controller: salaryController),
              TextFieldWidget(controller: ageController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: cancelAction,
                    child: Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: Colors.white),
                    onPressed: () async {
                      final updatedEmployee = ObjectboxEntityModel(
                        employeeName: nameController.text,
                        employeeSalary: int.parse(salaryController.text),
                        employeeAge: int.parse(ageController.text),
                        profileImage: '',
                        employeeId: id,
                      );
                      await ref
                          .read(dataProvider(context).notifier)
                          .updateData(updatedEmployee);
                    },
                    child: Text(
                      'Save',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
