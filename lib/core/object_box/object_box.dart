import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rest_api_employee/model/object_box_entity_model.dart';
import 'package:rest_api_employee/objectbox.g.dart';

class EmployeeObjectBox {
  static EmployeeObjectBox? _instance;
  late final Store store;
  late final Box<ObjectboxEntityModel> employeeModelBox;

  EmployeeObjectBox._create(this.store) {
    employeeModelBox = store.box<ObjectboxEntityModel>();
  }

  static EmployeeObjectBox get instance {
    return _instance!;
  }

  static Future<void> create() async {
    if (_instance == null) {
      final docDir = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: join(docDir.path, 'employees'));
      _instance = EmployeeObjectBox._create(store);
    }
  }
}
