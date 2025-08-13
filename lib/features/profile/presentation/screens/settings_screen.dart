import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/services/bill_preview_service.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/widgets/bill_preview_widget.dart';
import 'package:hangangramyeon/features/profile/cubit/settings_cubit.dart';
import 'package:hangangramyeon/features/profile/data/models/shop_model.dart';
import 'package:hangangramyeon/features/profile/data/models/user_update_model.dart';
import 'account_info_screen.dart';
import 'change_password_screen.dart';

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
  Shop? _currentShop;

  @override
  void initState() {
    super.initState();
    _cacheService = getIt.get<CacheService>();
    _notificationsEnabled = _cacheService.getBool(CacheKeys.notificationsEnabled);
    _printerIpController.text = _cacheService.getString(CacheKeys.printerIp);
    _bankNameController.text = _cacheService.getString(CacheKeys.bankName);
    _bankAccountNameController.text = _cacheService.getString(CacheKeys.bankAccountName);
    _bankAccountNumberController.text = _cacheService.getString(CacheKeys.bankAccountNumber);
    
    // Load shops data
    context.read<SettingsCubit>().getShops();
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _cacheService.setBool(CacheKeys.notificationsEnabled, value);
  }

  void _updateBankInfo() {
    if (_currentShop != null) {
      final updatedShop = Shop(
        id: _currentShop!.id,
        code: _currentShop!.code,
        name: _bankAccountNameController.text,
        address: _currentShop!.address,
        phoneNumber: _currentShop!.phoneNumber,
        taxCode: _currentShop!.taxCode,
        bankName: _bankNameController.text,
        bankNumber: _bankAccountNumberController.text,
      );
      context.read<SettingsCubit>().updateShop(_currentShop!.id, updatedShop);
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is ShopsLoaded && state.shops.isNotEmpty) {
          _currentShop = state.shops.first;
          // Update text controllers with shop data
          _bankNameController.text = _currentShop!.bankName;
          _bankAccountNameController.text = _currentShop!.name;
          _bankAccountNumberController.text = _currentShop!.bankNumber;
        } else if (state is ShopUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thông tin ngân hàng thành công')),
          );
        } else if (state is UserUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thông tin tài khoản thành công')),
          );
        } else if (state is SettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Cài đặt chung')),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            return ListView(
              children: [
                _buildNotificationSection(),
                const Divider(height: 1),
                if (Const.isManager) _buildPrinterSection(),
                AppSizes.gapH24,
                _buildBankInfoSection(),
                AppSizes.gapH12,
                _buildOtherSettings(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.notifications, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Thông báo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        SwitchListTile(
          title: const Text('Bật thông báo'),
          subtitle: const Text('Nhận thông báo từ ứng dụng Hangang Ramyeon'),
          value: _notificationsEnabled,
          onChanged: _toggleNotifications,
        ),
      ],
    );
  }

  Widget _buildPrinterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.print, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Cài đặt in hoá đơn',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: _printerIpController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ IP máy in',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _cacheService.setString(CacheKeys.printerIp, v.trim()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBankInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.account_balance, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Thông tin tài khoản ngân hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: _bankNameController,
                decoration: const InputDecoration(
                  labelText: 'Ngân hàng',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _cacheService.setString(CacheKeys.bankName, v.trim()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _bankAccountNameController,
                decoration: const InputDecoration(
                  labelText: 'Tên chủ tài khoản',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _cacheService.setString(CacheKeys.bankAccountName, v.trim()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _bankAccountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Số tài khoản',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _cacheService.setString(CacheKeys.bankAccountNumber, v.trim()),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateBankInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Cập nhật thông tin ngân hàng'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtherSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.settings, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Khác',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.preview),
          title: const Text('Demo Preview Bill'),
          subtitle: const Text('Xem demo chức năng preview bill'),
          onTap: () => _showDemoBill(context),
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
    );
  }

  void _showDemoBill(BuildContext context) {
    final demoItems = [
      MenuItem(name: 'Cà phê đen', quantity: 2, unitPrice: 25000),
      MenuItem(name: 'Bánh tiramisu', quantity: 1, unitPrice: 35000),
      MenuItem(name: 'Trà sữa matcha', quantity: 3, unitPrice: 45000),
    ];

    final billData = generateBillPreview(
      items: demoItems,
      customerName: 'Nguyễn Văn A',
      totalAmountOverride: 200000,
      bankName: 'Vietcombank',
      bankAccountName: 'THE COFFEE HOUSE',
      bankAccountNumber: '1234567890',
    );

    showDialog(
      context: context,
      builder: (ctx) => BillPreviewWidget(
        billData: billData,
        onCancel: () => Navigator.pop(ctx),
        onPrint: () {
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Demo: In thành công!')),
          );
        },
      ),
    );
  }
}


