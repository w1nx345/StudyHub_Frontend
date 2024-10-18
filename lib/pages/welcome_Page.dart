import 'package:flutter/material.dart';
import 'login_page.dart'; // Pastikan untuk mengimpor halaman login

class Welcome1 extends StatefulWidget {
  @override
  _Welcome1State createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome1> {
  final _pageController = PageController();
  int _currentPage = 0; // Untuk tracking page aktif

  @override
  void initState() {
    super.initState();

    // Mulai proses perpindahan halaman otomatis setiap 4 detik
    _startPageAutoTransition();
  }

  void _startPageAutoTransition() {
    Future.delayed(Duration(seconds: 4), () {
      int nextPage = (_currentPage + 1) % 3; // Menghitung halaman berikutnya, balik ke 0 setelah halaman terakhir

      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = nextPage; // Update halaman
      });

      // Melanjutkan proses perpindahan halaman setelah 4 detik lagi
      _startPageAutoTransition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            // Menggunakan Expanded untuk meletakkan logo di tengah layar
            Expanded(
              flex: 3, // Memberikan proporsi ruang yang lebih besar untuk logo
              child: Center(
                child: Image.asset(
                  'lib/images/Study Hub Logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),

            // PageView yang hanya berisi konten di dalam box putih
            Expanded(
              flex: 2, // Memberikan ruang untuk PageView
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index; // Update halaman saat user geser manual
                  });
                },
                children: [
                  // Konten Welcome1
                  _buildContentBox(
                    title: 'Welcome To Study Hub',
                    description:
                    'Connect, collaborate, and learn together. Your study journey starts here!',
                    buttonText: 'Get started',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),

                  // Konten Welcome2
                  _buildContentBox(
                    title: 'Find Your Study Buddy',
                    description:
                    'Meet new study partners and ace your goals, together!',
                    buttonText: 'Get Started',
                    onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),

                      // Konten Welcome3
                      _buildContentBox(
                      title: 'Learn and Grow Together',
                      description:
                      'Share resources, track progress, and stay motivated with your group!',
                      buttonText: 'Get Started',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      ),
                      ],
                      ),
                      ),

                      // Bagian titik hijau untuk indikator halaman
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      CircleAvatar(
                      radius: 4,
                      backgroundColor: _currentPage == 0 ? Colors.green : Colors.grey[
                    300],
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 4,
                  backgroundColor: _currentPage == 1 ? Colors.green : Colors.grey[300],
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 4,
                  backgroundColor: _currentPage == 2 ? Colors.green : Colors.grey[300],
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun konten di dalam box putih
  Widget _buildContentBox({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed, // Tambahkan parameter untuk onPressed
  }) {
    return Align(
      alignment: Alignment.bottomCenter, // Menempatkan box di bawah layar
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200, // Tinggi persegi panjang
        width: double.infinity, // Lebar penuh
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.zero, // Tidak ada sudut melengkung
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22, // Ukuran teks lebih besar
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, // Ukuran deskripsi lebih besar
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed, // Panggil fungsi onPressed yang diteruskan
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15, // Tombol lebih besar
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16, // Ukuran teks tombol lebih besar
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
