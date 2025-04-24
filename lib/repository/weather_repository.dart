import 'dart:convert';

import 'package:weather/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel?> getWeather(String q) async{
    var response = await http.get (Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$q&appid=b5df4031a40805aa77165664bd27c05e&units=metric'));
    print('---weather${response.body}');
    if (response.statusCode==200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}