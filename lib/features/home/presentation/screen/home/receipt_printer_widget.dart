import 'package:flutter/material.dart';
import 'package:hangangramyeon/core/services/receipt_printer_service.dart';

class ReceiptPrinterWidget extends StatefulWidget {
  const ReceiptPrinterWidget({super.key});

  @override
  State<ReceiptPrinterWidget> createState() => _ReceiptPrinterWidgetState();
}

class _ReceiptPrinterWidgetState extends State<ReceiptPrinterWidget> {
  final TextEditingController ipController = TextEditingController(text: '192.168.0.33');

  final List<MenuItem> demoItems = [
    MenuItem(name: 'Ca phe sua da', quantity: 2, unitPrice: 29000),
    MenuItem(name: 'Tra dao cam sa', quantity: 1, unitPrice: 35000),
    MenuItem(name: 'Banh mi ga nuong', quantity: 1, unitPrice: 42000),
  ];

  bool isPrinting = false;

  void _handlePrint() async {
    setState(() => isPrinting = true);
    final result = await printReceipt(ip: ipController.text.trim(), items: demoItems);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      setState(() => isPrinting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In Hóa Đơn')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ipController,
              decoration: const InputDecoration(labelText: 'Địa chỉ IP máy in'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: isPrinting ? null : _handlePrint,
              icon: const Icon(Icons.print),
              label: Text(isPrinting ? 'Đang in...' : 'In hóa đơn'),
            ),
          ],
        ),
      ),
    );
  }
}
