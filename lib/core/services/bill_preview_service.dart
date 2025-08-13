import 'package:intl/intl.dart';

class MenuItem {
  final String name;
  final int quantity;
  final int unitPrice;

  MenuItem({required this.name, required this.quantity, required this.unitPrice});
  int get total => quantity * unitPrice;
}

String removeVietnamese(String str) {
  const accents = {
    'a': 'àáảãạăằắẳẵặâầấẩẫậ',
    'A': 'ÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬ',
    'e': 'èéẻẽẹêềếểễệ',
    'E': 'ÈÉẺẼẸÊỀẾỂỄỆ',
    'i': 'ìíỉĩị',
    'I': 'ÌÍỈĨỊ',
    'o': 'òóỏõọôồốổỗộơờớởỡợ',
    'O': 'ÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢ',
    'u': 'ùúủũụưừứửữự',
    'U': 'ÙÚỦŨỤƯỪỨỬỮỰ',
    'y': 'ỳýỷỹỵ',
    'Y': 'ỲÝỶỸỴ',
    'd': 'đ',
    'D': 'Đ',
  };
  for (final entry in accents.entries) {
    for (int i = 0; i < entry.value.length; i++) {
      str = str.replaceAll(entry.value[i], entry.key);
    }
  }
  return str;
}

class BillPreviewData {
  final String header;
  final String address;
  final String billNumber;
  final String dateTime;
  final String cashier;
  final String customerName;
  final String note;
  final List<BillItem> items;
  final int totalQuantity;
  final int totalAmount;
  final String paymentMethod;
  final String qrCode;
  final String wifi;

  BillPreviewData({
    required this.header,
    required this.address,
    required this.billNumber,
    required this.dateTime,
    required this.cashier,
    required this.customerName,
    required this.note,
    required this.items,
    required this.totalQuantity,
    required this.totalAmount,
    required this.paymentMethod,
    required this.qrCode,
    required this.wifi,
  });
}

class BillItem {
  final int index;
  final String name;
  final int quantity;
  final int unitPrice;
  final int total;

  BillItem({
    required this.index,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });
}

BillPreviewData generateBillPreview({
  required List<MenuItem> items,
  String? customerName,
  int? totalAmountOverride,
  String? bankName,
  String? bankAccountName,
  String? bankAccountNumber,
}) {
  final now = DateTime.now();
  final df = DateFormat('dd-MM-yyyy HH:mm');
  final fCur = NumberFormat('#,###');
  final totalAmount = (totalAmountOverride != null)
      ? totalAmountOverride
      : items.fold<int>(0, (s, e) => s + e.total);

  final billItems = items.asMap().entries.map((entry) {
    final index = entry.key + 1;
    final item = entry.value;
    return BillItem(
      index: index,
      name: item.name,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      total: item.total,
    );
  }).toList();

  final totalQty = items.fold<int>(0, (sum, item) => sum + item.quantity);

  // Generate QR code text
  String qrCode;
  if ((bankAccountNumber ?? '').isNotEmpty) {
    final safeBank = (bankName ?? '').replaceAll('+', '%2B');
    final safeAcc = (bankAccountNumber ?? '');
    final safeName = (bankAccountName ?? '').replaceAll('+', '%2B');
    qrCode = 'BANK:$safeBank|ACC:$safeAcc|NAME:$safeName|AMT:$totalAmount';
  } else {
    qrCode = 'https://hangangramyeon.vn';
  }

  return BillPreviewData(
    header: 'HANGANG RAMYEON',
    address: '262 Nguyễn Huy Tưởng, Thanh Xuân, HN',
    billNumber: '101',
    dateTime: df.format(now),
    cashier: 'DELI',
    customerName: customerName ?? '',
    note: 'Đặt qua Úng dụng',
    items: billItems,
    totalQuantity: totalQty,
    totalAmount: totalAmount,
    paymentMethod: fCur.format(totalAmount),
    qrCode: qrCode,
    wifi: 'hangangramyeon',
  );
}
