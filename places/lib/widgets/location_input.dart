import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _priviewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    // final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: _locationData.latitude as double,
      longitude: _locationData.longitude as double,
    );

    //-- Assign the staticMapImageUrl to  _previewImageUrl
    setState(() {
      _priviewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMp() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        isSelecting: true,
      ),
    ));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _priviewImageUrl == null
              ? const Text("No location Chosen", textAlign: TextAlign.center)
              : Image.network(
                  _priviewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                'Current location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red)),
            ),
            TextButton.icon(
              onPressed: _selectOnMp,
              icon: const Icon(Icons.map),
              label: Text(
                'Select On Map',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red)),
            )
          ],
        )
      ],
    );
  }
}
