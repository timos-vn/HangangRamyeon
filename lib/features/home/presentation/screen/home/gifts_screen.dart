import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GiftsScreen extends StatelessWidget {
  const GiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quà của bạn')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Lottie.network(
                  // Stable public animation (gift box)
                  'https://lottie.host/2ca6ea1d-8802-4e1e-afd5-0ddabf4b72c6/vnWfnoFC1f.json',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => const Icon(Icons.card_giftcard, size: 100, color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bạn chưa có quà tặng nào',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('Hãy tiếp tục tích điểm để nhận quà hấp dẫn từ Hangang Ramyeon!',textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}


