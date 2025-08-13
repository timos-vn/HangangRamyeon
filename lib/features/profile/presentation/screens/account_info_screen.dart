import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/features/profile/cubit/settings_cubit.dart';
import 'package:hangangramyeon/features/profile/data/models/user_update_model.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  String _selectedGender = 'Nam';
  final _birthDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user info
    context.read<SettingsCubit>().getUserInfo(Const.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is UserInfoLoaded) {
          final userInfo = state.userInfo;
          _phoneController.text = userInfo.phoneNumber ?? '';
          _emailController.text = userInfo.email ?? '';
          _firstNameController.text = userInfo.firstName ?? '';
          _lastNameController.text = userInfo.lastName ?? '';
          _fullNameController.text = userInfo.fullName ?? '';
          _selectedGender = userInfo.gender ?? 'Nam';
          _birthDayController.text = userInfo.birthDay ?? '';
        } else if (state is UserUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thông tin tài khoản thành công')),
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
          title: const Text('Thông tin tài khoản'),

        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is UserInfoLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Thông tin cá nhân'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Số điện thoại',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _fullNameController,
                      label: 'Họ và tên',
                    ),
                    const SizedBox(height: 16),
                    _buildGenderDropdown(),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _birthDayController,
                      label: 'Ngày sinh (YYYY-MM-DD)',
                    ),
                    AppSizes.gapH64,
                    Visibility(
                      visible: state is UserInfoLoaded,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updateUserInfo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Cập nhật thông tin'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return const Center(child: Text('Không thể tải thông tin tài khoản'));
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Giới tính',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      items: ['Nam', 'Nữ'].map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  void _updateUserInfo() {
    final request = UserUpdateRequest(
      phoneNumber: _phoneController.text,
      email: _emailController.text,
      FirstName: _firstNameController.text,
      LastName: _lastNameController.text,
      FullName: _fullNameController.text,
      Gender: _selectedGender,
      BirthDay: _birthDayController.text,
      avatarUrl: '',
      deviceToken: '',
      shopId: Const.shopId,
    );
    context.read<SettingsCubit>().updateUser(Const.userId, request);
  }
}
