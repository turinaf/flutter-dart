import 'dart:collection';

import 'package:path/path.dart';

const MAPBOX_API_KEY =
    'pk.eyJ1IjoidHVyaTU0OCIsImEiOiJja3lxbW5oemcwbGFnMnBvM3BuMGpsM296In0.L3DvsF_j4_O_7lMeB05ZBA';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14.25,0,60/300x300?access_token=$MAPBOX_API_KEY';
  }
}
