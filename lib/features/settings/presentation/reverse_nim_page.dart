import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseNimPage extends StatefulWidget {
  const ReverseNimPage({super.key});

  @override
  State<ReverseNimPage> createState() => _ReverseNimPageState();
}

class _ReverseNimPageState extends State<ReverseNimPage> {
  static const platform = MethodChannel('com.mita.diginews/native');

  String _batteryLevel = 'Klik untuk cek baterai';

  Future<void> _reverseNimNative() async {
    try {
      await platform.invokeMethod('reverseAndToast', {'nim': '20123051'});
    } catch (e) {
      debugPrint("Gagal memanggil native: $e");
    }
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Level Baterai: $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Gagal mengambil level baterai: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
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
              const Icon(Icons.android, size: 80, color: Colors.green),
              const SizedBox(height: 20),

              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _batteryLevel,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _getBatteryLevel,
                        child: const Text('Cek Status Baterai'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),

              const Text(
                'Reverse NIM',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _reverseNimNative,
                icon: const Icon(Icons.swap_horizontal_circle),
                label: const Text('Balikkan NIM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
