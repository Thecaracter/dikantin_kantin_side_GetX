// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:dikantin/app/data/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/profile_model.dart';
import '../../../data/providers/profile_provider.dart';

class OrderController extends GetxController {
  var locationMessage = "Belum mendapatkan Lat dan Long".obs;
  var addressMessage = "".obs;
  var textEditingController = TextEditingController().obs;
  final ProfileProvider provider = ProfileProvider().obs();
  final _customerProvider = CustomerProvider().obs;
  Rx<Profile> profile = Profile().obs;
  var addressController = TextEditingController();

  RxBool isImageUploading = false.obs;
  RxBool isLoading = true.obs;

  var myPosition = Position(
    altitudeAccuracy: 0,
    headingAccuracy: 0,
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0.0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  ).obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service belum aktif");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied)
        return Future.error("Location Permission ditolak");
    }

    if (locationPermission == LocationPermission.deniedForever)
      return Future.error(
          "Location permission ditolak, gagal request permissions");

    Position position = await Geolocator.getCurrentPosition();
    myPosition.value = position;
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    addressMessage.value =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ";
  }

  Future<void> getCustomerData() async {
    try {
      isLoading(true);

      // Call the getCustomer method from CustomerProvider
      Profile result = await _customerProvider.value.fetchDatacus();

      // Update the customer data
      profile(result);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching dataprofile: $error');
    }
  }

  Future<void> editAlamat({
    required String alamat,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        await provider.editAlamat(
          token: token,
          alamat: alamat,
        );
        await getCustomerData();
      } catch (error) {
        // Handle and print the error
        print('Error updating profile: $error');
      }
    } else {
      // Handle case where token is not available (e.g., user not logged in)
      print('Token not available. User not logged in.');
    }
  }
}
