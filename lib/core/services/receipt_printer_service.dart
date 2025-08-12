import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class MenuItem {
  final String name;
  final int quantity;
  final int unitPrice;

  MenuItem({required this.name, required this.quantity, required this.unitPrice});
  int get total => quantity * unitPrice;
}

Future<img.Image?> _loadLogo() async {
  final data = await rootBundle.load('assets/images/logo.png');
  final bytes = data.buffer.asUint8List();
  return img.decodeImage(bytes);
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

Future<String> printReceipt({
  required String ip,
  int port = 9100,
  required List<MenuItem> items,
}) async {
  final profile = await CapabilityProfile.load();
  final printer = NetworkPrinter(PaperSize.mm80, profile);

  final res = await printer.connect(ip, port: port);
  if (res != PosPrintResult.success) return '❌ Kết nối thất bại: $res';

  // final logo = await _loadLogo();
  final now = DateTime.now();
  final df = DateFormat('dd-MM-yyyy HH:mm');
  final fCur = NumberFormat('#,###', 'vi_VN');
  final totalAmount = items.fold(0, (s, e) => s + e.total);

  // if (logo != null) {
  //   printer.image(logo, align: PosAlign.center);
  //   printer.feed(1);
  // }

  printer.text('THE COFFEE HOUSE',
      styles: const PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size2));
  printer.text(removeVietnamese('195/10 Điện Biên Phủ, Q. Bình Thạnh'), styles: const PosStyles(align: PosAlign.center));
  printer.feed(1);
  printer.text(removeVietnamese('Số hóa đơn: 101'));
  printer.text(removeVietnamese('Thời gian: ${df.format(now)}'));
  printer.text(removeVietnamese('Thu ngân: DELI     Bill: TA123...'));
  printer.text(removeVietnamese('Khách hàng: Chị A'));
  printer.text(removeVietnamese('Ghi chú: Đặt qua GRAB'));
  printer.hr();

  printer.row([
    PosColumn(text: 'TT', width: 1, styles: const PosStyles(bold: true)),
    PosColumn(text: 'Ten mon', width: 5, styles: const PosStyles(bold: true)),
    PosColumn(text: 'SL', width: 1, styles: const PosStyles(bold: true)),
    PosColumn(text: 'D.Gia', width: 2, styles: const PosStyles(bold: true)),
    PosColumn(text: 'T.Tien', width: 3, styles: const PosStyles(bold: true)),
  ]);

  int idx = 1;
  int totalQty = 0;
  for (var e in items) {
    printer.row([
      PosColumn(text: '$idx', width: 1),
      PosColumn(text: e.name, width: 5),
      PosColumn(text: '${e.quantity}', width: 1),
      PosColumn(text: fCur.format(e.unitPrice), width: 2),
      PosColumn(text: fCur.format(e.total), width: 3),
    ]);
    idx++;
    totalQty += e.quantity;
  }

  printer.hr();
  printer.row([
    PosColumn(text: 'Tong SL:', width: 8),
    PosColumn(text: '$totalQty', width: 4, styles: const PosStyles(align: PosAlign.right)),
  ]);
  printer.row([
    PosColumn(text: 'Tong tien:', width: 8),
    PosColumn(
      text: fCur.format(totalAmount),
      width: 4,
      styles: const PosStyles(align: PosAlign.right, bold: true),
    ),
  ]);
  printer.feed(1);
  printer.text('Thanh toan: ${fCur.format(totalAmount)}',
      styles: const PosStyles(align: PosAlign.right, bold: true));
  printer.feed(1);
  printer.qrcode('https://evat.thecoffeehouse.com');
  printer.text('WiFi: thecoffeehouse', styles: const PosStyles(align: PosAlign.center));
  printer.feed(2);
  printer.cut();
  printer.disconnect();

  return '✅ In thành công!';
}
