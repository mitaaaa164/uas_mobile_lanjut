import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showLottie = false;

  void _triggerEasterEgg() {
    if (!_showLottie) {
      setState(() {
        _showLottie = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showLottie = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Mahasiswa')),
      body: Stack(
        children: [
          // Tampilan Halaman Profile Utama
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _triggerEasterEgg,
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.blueAccent,

                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Mita Anggraeni',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'NIM: 20123051',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                const Text('Ketuk foto profil untuk melihat rahasia!'),
              ],
            ),
          ),

          if (_showLottie)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Lottie.network(
                    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Oops.. Animasi gagal dimuat!\n(Internet harus menyala untuk fitur rahasia ini)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
