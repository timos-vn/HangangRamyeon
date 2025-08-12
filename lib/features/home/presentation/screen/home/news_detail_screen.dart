import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final BannerItem item;
  const NewsDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.imageUrl.startsWith('http')
        ? item.imageUrl
        : 'http://hangangramyeon.vn${item.imageUrl}';
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết bài viết')),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (c, _) => const SizedBox(height: 180),
            errorWidget: (c, _, __) => const Icon(Icons.broken_image),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                HtmlWidget(item.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


