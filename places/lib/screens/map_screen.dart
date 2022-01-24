import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/ma-screen';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 30.5723, longitude: 104.0665),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  // void _selectLocation(LatLng position) {
  //   setState(() {
  //     _pickedLocation = position;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13.0,

          // -- Alternative to initialize tha map by specifying bounds intead of Center and Zoom
          // bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
          // boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),

          onTap: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            //-- Mapbox URL
            urlTemplate:
                "https://api.mapbox.com/styles/v1/turi548/ckyqoe0eb3fnp15pj6blslgpm/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidHVyaTU0OCIsImEiOiJja3lxbWU3YmYwbDZ6Mm9wMmV2YTRvMW1kIn0.Vo0WObovg19JPlgYKDvIjg",
            // -- Object for adding accessToken and Tile ID of MapBox
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoidHVyaTU0OCIsImEiOiJja3lxbWU3YmYwbDZ6Mm9wMmV2YTRvMW1kIn0.Vo0WObovg19JPlgYKDvIjg',
              'id': 'mapbox.mapbox-streets-v8'
            },
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _pickedLocation == null
                    ? LatLng(widget.initialLocation.latitude,
                        widget.initialLocation.longitude)
                    : LatLng(
                        _pickedLocation!.latitude, _pickedLocation!.longitude),
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
