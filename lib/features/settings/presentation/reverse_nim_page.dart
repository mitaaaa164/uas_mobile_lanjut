import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseNimPage extends StatelessWidget {
  const ReverseNimPage({super.key});

  static const platform = MethodChannel('com.mita.diginews/native');

  Future<void> _reverseNimNative() async {
    try {
      await platform.invokeMethod('reverseAndToast', {'nim': '20123051'});
    } catch (e) {
      debugPrint("Gagal memanggil native: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Feature')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.android, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Fitur Native Android (Kotlin)',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'tekan tombol di bawah akan muncul toast reverse NIM.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _reverseNimNative,
                icon: const Icon(Icons.swap_horizontal_circle),
                label: const Text('Balikkan NIM Sekarang'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
