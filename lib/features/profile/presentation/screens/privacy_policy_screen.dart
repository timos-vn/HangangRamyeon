import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chính sách quyền riêng tư')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Chính sách quyền riêng tư - Hangang Ramyeon',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Ứng dụng Hangang Ramyeon cam kết bảo vệ thông tin cá nhân của người dùng. Nội dung này chỉ nhằm mục đích demo.',
          ),
          SizedBox(height: 12),
          Text('1. Dữ liệu thu thập: email, tên hiển thị, số điện thoại.'),
          SizedBox(height: 8),
          Text('2. Mục đích sử dụng: cải thiện dịch vụ, gửi thông báo khuyến mãi.'),
          SizedBox(height: 8),
          Text('3. Bảo mật: chúng tôi áp dụng các biện pháp bảo mật hợp lý.'),
          SizedBox(height: 8),
          Text('4. Quyền của người dùng: truy cập, chỉnh sửa, xoá tài khoản.'),
          SizedBox(height: 12),
          Text('Mọi nội dung trên đây chỉ là giả lập cho mục đích phát triển.'),
        ],
      ),
    );
  }
}


