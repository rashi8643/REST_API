import 'package:rest_api_employee/model/employee_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_view_model.g.dart';

class FetchDataViewModel {
  final FetchDataRepository repository;
  FetchDataViewModel({required this.repository});

  Future<List<DatasModel>> getDatas() async {
    return repository.getData();
  }
}

FetchDataRepository fetchDataRepository = FetchDataRepository();
@riverpod
Future<List<DatasModel>> fetchData(FetchDataRef ref) async {
  return await fetchDataRepository.getData();
}
