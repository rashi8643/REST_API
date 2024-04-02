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
  Future<List<ObjectboxEntityModel>> getData() async {
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
          await box.put(model);
        }
        return details;
      } else {
        throw Exception('No Data');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
