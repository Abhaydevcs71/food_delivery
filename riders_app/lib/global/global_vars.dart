

  import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Position? position;
  List<Placemark>? placemark;
  String fullAddress = "";

  SharedPreferences? sharedPreferences;