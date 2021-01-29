import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:otlob/models/category.dart';
import 'package:otlob/models/restaurant.dart';

class Restaurants with ChangeNotifier {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _location;
  List<Restaurant> _restaurants = [];
  List<Category> _categories = [];

  List<Restaurant> get restaurants {
    return [..._restaurants];
  }

  List<Category> get categories {
    return [..._categories];
  }

  Future<void> fetchRestaurants([bool filterBycat = false, catId]) async {
    final filterString = filterBycat ? '?langu=ar&catId=$catId' : '?langu=ar';
    var url = 'http://otlob.accuragroup-eg.net/api/getResturants$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['return'] as List;
      if (extractedData == null) {
        return;
      }
      final List<Restaurant> loadedRestaurants = [];
      extractedData.forEach((restaurant) async {
        double d = calculateDistance(
          double.parse(restaurant['rest_location'][0]),
          double.parse(restaurant['rest_location'][1]),
          _location.latitude,
          _location.longitude,
        );
        loadedRestaurants.add(Restaurant(
          title: restaurant['rest_name'],
          description: restaurant['rest_type'],
          address: 'العنوان',
          category: restaurant['cat_id'],
          status: 'متاح للتوصيل',
          distance: d.toStringAsFixed(1),
          rate: restaurant['rate'],
          photoUrl: restaurant['rest_img'],
          meals: restaurant['products'],
          lat: double.parse(restaurant['rest_location'][0]),
          long: double.parse(restaurant['rest_location'][1]),
        ));
      });

      _restaurants = loadedRestaurants;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchCategories() async {
    var url = 'http://otlob.accuragroup-eg.net/api/getCategories';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['return'] as List;
      if (extractedData == null) {
        return;
      }
      final List<Category> loadedCategories = [];
      extractedData.forEach((restaurant) {
        loadedCategories
            .add(Category(id: restaurant['id'], name: restaurant['name']));
      });
      _categories = loadedCategories;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> getLocation() async {
    Location location = Location();
    _location = await location.getLocation();
  }

  Future<void> checkLocationServicesInDevice() async {
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        await getLocation();
      } else {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          await getLocation();
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      _serviceEnabled = await location.requestService();

      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          await getLocation();
        } else {
          _permissionGranted = await location.requestPermission();

          if (_permissionGranted == PermissionStatus.granted) {
            await getLocation();
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }

  Future<String> getAddress() async {
    final coordinates = Coordinates(_location.latitude, _location.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    print(first.addressLine);
    return '${first.addressLine.substring(1, 20)}...';
  }
}
