import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';


class BannerGrid extends StatelessWidget {
  final List<BannerItem> items;

  const BannerGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.all(12),
      shrinkWrap: true, //️ Quan trọng khi nằm trong Column
      physics: const NeverScrollableScrollPhysics(), //️ Không scroll riêng
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _BannerCard(item: item);
      },
    );
  }
}


class _BannerCard extends StatefulWidget {
  final BannerItem item;

  const _BannerCard({required this.item});

  @override
  State<_BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<_BannerCard> {

  double? _aspectRatio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resolveImage();
  }

  void _resolveImage() {
    final image = NetworkImage(widget.item.imageUrl);
    final stream = image.resolve(const ImageConfiguration());

    stream.addListener(
      ImageStreamListener((info, _) {
        final width = info.image.width.toDouble();
        final height = info.image.height.toDouble();
        if (mounted) {
          setState(() {
            _aspectRatio = width / height;
          });
        }
      }, onError: (error, stackTrace) {
        if (mounted) {
          setState(() {
            _aspectRatio = 1.5; // fallback
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _aspectRatio;
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (aspectRatio == null)
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            )
          else
            AspectRatio(
              aspectRatio: aspectRatio,
              child: CachedNetworkImage(
                imageUrl: widget.item.imageUrl.startsWith("http")
                    ? widget.item.imageUrl
                    : "http://hangangramyeon.vn${widget.item.imageUrl}",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.item.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
            child: HtmlWidget(
              widget.item.content,
              textStyle: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

