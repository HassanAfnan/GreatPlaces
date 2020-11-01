import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/helper/location_helper.dart';
import 'package:greatplaces/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPlace;
  LocationInput(this.onSelectedPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Future<void> _getCurrentUserLocation() async{
    final locData = await Location().getLocation();
    final staticMapUrl = LocationHelper.generatedLocationPreviewImage(
        latitude: locData.latitude,
        longitude:locData.longitude
    );
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.onSelectedPlace(locData.latitude,locData.longitude);
  }

  Future<void> _selectOnMap() async {
     final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (context) => MapScreen(
      isSelecting: true,
    )));
     if(selectedLocation == null){
       return;
     }
     final staticMapUrl = LocationHelper.generatedLocationPreviewImage(
         latitude: selectedLocation.latitude,
         longitude: selectedLocation.longitude
     );
     setState(() {
       _previewImageUrl = staticMapUrl;
     });
     print(selectedLocation.latitude);
     widget.onSelectedPlace(selectedLocation.latitude,selectedLocation.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey)
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null?Text("No Location Choosen",textAlign: TextAlign.center,):Image.network(_previewImageUrl,fit: BoxFit.cover,width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(onPressed: _getCurrentUserLocation, icon: Icon(Icons.location_on), label: Text("Current Location")),
            FlatButton.icon(onPressed: () => _selectOnMap(), icon: Icon(Icons.map), label: Text("Select on Map")),

          ],
        ),
      ],
    );
  }
}
