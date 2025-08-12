import 'package:dio/dio.dart';

// Lớp xử lý ngoại lệ khi dùng Dio
class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Yêu cầu tới máy chủ API đã bị hủy";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Hết thời gian kết nối với máy chủ API";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Hết thời gian chờ phản hồi từ máy chủ API";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Hết thời gian gửi dữ liệu tới máy chủ API";
        break;
      case DioExceptionType.connectionError:
        if (dioError.message?.contains("SocketException") ?? false) {
          message = "Không có kết nối Internet";
          break;
        } else if (dioError.message?.contains('HandshakeException') ?? false) {
          message = 'Không tìm thấy dữ liệu phản hồi';
          break;
        }
        message = "Đã xảy ra lỗi không mong muốn";
        break;
      default:
        message = "Đã xảy ra sự cố";
        break;
    }
  }

  // Hàm xử lý lỗi theo mã trạng thái HTTP
  String _handleError(int? statusCode, dynamic error) {
    final isString = error['message'] is String;
    switch (statusCode) {
      case 400:
        return isString
            ? error['message']
            : error['message'].first ?? 'Yêu cầu không hợp lệ';
      case 401:
        return isString
            ? error['message']
            : error['message'].first ?? 'Không được phép truy cập';
      case 403:
        return isString
            ? error['message']
            : error['message'].first ?? 'Bị cấm truy cập';
      case 404:
        return isString
            ? error['message']
            : error['message'].first ?? 'Không tìm thấy';
      case 409:
        return isString
            ? error['message']
            : error['message'].first ?? 'Xung đột';
      case 420:
        return 'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại';
      case 500:
        return error['message'] ?? 'Lỗi máy chủ nội bộ';
      case 502:
        return error['message'] ?? 'Máy chủ không khả dụng';
      case 503:
        return error['message'] ?? 'Máy chủ không khả dụng';
      default:
        return "Ôi, đã có lỗi xảy ra";
    }
  }

  @override
  String toString() => message;
}
