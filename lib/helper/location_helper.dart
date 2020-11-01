import 'dart:convert';

import 'package:http/http.dart' as http;
const GOOGLE_API_KEY = "AIzaSyCdRQHsMpxBuzD15JhTk5pjvxGN-kCACpY";

class LocationHelper {
  static String generatedLocationPreviewImage({double latitude,double longitude}){
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat,double lhg) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lhg&key=$GOOGLE_API_KEY";
    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}