import 'package:flutter/material.dart';
import 'package:hangangramyeon/core/services/bill_preview_service.dart';
import 'package:hangangramyeon/core/widgets/bill_preview_widget.dart';

class BillPreviewDemo extends StatelessWidget {
  const BillPreviewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Preview Bill'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showDemoBill(context),
          child: const Text('Xem Demo Bill'),
        ),
      ),
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
