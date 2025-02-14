import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  StreamSubscription<Position>? _positionStreamSubscription;

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  // Method to check location permission and request if needed
  Future<LocationPermission> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  // Start streaming the location every 5 seconds
  void startLocationUpdates() async {
    try {
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }

      LocationPermission permission = await requestLocationPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied.");
      }

      // Listen to position stream every 5 seconds
      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
        distanceFilter: 10,accuracy: LocationAccuracy.high    
        ),
      ).listen((Position position) async {
        await saveLocation(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error while starting location updates: $e");
      throw Exception("Failed to start location updates: $e");
    }
  }

  // Stop the location stream when not needed
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    print("Location updates stopped.");
  }

  // Save location data to SharedPreferences
  Future<void> saveLocation(double latitude, double longitude) async {
    try {
      LocalSharePreference.setCurrentLatitude = latitude.toString();
      LocalSharePreference.setCurrentLongitude = longitude.toString();
      print("Location saved: Latitude: $latitude, Longitude: $longitude");
    } catch (e) {
      print("Error saving location: $e");
    }
  }
}
