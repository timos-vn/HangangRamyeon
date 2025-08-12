import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/*service dùng để lưu trữ dữ liệu an toàn trên thiết bị bằng cách sử dụng package flutter_secure_storage.
Nó được cấu hình để dùng với Dependency Injection (injectable) bằng annotation @lazySingleton.

flutter_secure_storage: thư viện dùng để lưu dữ liệu một cách an toàn và được mã hóa (thường dùng lưu token, mật khẩu, ...).

injectable: hỗ trợ Dependency Injection trong Flutter bằng cách tự động khởi tạo các class được đánh dấu.

*/


@lazySingleton
class SecureStorageService {
  const SecureStorageService();
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
