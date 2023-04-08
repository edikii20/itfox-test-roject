import 'package:geolocator/geolocator.dart';
import 'package:itfox_test_project/src/domain/entities/geopoint.dart';

class GeolocatorApi {
  static final instance = GeolocatorApi._();
  GeolocatorApi._();

  Future<Geopoint?> getCurrentGeolacation() async {
    final permisson = await _checkPermission();
    if (permisson) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return Geopoint(
        name: 'current',
        lat: position.latitude,
        lon: position.longitude,
      );
    }
    return null;
  }

  Future<bool> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return serviceEnabled;
  }
}
