import 'dart:ui';

import 'package:healthypet/models/service_model.dart';

class DoctorModel {
  String name;
  String image;
  List<String> services;
  int distance;
  bool isFavorite;
  VoidCallback? onFavoriteChanged;

  DoctorModel({
    required this.name,
    required this.image,
    required this.services,
    required this.distance,
    this.onFavoriteChanged,
    this.isFavorite = false,
  });
}

var doctors = [
  DoctorModel(
    name: "Dr. Vannesa",
    image: "dr vanesa.png",
    services: [Service.vaccine],
    distance: 2,
  ),
  DoctorModel(
    name: "Dr. Monna",
    image: "Dr. Stone.jpg",
    services: [Service.vaccine, Service.spaAndTreatment],
    distance: 2,
  ),
  DoctorModel(
    name: "Dr. Angel",
    image: "dr angel.png",
    services: [Service.spaAndTreatment],
    distance: 4,
  ),
  DoctorModel(
    name: "Dr. Luna",
    image: "dr lune.png",
    services: [Service.consultation, Service.vaccine],
    distance: 1,
  )
];
