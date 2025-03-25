part of 'app_service_imports.dart';

class GeolocationService extends GetxService{

  Future<GeolocationService> init() async {
    listener = Geolocator.getServiceStatusStream().listen(onStatusChanged);
    return this;
  }

  @override
  void onClose() {
    listener?.cancel();
  }

  StreamSubscription<ServiceStatus>? listener;
  var api = Get.find<ApiService>();
  var db = Get.find<DatabaseService>();

  Future<Position?> determinePosition({bool forceTurnOnLocation = false, bool forceGivePermission = false}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if(forceTurnOnLocation) {

        // AppDialog.alert(
        //   title: const Text('Turn on Location'),
        //   content: const Text('Please turn on the location services to go ahead.'),
        //   confirmText: 'OK',
        //   denyText: ''
        // ).then((value){
        //   if(value ?? false) Geolocator.openLocationSettings();
        // });
      }
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      if(forceGivePermission) {
        // AppDialog.alert(
        //   title: const Text('Location Permission'),
        //   content: const Text('Location permission is needed to use the app.'),
        //   confirmText: 'OK',
        //   denyText: ''
        // ).then((value){
        //   if(value ?? false) Geolocator.openAppSettings();
        // });
      }
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      return await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 2), desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      return await Geolocator.getLastKnownPosition();
    }
  }

  Future<String> getLocationString({bool forceTurnOnLocation = false, bool forceGivePermission = false}) async {
    var position = await determinePosition(forceTurnOnLocation: forceTurnOnLocation, forceGivePermission: forceGivePermission);
    if(position == null) return '';
    var locationString = [position.latitude, position.longitude].join(',');
    db.putLastKnownLocation(locationString);
    return locationString;
  }

  Future<String> getLastKnownLocationString({bool forceTurnOnLocation = false, bool forceGivePermission = false}) async {
    try {
      return await getLocationString(forceTurnOnLocation: forceTurnOnLocation, forceGivePermission: forceGivePermission);
    } catch (e) {
      return db.lastKnownLocation ?? '';
    }
  }

  Future<bool> isPermissionGranted() async => await Geolocator.checkPermission() != LocationPermission.denied;

  Future<bool> getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
      return false;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    return permission != LocationPermission.denied;
  }

  void onStatusChanged(ServiceStatus status) {
    if(status == ServiceStatus.enabled) {
      sendLocation();
    }
  }

  void sendLocation() async {
    try {
      var position = await getLocationString(forceTurnOnLocation: false);
      // if(position.isNotEmpty) await Get.find<UserApi>().userLocation(location: position);
    } catch (e) {}
  }

}