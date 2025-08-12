import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

/*
| Thành phần                         | Vai trò                                     |
| ---------------------------------- | ------------------------------------------- |
| `getIt`                            | Container để lưu & lấy các service          |
| `@injectableInit`                  | Đánh dấu hàm khởi tạo DI                    |
| `getIt.init()`                     | Hàm tự sinh, đăng ký toàn bộ dependency     |
| `dependency_injection.config.dart` | File được generate, chứa tất cả cấu hình DI |

=> run: flutter pub run build_runner build --delete-conflicting-outputs
* */

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();
