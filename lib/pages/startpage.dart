import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/bottomnavbar.dart';
import 'package:musicallim_test/widgets/app_colors.dart'; // Import reusable color widget

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Latar belakang gelap
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Posisikan di bawah
          crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
          children: [
            const Text(
              'Discover the best music\nfor your mood!',
              style: TextStyle(
                fontSize: 28,
                color: AppColors.textPrimary, // Warna teks putih
                fontWeight: FontWeight.bold, // Teks tebal ala aplikasi musik
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Stream unlimited music, curated just for you.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.accent // Warna teks sekunder
              ),
            ),
            const SizedBox(height: 40), // Spasi antara teks dan tombol
            ElevatedButton(
              onPressed: () {
                Get.off(() => BottomNavController()); // Navigasi ke halaman berikutnya
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // Warna tombol pink
                padding: const EdgeInsets.symmetric(vertical: 18), // Tombol lebih tinggi
                minimumSize: const Size.fromHeight(50), // Lebar tombol penuh
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Tombol oval
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // Teks tebal pada tombol
                  color: AppColors.textPrimary, // Warna teks putih
                ),
              ),
            ),
            const SizedBox(height: 40), // Tambahkan spasi di bawah tombol
          ],
        ),
      ),
    );
  }
}
