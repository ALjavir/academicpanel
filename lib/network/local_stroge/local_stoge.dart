import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStoge {
  final _secureStorage = const FlutterSecureStorage();
  Future writeDataLocal(String department, String roleID, String id) async {
    await _secureStorage.write(key: 'id', value: id);
    await _secureStorage.write(key: 'department', value: department);
    await _secureStorage.write(key: 'roleId', value: roleID);
  }

  Future deletDataLocal() async {
    await _secureStorage.delete(key: 'id');
    await _secureStorage.delete(key: 'department');
    await _secureStorage.delete(key: 'roleId');
  }

  Future<List<dynamic>> readDataLocal() async {
    return [
      _secureStorage.read(key: 'roleId'),
      _secureStorage.read(key: 'department'),
      _secureStorage.read(key: 'id'),
    ];
  }
}
