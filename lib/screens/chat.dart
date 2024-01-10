import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthypet/screens/MainAfterLogin.dart';
import 'package:healthypet/screens/Fav.dart';
import 'package:healthypet/screens/ProfilPage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var selectedMenu =
      2; // Ganti ke indeks ikon obrolan (FeatherIcons.messageCircle)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF818AF9), // Ubah warna latar belakang
        title: Row(
          children: [
            Icon(
              FeatherIcons.messageSquare, // Ganti ikon pesan
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Live Chat with a Doctor',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
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
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen()),
              );
            }
          });
        },
      );

  Widget _buildBody() {
    return Container(
      color: const Color(0xFFECEFF9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.messageCircle,
              size: 48,
              color: const Color(0xFF818AF9),
            ),
            const SizedBox(height: 16),
            Text(
              'Ask a Question To Your Doctor Here',
              style: TextStyle(fontSize: 18, color: const Color(0xFF4F5D7A)),
            ),
          ],
        ),
      ),
    );
  }
}
