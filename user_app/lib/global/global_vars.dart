

  import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Position? position;
  List<Placemark>? placemark;
  String fullAddress = "";

  SharedPreferences? sharedPreferences;

    TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController completeAddress = TextEditingController();
  TextEditingController flatNumber = TextEditingController();

double latitudeValue = 0.0;
double longitudeValue = 0.0;

String paymentResult = "";