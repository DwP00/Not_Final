import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthypet/models/doctor_model.dart';
import 'package:healthypet/models/service_model.dart';
import 'package:healthypet/screens/MainAfterLogin.dart';
import 'package:healthypet/screens/ProfilPage.dart';
import 'package:healthypet/screens/chat.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  var selectedMenu = 1; // Ganti ke indeks ikon hati (FeatherIcons.heart)

  @override
  Widget build(BuildContext context) {
    var favoriteDoctors = doctors
        .where(
            (doctor) => doctor.name == "Dr. Luna" || doctor.name == "Dr. Monna")
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF654EA3), Color(0xFFEA7E5C)],
            ),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            // color: Color.fromARGB(255, 132, 1, 1),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            'Your Favorite Doctor is Here',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(favoriteDoctors),
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
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen()),
              );
            }
          });
        },
      );

  Widget _buildBody(List<DoctorModel> favoriteDoctors) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: favoriteDoctors.length,
            itemBuilder: (context, index) {
              return _doctorCard(favoriteDoctors[index]);
            },
          ),
        ),
      ],
    );
  }

  Container _doctorCard(DoctorModel doctor) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF35385A).withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              'assets/images/${doctor.image}',
              width: 88,
              height: 103,
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3F3E3F),
                  ),
                ),
                const SizedBox(height: 7),
                RichText(
                  text: TextSpan(
                    text: 'Layanan: ${doctor.services.join(", ")}',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      FeatherIcons.mapPin,
                      size: 14,
                      color: Color(0xFFACA3A3),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '${doctor.distance} km',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: const Color(0xFFACA3A3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
