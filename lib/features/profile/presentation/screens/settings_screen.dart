import 'package:flutter/material.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  late final CacheService _cacheService;
  final _printerIpController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cacheService = getIt.get<CacheService>();
    _notificationsEnabled = _cacheService.getBool(CacheKeys.notificationsEnabled);
    _printerIpController.text = _cacheService.getString(CacheKeys.printerIp);
    _bankNameController.text = _cacheService.getString(CacheKeys.bankName);
    _bankAccountNameController.text = _cacheService.getString(CacheKeys.bankAccountName);
    _bankAccountNumberController.text = _cacheService.getString(CacheKeys.bankAccountNumber);
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _cacheService.setBool(CacheKeys.notificationsEnabled, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt chung')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Bật thông báo'),
            subtitle: const Text('Nhận thông báo từ ứng dụng Hangang Ramyeon'),
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          const Divider(height: 1),
          if (Const.isManager) ...[
            const ListTile(title: Text('Cài đặt in hoá đơn')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _printerIpController,
                    decoration: const InputDecoration(labelText: 'Địa chỉ IP máy in'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => _cacheService.setString(CacheKeys.printerIp, v.trim()),
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 24),
          const ListTile(title: Text('Thông tin tài khoản ngân hàng')),          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: _bankNameController,
                  decoration: const InputDecoration(labelText: 'Ngân hàng'),
                  onChanged: (v) => _cacheService.setString(CacheKeys.bankName, v.trim()),
                ),
                TextField(
                  controller: _bankAccountNameController,
                  decoration: const InputDecoration(labelText: 'Tên chủ tài khoản'),
                  onChanged: (v) => _cacheService.setString(CacheKeys.bankAccountName, v.trim()),
                ),
                TextField(
                  controller: _bankAccountNumberController,
                  decoration: const InputDecoration(labelText: 'Số tài khoản'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _cacheService.setString(CacheKeys.bankAccountNumber, v.trim()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.preview),
            title: const Text('Demo Preview Bill'),
            subtitle: const Text('Xem demo chức năng preview bill'),
            onTap: () => context.pushNamed(RouteNames.billPreviewDemo),
          ),
          const ListTile(
            title: Text('Ngôn ngữ'),
            subtitle: Text('Tiếng Việt (giả lập)'),
          ),
          const ListTile(
            title: Text('Phiên bản ứng dụng'),
            subtitle: Text('Hangang Ramyeon v1.0.1'),
          ),
        ],
      ),
    );
  }
}


