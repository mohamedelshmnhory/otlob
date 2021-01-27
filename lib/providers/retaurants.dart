import 'package:flutter/material.dart';
import 'package:otlob/models/restaurant.dart';

class Restaurants with ChangeNotifier {
  final data = [
    {
      'title': 'اهل الشام',
      'description': 'شاورما, سندوتشات, وجبات سريعة',
      'category': 'سوري',
      'address': 'المنصورة - شارع الترعة',
      'photoUrl': 'https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg',
      'rate': 4.0,
      'status': 'مفتوح',
      'distance': 2.0,
      'meals': [
        {
          'title': 'بيتزا',
          'photoUrl':
              'https://post.healthline.com/wp-content/uploads/2020/07/pizza-beer-1200x628-facebook-1200x628.jpg',
          'price': 30.0,
        },
        {
          'title': 'بطاطس',
          'photoUrl':
              'https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg',
          'price': 20.0,
        },
      ],
    },
    {
      'title': 'اهل مصر',
      'description': 'كبده, فراخ, وجبات سريعة',
      'category': 'مصري',
      'address': 'الاسكندريه - شارع الترعة',
      'photoUrl':
          'https://post.healthline.com/wp-content/uploads/2020/07/pizza-beer-1200x628-facebook-1200x628.jpg',
      'rate': 3.0,
      'status': 'مغلق',
      'distance': 1.0,
      'meals': [
        {
          'title': 'بيتزا',
          'photoUrl':
              'https://post.healthline.com/wp-content/uploads/2020/07/pizza-beer-1200x628-facebook-1200x628.jpg',
          'price': 30.0,
        },
        {
          'title': 'فراخ',
          'photoUrl':
              'https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg',
          'price': 40.0,
        }
      ],
    },
  ];

  List<Restaurant> _restaurants = [];
  List<String> _categories = [];

  List<Restaurant> get restaurants {
    return [..._restaurants];
  }

  List<String> get categories {
    return [..._categories];
  }

  Future<void> fetchRestaurants() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      final List<Restaurant> loadedRestaurants = [];
      final List<String> loadedCategories = [];
      data.forEach((restaurant) {
        loadedRestaurants.add(Restaurant(
          title: restaurant['title'],
          description: restaurant['description'],
          address: restaurant['address'],
          category: restaurant['category'],
          status: restaurant['status'],
          distance: restaurant['distance'],
          rate: restaurant['rate'],
          photoUrl: restaurant['photoUrl'],
          meals: restaurant['meals'],
        ));

        loadedCategories.add(restaurant['category']);
      });
      _restaurants = loadedRestaurants;
      _categories = loadedCategories;
    });
  }
}
