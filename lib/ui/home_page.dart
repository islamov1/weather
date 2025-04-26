import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/forcast_model.dart';
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
  ForcastModel? _forcastModel;

  @override
  void initState() {
    super.initState();
    getDate();
  }

  getDate() async {
    _weatherModel = await _repository.getWeather('osh');
    _forcastModel = await _repository.getForcast('osh');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('assets/graphic.png', fit: BoxFit.fill)),
          // Text(
          //   '${_weatherModel?.weather?.first.main ?? '-'} ${_weatherModel?.main?.temp?.round() ?? '-'} C ${_weatherModel?.main?.tempMax ?? '-'} -/${_weatherModel?.main?.tempMin ?? '-'}',
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Text(
                          '${_weatherModel?.main?.temp?.round()}',
                          style: TextStyle(fontSize: 64, height: 1),
                        ),
                      ),
                      TextSpan(text: 'C'),
                    ],
                  ),
                ),
                Text(
                  '${_weatherModel?.main?.tempMax}\n${_weatherModel?.main?.tempMin}',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset('assets/tt.png'),
                    RichText(
                      text: TextSpan(
                        text: '${_weatherModel?.main?.humidity}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/tat.png'),
                    RichText(
                      text: TextSpan(
                        text: '${_weatherModel?.main?.pressure}mBar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/tit.png'),
                    RichText(text: TextSpan(text: '${_weatherModel?.wind?.speed} km/h',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset('assets/sunrise.png'),
                    RichText(text: TextSpan(text:  '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_weatherModel?.sys?.sunrise ?? 0) * 1000))}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/sunset.png'),
                    RichText(text: TextSpan(text:  '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_weatherModel?.sys?.sunset ?? 0) * 1000))}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/daytime.png'),
                    RichText(text: TextSpan(text: ' ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_weatherModel?.sys?.sunset ?? 0) * 1000))}')),
                  ],
                ),
              ],
            ),
          ),

          // Text(
          //   '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_weatherModel?.sys?.sunset ?? 0) * 1000))}',
          // ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _forcastModel?.list?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Image.network(
                        getIcon(
                          _forcastModel?.list?[index].weather?.first.icon,
                        ),
                      ),
                      Text(
                        '${_forcastModel?.list?[index].main?.temp?.round()}',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getIcon(icon) {
    return 'https://openweathermap.org/img/wn/${icon}.png';
  }
}
