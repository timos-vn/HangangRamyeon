import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactFeedbackScreen extends StatelessWidget {
  const ContactFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liên hệ & phản hồi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hangang Ramyeon',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Chúng tôi luôn lắng nghe phản hồi của bạn để cải thiện trải nghiệm món mì Hàn Quốc Hangang Ramyeon.',
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Email'),
              subtitle: Text('support@hangangramyeon.vn (fake)'),
            ),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: const Text('Hotline'),
              subtitle: const Text('091 220 3337'),
              onTap: () async {
                final uri = Uri(scheme: 'tel', path: '0912203337');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Không thể mở ứng dụng gọi')),
                  );
                }
              },
            ),
            const ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Địa chỉ'),
              subtitle: Text('123 Hangang Street, Seoul (fake)'),
            ),
            const SizedBox(height: 16),
            const Text('Góp ý nhanh'),
            const SizedBox(height: 8),
            const _FakeFeedbackBox(),
          ],
        ),
      ),
    );
  }
}

class _FakeFeedbackBox extends StatefulWidget {
  const _FakeFeedbackBox();

  @override
  State<_FakeFeedbackBox> createState() => _FakeFeedbackBoxState();
}

class _FakeFeedbackBoxState extends State<_FakeFeedbackBox> {
  final TextEditingController _controller = TextEditingController();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return const ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text('Cảm ơn bạn! Phản hồi của bạn đã được ghi nhận (giả lập).'),
      );
    }
    return Column(
      children: [
        TextField(
          controller: _controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Nhập góp ý về Hangang Ramyeon...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: () {
              setState(() {
                _sent = true;
              });
            },
            child: const Text('Gửi'),
          ),
        )
      ],
    );
  }
}


