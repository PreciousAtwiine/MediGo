import 'package:geocoding/geocoding.dart' as geo;
import 'package:cloud_firestore/cloud_firestore.dart';

class GeocodingService {
  Future<GeoPoint?> getCoordinatesFromAddress(String address) async {
    try {
      final locations = await geo.locationFromAddress(address);
      if (locations.isEmpty) return null;

      final location = locations.first;
      return GeoPoint(location.latitude, location.longitude);
    } catch (e) {
      // Address couldn't be geocoded (invalid, too vague, no internet, etc.)
      return null;
    }
  }
}