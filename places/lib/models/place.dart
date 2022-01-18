import 'dart:io';
// dart:io package is required for the File datatype used for image.

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

// - Using named argument. This is achieved by simply using carly brakets
  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
