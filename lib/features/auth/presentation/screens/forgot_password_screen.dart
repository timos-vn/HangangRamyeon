import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/features/profile/cubit/settings_cubit.dart';
import 'package:hangangramyeon/features/auth/data/models/reset_password_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isOtpSent = false;
  bool _isOtpVerified = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is PasswordReset) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đặt lại mật khẩu thành công')),
          );
          Navigator.of(context).pop();
        } else if (state is SettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quên mật khẩu'),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is SettingsLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Nhập số điện thoại để nhận mã OTP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      enabled: !_isOtpSent,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (!_isOtpSent)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _sendOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Gửi mã OTP'),
                        ),
                      ),
                    if (_isOtpSent) ...[
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        enabled: !_isOtpVerified,
                        decoration: const InputDecoration(
                          labelText: 'Mã OTP (4 số)',
                          border: OutlineInputBorder(),
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mã OTP';
                          }
                          if (value.length != 4) {
                            return 'Mã OTP phải có 4 số';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      if (!_isOtpVerified)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _verifyOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Xác thực OTP'),
                          ),
                        ),
                    ],
                    if (_isOtpVerified) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Nhập mật khẩu mới',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField(
                        controller: _newPasswordController,
                        label: 'Mật khẩu mới',
                        obscureText: _obscureNewPassword,
                        onToggleObscure: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu mới';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: 'Xác nhận mật khẩu mới',
                        obscureText: _obscureConfirmPassword,
                        onToggleObscure: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng xác nhận mật khẩu mới';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Mật khẩu xác nhận không khớp';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _resetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Đặt lại mật khẩu'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggleObscure,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  void _sendOtp() {
    if (_phoneController.text.isNotEmpty) {
      setState(() {
        _isOtpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mã OTP đã được gửi đến số điện thoại của bạn')),
      );
    }
  }

  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      setState(() {
        _isOtpVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xác thực OTP thành công')),
      );
    }
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      final request = ResetPasswordRequest(
        UserId: Const.userId,
        NewPassword: _newPasswordController.text,
      );
      context.read<SettingsCubit>().resetPassword(request);
    }
  }
}
