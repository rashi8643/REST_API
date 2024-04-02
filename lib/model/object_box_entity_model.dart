import 'package:dio/dio.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rest_api_employee/core/object_box/object_box.dart';

@Entity()
class ObjectboxEntityModel {
  @Id()
  int id = 0;

  int? employeeId;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  ObjectboxEntityModel({
    this.id = 0,
    required this.employeeId,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });
  factory ObjectboxEntityModel.fromJson(Map<String, dynamic> json) {
    return ObjectboxEntityModel(
      employeeId: json['id'],
      employeeName: json['employee_name'],
      employeeSalary: json['employee_salary'],
      employeeAge: json['employee_age'],
      profileImage: json['profile_image'],
    );
  }
}

const link = 'https://dummy.restapiexample.com/api/v1/employees';

class EmployeeObjectBoxRepository {
  ///add data from object box
  Future<List<ObjectboxEntityModel>> addData() async {
    final box = EmployeeObjectBox.instance.employeeModelBox;
    try {
      final dio = Dio();
      final response = await dio.get(link);
      if (response.statusCode == 200) {
        final data = response.data;

        final details = <ObjectboxEntityModel>[];

        for (final result in data['data']) {
          final model = ObjectboxEntityModel.fromJson(result);
          details.add(model);
          box.put(model);
        }
        return details;
      } else {
        throw Exception('No Data');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  ///get data
  Future<List<ObjectboxEntityModel>> getDataFromBox() async {
    final box = EmployeeObjectBox.instance.employeeModelBox;
    final dataFromLocalStorage = box.getAll();

    if (dataFromLocalStorage.isEmpty) {
      return await addData();
    } else {
      return dataFromLocalStorage;
    }
  }

  ///remove data
  Future<void> deleteData(ObjectboxEntityModel model) async {
    final box = EmployeeObjectBox.instance.employeeModelBox;
    box.remove(model.id);
  }

  ///update data
  Future<void> updateData(ObjectboxEntityModel model) async {
    final box = EmployeeObjectBox.instance.employeeModelBox;
    box.put(model);
  }
}
