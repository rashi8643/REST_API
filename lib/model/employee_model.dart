// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

@freezed
class DatasModel with _$DatasModel {
  const factory DatasModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "employee_name") required String employeeName,
    @JsonKey(name: "employee_salary") required int employeeSalary,
    @JsonKey(name: "employee_age") required int employeeAge,
    @JsonKey(name: "profile_image") required String profileImage,
  }) = _DatasModel;

  factory DatasModel.fromJson(Map<String, dynamic> json) =>
      _$DatasModelFromJson(json);
}

const link = 'https://dummy.restapiexample.com/api/v1/employees';

class FetchDataRepository {
  Future<List<DatasModel>> getData() async {
    try {
      final dio = Dio();
      final response = await dio.get(link);
      if (response.statusCode == 200) {
        final data = response.data;

        final movies = <DatasModel>[];

        for (final result in data['data']) {
          movies.add(DatasModel.fromJson(result));
        }
        return movies;
      } else {
        throw Exception('No Data');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
