import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreFinderScreen extends StatefulWidget {
  const StoreFinderScreen({super.key});

  @override
  State<StoreFinderScreen> createState() => _StoreFinderScreenState();
}

class _StoreFinderScreenState extends State<StoreFinderScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final PageController _pageController = PageController(viewportFraction: 0.8);

  final List<_Store> _stores = const [
    // Hà Nội (2)
    _Store('Hangang Ramyeon Hà Nội - Hoàn Kiếm', LatLng(21.028511, 105.804817), '36 Hàng Bài, Hoàn Kiếm, Hà Nội'),
    _Store('Hangang Ramyeon Hà Nội - Cầu Giấy', LatLng(21.035, 105.790), '123 Trần Duy Hưng, Cầu Giấy, Hà Nội'),
    // Nghệ An (1)
    _Store('Hangang Ramyeon Nghệ An - Vinh', LatLng(18.679585, 105.681335), '22 Lê Lợi, TP Vinh, Nghệ An'),
  ];

  int _currentIndex = 0;

  Future<void> _animateTo(int index) async {
    setState(() => _currentIndex = index);
    final controller = await _controller.future;
    final target = _stores[index].position;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial = _stores.first.position;
    final markers = _stores
        .asMap()
        .entries
        .map((e) => Marker(
              markerId: MarkerId('store_${e.key}'),
              position: e.value.position,
              infoWindow: InfoWindow(title: e.value.name, snippet: e.value.address),
              onTap: () => _animateTo(e.key),
            ))
        .toSet();

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm cửa hàng')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: initial, zoom: 12),
            markers: markers,
            onMapCreated: (c) => _controller.complete(c),
            myLocationButtonEnabled: false,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _stores.length,
                onPageChanged: _animateTo,
                itemBuilder: (context, index) {
                  final s = _stores[index];
                  final selected = index == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(selected ? 0.2 : 0.1),
                          blurRadius: selected ? 12 : 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(s.address),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () => _animateTo(index),
                            child: const Text('Xem trên bản đồ'),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Store {
  final String name;
  final LatLng position;
  final String address;
  const _Store(this.name, this.position, this.address);
}


