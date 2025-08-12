import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/theme/theme_cubit.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:hangangramyeon/features/profile/cubit/profile_cubit.dart';
import '../../../core/theme/app_styles.dart';
import 'widgets/profile_avatar_section.dart';
import 'widgets/profile_selection_sheet.dart';
import 'widgets/profile_theme_selction_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    final themeCubit = context.read<ThemeCubit>();
    context.read<ProfileCubit>().initializeTheme(themeCubit);
  }

  void _confirmDeleteAccount() async {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;
    final userId = state.user.data.userId;
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá tài khoản'),
          content: const Text('Bạn có chắc chắn muốn xoá tài khoản? Hành động này không thể hoàn tác.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Huỷ'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFE53935)),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Xoá'),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      context.read<ProfileCubit>().deleteAccount(userId);
    }
  }

  void _showProfileBottomSheet() {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProfileSelectionSheet(
        selectedProfileImage: state.selectedProfileImage,
        onProfileSelected: (index) {
          context.read<ProfileCubit>().selectProfileImage(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showThemeBottomSheet() {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ThemeSelectionSheet(
        selectedThemeColor: state.selectedThemeColor,
        onThemeColorSelected: (themeColor) {
          context
              .read<ProfileCubit>()
              .changeThemeColor(themeColor, context.read<ThemeCubit>());
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              // Alerts.of(context).showSuccess('Profile updated successfully');
              context.pop();
            } else if (state is ProfileError) {
              // Alerts.of(context).showError(state.message);
            }
            if (state is ProfileDeleted) {
              // After delete success, logout to login screen
              context.read<AuthenticationCubit>().signOut();
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticationState) {
              context.goNamed(RouteNames.loginpage);
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileCubit>().infoAccount();
            return const AppCircularIndicator();
          }
          if (state is InfoAccountSuccess) {
            context.read<ProfileCubit>().getProfile(state.userId);
            return const AppCircularIndicator();
          }

          if (state is ProfileLoading) {
            return Container(
              color: Colors.white,
              child: const AppCircularIndicator(),
            );
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            return Scaffold(
              backgroundColor: Colors.white,
              //appBar: ProfileAppBar(onBackPressed: () => context.pop()),
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerSection(state),
                        AppSizes.gapH12,
                        _buildMenuList(),
                        // AppSizes.gapH12,
                        // AppearanceSection(
                        //   state: state,
                        //   onTap: _showThemeBottomSheet,
                        // ),
                        // AppSizes.gapH32,
                        // const AccountSection(),
                        // AppSizes.gapH32,
                        // ButtonsSection(
                        //   onSaveChanges: () {
                        //     // context.read<ProfileCubit>().updateProfile();
                        //   },
                        // ),
                        _buildVersionFooter(),
                        AppSizes.gapH16,
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const AppCircularIndicator();
        },
      ),
    );
  }

  Widget headerSection(ProfileLoaded state){
    return Container(
      height: 150,
      width: double.infinity,
      color: context.theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 32),
            height: 120,width: 120,
            child: ProfileSection(
              state: state,
              onTap: _showProfileBottomSheet,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        Const.userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: !Const.level.toString().toUpperCase().replaceAll('null', '').contains('KHÔNG'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            Const.level,
                            style: const TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Text(
                          '${Const.point} P',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Giao diện',
              style: AppTypography.bold16(),
            ),
          ),
          _SettingsTile(icon: Icons.palette,color: context.theme.primaryColor ,label: 'Chủ đề',  onTap: _showThemeBottomSheet,),
          AppSizes.gapH12,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Tài khoản',
              style: AppTypography.bold16(),
            ),
          ),
          _SettingsTile(
            icon: Icons.edit,
            label: 'Thay đổi thông tin tài khoản',
            onTap: () {},
          ),
          _SettingsTile(icon: Icons.settings, label: 'Cài đặt chung', onTap: () {
            context.pushNamed(RouteNames.settingspage);
          }),
          AppSizes.gapH12,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Liên hệ & Hỗ trợ',
              style: AppTypography.bold16(),
            ),
          ),
          _SettingsTile(icon: Icons.support_agent, label: 'Liên hệ và phản hồi', onTap: () {
            context.pushNamed(RouteNames.contactFeedback);
          }),
          // _SettingsTile(icon: Icons.help_outline, label: 'Câu hỏi thường gặp', onTap: () {}),
          // _SettingsTile(icon: Icons.description, label: 'Điều khoản và điều kiện', onTap: () {}),
          _SettingsTile(icon: Icons.privacy_tip, label: 'Chính sách quyền riêng tư', onTap: () {
            context.pushNamed(RouteNames.privacyPolicy);
          }),
          _SettingsTile(icon: Icons.logout, label: 'Đăng xuất', onTap: () {
            context.read<AuthenticationCubit>().signOut();
          }),
          const SizedBox(height: 4),
          Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              onTap: _confirmDeleteAccount,
              leading: Icon(Icons.no_accounts_rounded, color: Color(0xFFE53935),size: 20,),
              title: Text('Xóa tài khoản', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Color(0xFFE53935))),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildVersionFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: Text(
          'Phiên bản ứng dụng: 1.0.1',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ),
    );
  }
}

class _ViewCard extends StatelessWidget {
  const _ViewCard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text('Điểm tích luỹ',style: TextStyle(color: Colors.black,fontSize: 13),),
                    SizedBox(width: 5,),
                    Icon(Icons.navigate_next,color: Colors.black,)
                  ],
                ),
                Row(
                  children: [
                    Text(Const.point.toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
                    SizedBox(width: 5,),
                    Container(
                      height: 40,width: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13))),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    this.color,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
        height: 45,
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: color ?? Colors.black87,size: 20,),
          title: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          trailing: trailing ?? const Icon(Icons.chevron_right),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}