import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/theme/app_styles.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tài khoản',
            style: AppTypography.bold16(),
          ),
          AppSizes.gapH16,
          _buildPreferenceItem(
            icon: Icons.edit,
            title: 'Thay đổi thông tin tài khoản',
            subtitle: '',
            onTap: () {
              // Navigate to privacy settings
            },
            color: context.theme.primaryColor,
          ),
          _buildPreferenceItem(
            icon: Icons.support_agent,
            title: 'Liên hệ và phản hồi',
            subtitle: '',
            onTap: () {
              // Navigate to help and support
            },
            color: context.theme.primaryColor,
          ),
          _buildPreferenceItem(
            icon: Icons.privacy_tip,
            title: 'Chính sách quyền riêng tư',
            subtitle: '',
            onTap: () {
              // Navigate to about page
            },
            color: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color),
            ),
            AppSizes.gapW16,
            Expanded(
              child: Text(
                title,
                style: AppTypography.medium13(),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
