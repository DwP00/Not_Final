import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthypet/models/doctor_model.dart';
import 'package:healthypet/models/service_model.dart';
import 'package:healthypet/screens/Fav.dart';
import 'package:healthypet/screens/ProfilPage.dart';
import 'package:healthypet/screens/chat.dart';

var selectedService = 0;
var menus = [
  FeatherIcons.home,
  FeatherIcons.heart,
  FeatherIcons.messageCircle,
  FeatherIcons.user,
];
var selectedMenu = 0;

class MainAfterLogin extends StatefulWidget {
  const MainAfterLogin({Key? key}) : super(key: key);

  @override
  _MainAfterLoginState createState() => _MainAfterLoginState();
}

class _MainAfterLoginState extends State<MainAfterLogin> {
  List<DoctorModel> filteredDoctors = [];
  TextEditingController searchController = TextEditingController();
  int selectedMenu = 0;

  @override
  void initState() {
    filteredDoctors = doctors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _bottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _greetings(),
              const SizedBox(height: 16),
              _card(),
              const SizedBox(height: 20),
              _search(),
              const SizedBox(height: 20),
              _services(),
              const SizedBox(height: 27),
              _doctors(),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: const Color(0xFF818AF9),
        type: BottomNavigationBarType.fixed,
        items: menus
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e),
                  label: e.toString(),
                ))
            .toList(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: const Color(0xFFBFBFBF),
        currentIndex: selectedMenu,
        onTap: (index) {
          setState(() {
            selectedMenu = index;
            if (index == menus.indexOf(FeatherIcons.heart)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavScreen()),
              );
            }
            if (index == menus.indexOf(FeatherIcons.messageCircle)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            }
            if (index == menus.indexOf(FeatherIcons.user)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen()),
              );
            }
          });
        },
      );

  ListView _doctors() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _doctor(filteredDoctors[index]),
      separatorBuilder: (context, index) => const SizedBox(
        height: 11,
      ),
      itemCount: filteredDoctors.length,
    );
  }

  Container _doctor(DoctorModel doctorModel) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/images/${doctorModel.image}',
              width: 70,
              height: 103,
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorModel.name,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3F3E3F),
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    text: "Layanan: ${doctorModel.services.join(', ')}",
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
                      "${doctorModel.distance}km",
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
          Spacer(),
          IconButton(
            icon: Icon(
              doctorModel.isFavorite ? FeatherIcons.heart : FeatherIcons.heart,
              size: 20,
              color: doctorModel.isFavorite
                  ? Color.fromARGB(255, 255, 0, 0)
                  : const Color(0xFFBFBFBF),
            ),
            onPressed: () {
              setState(() {
                doctorModel.isFavorite = !doctorModel.isFavorite;
                // Panggil callback ketika ikon hati diklik
                doctorModel.onFavoriteChanged?.call();
              });
            },
          ),
        ],
      ),
    );
  }

  SizedBox _services() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedService = index;
              // Logika untuk menampilkan dokter yang sesuai dengan layanan dipilih
              filteredDoctors = doctors
                  .where((doctor) =>
                      doctor.services.contains(Service.all()[index]))
                  .toList();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: selectedService == index
                  ? const Color(0xFF818AF9)
                  : const Color(0xFFF6F6F6),
              border: selectedService == index
                  ? Border.all(
                      color: const Color(0xFFF1E5E5).withOpacity(.22),
                      width: 2,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                Service.all()[index],
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: selectedService == index
                      ? Colors.white
                      : const Color(0xFF3F3E3F).withOpacity(.3),
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: Service.all().length,
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: (query) {
          setState(() {
            filteredDoctors = doctors
                .where((doctor) =>
                    doctor.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            FeatherIcons.search,
            color: Color(0xFFADACAD),
          ),
          hintText: "Your serch here...",
          hintStyle: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFCACACA),
            height: 150 / 100,
          ),
        ),
      ),
    );
  }

  Padding _greetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, Hooman!',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF3F3E3F),
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF818AF9),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background_card.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Your, ",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xFFDEE1FE),
                        height: 150 / 100,
                      ),
                      children: const [
                        TextSpan(
                          text: "Catrine ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: "\n will be vaccinated "),
                        TextSpan(
                          text: "Tomorrow \n07.00AM!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tombol "Lihat Detail" dihilangkan
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(.4),
                  //     border: Border.all(
                  //       color: Colors.white.withOpacity(.12),
                  //       width: 2,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Text(
                  //     "Lihat detail",
                  //     style: GoogleFonts.manrope(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
