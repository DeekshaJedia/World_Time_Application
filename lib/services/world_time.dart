import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDaytime = false; // true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      // make the request
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      if (response.statusCode == 200) {
        // parse JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        // get properties from json
        final datetime = data['datetime'];
        final offset = data['utc_offset']?.substring(1, 3);

        if (datetime != null && offset != null) {
          // create DateTime object
          DateTime now = DateTime.parse(datetime);
          now = now.add(Duration(hours: int.parse(offset)));

          // set the time property
          isDaytime = now.hour > 6 && now.hour < 20;
          time = DateFormat.jm().format(now);
        } else {
          throw Exception('Invalid data');
        }
      } else {
        // handle HTTP error
        throw Exception(
            'Failed to fetch time data, HTTP ${response.statusCode}');
      }
    } catch (e) {
      // handle any other error
      print('Error fetching time data: $e');
      time = 'Could not get time';
    }
  }
}
