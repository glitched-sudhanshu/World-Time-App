import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //time in that location
  late String flag; //url to an asset flaog icon
  late String url; //location url for api endpoint
  late bool isDayTime; //for images etc.

  //constructor
  WorldTime({this.location = 'null', this.flag = 'null', this.url = 'null'});

  Future<void> getTime() async {
    try {
      //Taking response
      final link = "http://worldtimeapi.org/api/timezone/$url";
      Response response = await get(Uri.parse(link));
      Map data = jsonDecode(response.body);

      //taking properties from response
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'];

      //parsing datetime using DateTime object
      DateTime now = DateTime.parse(datetime);

      //adding offset
      String offset_hours = offset.substring(1, 3);
      String offset_min = offset.substring(4, 6);

      now = now.add(Duration(
          hours: int.parse(offset_hours), minutes: int.parse(offset_min)));

      //setting time
      //time = now.toString();
      isDayTime = now.hour >= 5 && now.hour <= 17 ? true : false;
      //UI friendly time
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('ERROR: $e');
      time = "Couldn't load the data";
    }
  }
}
