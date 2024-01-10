import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthypet/screens/Fav.dart';
import 'package:healthypet/screens/MainAfterLogin.dart';
import 'package:healthypet/screens/chat.dart';
import 'package:healthypet/screens/home_screen.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  var selectedMenu = 3; // Ganti ke indeks ikon profil (FeatherIcons.user)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: const Color(0xFF818AF9),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: FeatherIcons.home.toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.heart),
            label: FeatherIcons.heart.toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.messageCircle),
            label: FeatherIcons.messageCircle.toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.user),
            label: FeatherIcons.user.toString(),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: const Color(0xFFBFBFBF),
        currentIndex: selectedMenu,
        onTap: (index) {
          setState(() {
            selectedMenu = index;
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainAfterLogin()),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavScreen()),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            }
          });
        },
      );

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FeatherIcons.user,
            size: 48,
            color: const Color(0xFF818AF9),
          ),
          const SizedBox(height: 16),
          Text(
            'Profil',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF818AF9),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              _showLogoutConfirmationDialog(); // Panggil fungsi notifikasi konfirmasi
            },
            child: Text('Logout'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan notifikasi konfirmasi
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Will Logout From This Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are You Sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Tambahkan logika logout atau tindakan yang sesuai di sini
                // Contoh: Navigasi ke home_screen.dart
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
