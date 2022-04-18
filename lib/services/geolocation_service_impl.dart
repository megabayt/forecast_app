import 'package:forecast_app/interfaces/position_with_placemark.dart';
import 'package:forecast_app/services/interfaces/geolocation_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class GeolocationServiceImpl implements GeolocationService {
  GeolocationServiceImpl(YandexGeocoder geocoder) : _geocoder = geocoder;

  final YandexGeocoder _geocoder;

  @override
  Future<PositionWithAddress> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();

    final geocodeResponse = await _geocoder.getGeocode(GeocodeRequest(
        geocode: PointGeocode(
      latitude: position.latitude,
      longitude: position.longitude,
    )));
    final address = geocodeResponse.firstAddress;

    return PositionWithAddress(position: position, address: address);
  }

  // final GeocodeResponse geocodeFromAddress =
  //     await geocoder.getGeocode(GeocodeRequest(
  //   geocode: AddressGeocode(address: text),
  //   lang: Lang.ru,
  // ));
}
