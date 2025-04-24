import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/repository/weather_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  WeatherRepository _repository = WeatherRepository();
  WeatherModel? _weatherModel;

  @override
  void initState() {
    super.initState();
    getDate();
  }

  getDate() async {
    _weatherModel = await _repository.getWeather('osh');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/graphic.png'),
          // Text(
          //   '${_weatherModel?.weather?.first.main ?? '-'} ${_weatherModel?.main?.temp?.round() ?? '-'} C ${_weatherModel?.main?.tempMax ?? '-'} -/${_weatherModel?.main?.tempMin ?? '-'}',
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset('assets/rr.png'),
                  Text('${_weatherModel?.weather?.first.main}'),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(alignment: PlaceholderAlignment.top, child: Text( '${_weatherModel?.main?.temp?.round()}',style: TextStyle(fontSize: 64,height: 1),),),
                    TextSpan(text: 'C'),
                  ],
                ),
              ),
              Text('${_weatherModel?.main?.tempMax}\n${_weatherModel?.main?.tempMin}'),
            ],
          ),
        ],
      ),
    );
  }
}
