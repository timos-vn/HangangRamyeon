# Phần Cài Đặt Chung - Implementation (Updated)

## Tổng quan
Đã implement đầy đủ phần cài đặt chung theo yêu cầu mới với các chức năng sau:

## 1. Cấu trúc UI với Icon và Group
- ✅ Các chức năng được nhóm theo từng nội dung với tiêu đề phân biệt
- ✅ Mỗi nhóm có icon riêng biệt:
  - 🔔 **Thông báo**: Icon notifications
  - 🖨️ **Cài đặt in hoá đơn**: Icon print (chỉ hiển thị cho Manager)
  - 🏦 **Thông tin tài khoản ngân hàng**: Icon account_balance
  - 👤 **Tài khoản**: Icon person
  - ⚙️ **Khác**: Icon settings

## 2. Popup Nhập Liệu
- ✅ **IP máy in**: TextField với border đẹp, lưu vào cache
- ✅ **Thông tin ngân hàng**: 3 TextField (Ngân hàng, Tên chủ tài khoản, Số tài khoản) với nút cập nhật
- ✅ **Thay đổi thông tin tài khoản**: Dialog popup với form đầy đủ

## 3. API Integration

### Lấy dữ liệu Shop
- ✅ **API**: `GET https://hangangramyeon.vn/api/shops?pageNumber=1&pageSize=1000`
- ✅ **Gọi ở hàm main**: Đã implement trong `main.dart`
- ✅ **Model**: `ShopResponse`, `ShopData`, `Shop`
- ✅ **Service**: `SettingsService.getShops()`

### Cập nhật thông tin Shop
- ✅ **API**: `PUT https://hangangramyeon.vn/api/shops/{shopId}`
- ✅ **Request**: Shop object với đầy đủ thông tin
- ✅ **Response**: ShopResponse
- ✅ **Service**: `SettingsService.updateShop()`

### Cập nhật thông tin User
- ✅ **API**: `PUT /api/users/{userId}`
- ✅ **Request**: UserUpdateRequest với đầy đủ field
- ✅ **Response**: UserUpdateResponse
- ✅ **Service**: `SettingsService.updateUser()`

### Lấy thông tin User
- ✅ **API**: `GET /api/users/{userId}`
- ✅ **Response**: UserInfoResponse với UserInfoData
- ✅ **Service**: `SettingsService.getUserInfo()`

### Thay đổi mật khẩu
- ✅ **API**: `POST /api/auth/change-password`
- ✅ **Request**: ChangePasswordRequest
- ✅ **Response**: ChangePasswordResponse
- ✅ **Service**: `SettingsService.changePassword()`

### Reset mật khẩu
- ✅ **API**: `POST /api/auth/reset-password`
- ✅ **Request**: ResetPasswordRequest
- ✅ **Response**: ResetPasswordResponse
- ✅ **Service**: `SettingsService.resetPassword()`

## 4. State Management
- ✅ **Cubit**: `SettingsCubit` với các state:
  - `SettingsInitial`
  - `SettingsLoading`
  - `ShopsLoaded`
  - `ShopUpdated`
  - `UserUpdated`
  - `UserInfoLoaded`
  - `PasswordChanged`
  - `PasswordReset`
  - `SettingsError`

## 5. Features Implemented

### Thông báo
- ✅ Switch toggle để bật/tắt thông báo
- ✅ Lưu trạng thái vào cache

### Cài đặt in hoá đơn (Manager only)
- ✅ TextField nhập IP máy in
- ✅ Lưu vào cache

### Thông tin tài khoản ngân hàng
- ✅ Load dữ liệu từ API khi khởi động app
- ✅ Hiển thị thông tin hiện tại
- ✅ Form cập nhật với validation
- ✅ Nút cập nhật gọi API

### Thay đổi thông tin tài khoản
- ✅ **Màn hình riêng biệt**: AccountInfoScreen
- ✅ **Load dữ liệu từ API**: GET /api/users/{userId}
- ✅ **Form đầy đủ**: Số điện thoại, Email, Họ, Tên, Họ và tên, Giới tính, Ngày sinh
- ✅ **Cập nhật real-time**: Gọi API PUT /api/users/{userId}
- ✅ **Validation**: Kiểm tra dữ liệu trước khi gửi

### Thay đổi mật khẩu
- ✅ **Màn hình riêng biệt**: ChangePasswordScreen
- ✅ **Form validation**: Mật khẩu hiện tại, mật khẩu mới, xác nhận mật khẩu
- ✅ **API**: POST /api/auth/change-password
- ✅ **Security**: Ẩn/hiện mật khẩu, validation độ mạnh

### Quên mật khẩu (Màn đăng nhập)
- ✅ **Màn hình riêng biệt**: ForgotPasswordScreen
- ✅ **Xác thực OTP**: 4 số, validation đầy đủ
- ✅ **Flow hoàn chỉnh**: Nhập số điện thoại → Gửi OTP → Xác thực → Đặt mật khẩu mới
- ✅ **API**: POST /api/auth/reset-password

### Khác
- ✅ Demo Preview Bill
- ✅ Ngôn ngữ (giả lập)
- ✅ Phiên bản ứng dụng

## 6. Files Created/Modified

### New Files
- `lib/features/profile/data/models/shop_model.dart`
- `lib/features/profile/data/models/user_update_model.dart`
- `lib/features/auth/data/models/change_password_model.dart`
- `lib/features/auth/data/models/reset_password_model.dart`
- `lib/features/auth/data/models/user_info_model.dart`
- `lib/features/profile/data/services/settings_service.dart`
- `lib/features/profile/cubit/settings_cubit.dart`
- `lib/features/profile/cubit/settings_state.dart`
- `lib/features/profile/presentation/screens/account_info_screen.dart`
- `lib/features/profile/presentation/screens/change_password_screen.dart`
- `lib/features/auth/presentation/screens/forgot_password_screen.dart`

### Modified Files
- `lib/core/network/api_service.dart` - Thêm API endpoints mới
- `lib/features/profile/presentation/screens/settings_screen.dart` - UI mới với chức năng thay đổi mật khẩu
- `lib/features/profile/presentation/profile_screen.dart` - Link đến settings
- `lib/features/auth/presentation/screens/sign_in/widgets/sign_in_form.dart` - Thêm link quên mật khẩu
- `lib/core/router/app_router.dart` - Thêm routes mới
- `lib/main.dart` - Thêm SettingsCubit và gọi API shops

## 7. Dependencies
- ✅ `json_annotation` - Model serialization
- ✅ `retrofit` - API client
- ✅ `flutter_bloc` - State management
- ✅ `injectable` - Dependency injection

## 8. Error Handling
- ✅ Loading states
- ✅ Error messages với SnackBar
- ✅ Success messages
- ✅ Try-catch blocks

## 9. Cache Management
- ✅ Lưu trữ cài đặt local
- ✅ Load dữ liệu từ cache khi khởi động
- ✅ Sync với API khi cần

## 10. UI/UX Improvements
- ✅ Icons cho từng section
- ✅ Grouping rõ ràng
- ✅ Form validation
- ✅ Loading indicators
- ✅ Success/Error feedback
- ✅ Responsive design
- ✅ Material Design guidelines
- ✅ Navigation flow mượt mà
- ✅ Form validation real-time
- ✅ Password visibility toggle
- ✅ OTP input với maxLength
- ✅ Step-by-step flow cho quên mật khẩu
