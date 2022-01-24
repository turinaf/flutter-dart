import 'dart:convert';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    'pk.eyJ1IjoidHVyaTU0OCIsImEiOiJja3lxbW5oemcwbGFnMnBvM3BuMGpsM296In0.L3DvsF_j4_O_7lMeB05ZBA';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14.25,0,60/300x300?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng, $lat.json?limit=1&types=place%2Cpostcode%2Caddress&access_token=$MAPBOX_API_KEY";

    final response = await http.get(Uri.parse(url));
    // -- this response contain the data we need in JSON format. To convert it, we need ot import dart.convert
    print(json.decode(response.body)['features'][0]['place_name']);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
