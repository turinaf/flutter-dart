import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/great_places.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String imageTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: imageTitle,
      location: PlaceLocation(latitude: 10.0, longitude: 10.0),
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
