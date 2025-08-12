import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:hangangramyeon/core/services/bill_preview_service.dart';

class BillPreviewWidget extends StatelessWidget {
  final BillPreviewData billData;
  final VoidCallback? onPrint;
  final VoidCallback? onCancel;

  const BillPreviewWidget({
    super.key,
    required this.billData,
    this.onPrint,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Text(
                    'Xem trước hóa đơn',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close),
                    tooltip: 'Đóng',
                  ),
                ],
              ),
            ),
            
            // Bill Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Header
                    Text(
                      billData.header,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      billData.address,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    
                    // Bill Info
                    _buildInfoRow('Số hóa đơn:', billData.billNumber),
                    _buildInfoRow('Thời gian:', billData.dateTime),
                    _buildInfoRow('Thu ngân:', billData.cashier),
                    if (billData.customerName.isNotEmpty)
                      _buildInfoRow('Khách hàng:', billData.customerName),
                    _buildInfoRow('Ghi chú:', billData.note),
                    
                    const Divider(),
                    
                    // Items Header
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('TT', style: _headerStyle)),
                        Expanded(flex: 5, child: Text('Tên món', style: _headerStyle)),
                        Expanded(flex: 1, child: Text('SL', style: _headerStyle)),
                        Expanded(flex: 2, child: Text('Đ.Giá', style: _headerStyle)),
                        Expanded(flex: 3, child: Text('T.Tiền', style: _headerStyle)),
                      ],
                    ),
                    const Divider(),
                    
                    // Items
                    ...billData.items.map((item) => _buildItemRow(item)),
                    
                    const Divider(),
                    
                    // Totals
                    _buildTotalRow('Tổng SL:', '${billData.totalQuantity}'),
                    _buildTotalRow('Tổng tiền:', NumberFormat('#,###').format(billData.totalAmount), isBold: true),
                    
                    const SizedBox(height: 8),
                    
                    // Payment
                    Text(
                      'Thanh toán: ${billData.paymentMethod}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // QR Code
                    Center(
                      child: QrImageView(
                        data: billData.qrCode,
                        version: QrVersions.auto,
                        size: 120,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // WiFi
                    Text(
                      'WiFi: ${billData.wifi}',
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      child: const Text('Hủy'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onPrint,
                      icon: const Icon(Icons.print),
                      label: const Text('In'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(BillItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('${item.index}', style: _itemStyle)),
          Expanded(flex: 5, child: Text(item.name, style: _itemStyle)),
          Expanded(flex: 1, child: Text('${item.quantity}', style: _itemStyle)),
          Expanded(flex: 2, child: Text(NumberFormat('#,###').format(item.unitPrice), style: _itemStyle)),
          Expanded(flex: 3, child: Text(NumberFormat('#,###').format(item.total), style: _itemStyle)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _headerStyle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  TextStyle get _itemStyle => const TextStyle(fontSize: 11);
}
