import 'package:rest_api_employee/model/object_box_entity_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_view_model.g.dart';

EmployeeObjectBoxRepository repository = EmployeeObjectBoxRepository();
@riverpod
Future<List<ObjectboxEntityModel>> fetchData(FetchDataRef ref) async {
  return await repository.getData();
}
