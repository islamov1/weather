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
  TextEditingController cityController = TextEditingController(text: 'osh');

  @override
  void initState() {
    super.initState();
    getDate();
  }

  getDate() async {
    _weatherModel = await _repository.getWeather(cityController.text);
    _forcastModel = await _repository.getForcast(cityController.text);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
      (_weatherModel?.sys?.sunrise ?? 0) * 1000,
    );
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
      (_weatherModel?.sys?.sunset ?? 0) * 1000,
    );

    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('assets/graphic.png', fit: BoxFit.fill)),
          // Text(
          //   '${_weatherModel?.weather?.first.main ?? '-'} ${_weatherModel?.main?.temp?.round() ?? '-'} C ${_weatherModel?.main?.tempMax ?? '-'} -/${_weatherModel?.main?.tempMin ?? '-'}',
          // ),
          Row(
            children: [
              Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())),
              Spacer(),
              Container(
                width: 154,
                height: 48,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(14, 159, 234, 0.08),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(17),
                              right: Radius.circular(17),
                            ),
                            boxShadow: [
                              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2)),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.all(20),
                                width: 335,
                                height: 40,

                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 243, 243, 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextField(
                                  controller: cityController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                width: 335,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(13, 160, 234, 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    getDate();
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(cityController.text),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 40,),
          SizedBox(
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
          SizedBox(height: 40,),

          SizedBox(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset('assets/tt.png'),
                    Text(
                      '${_weatherModel?.main?.humidity}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('Humidity'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/tat.png'),
                    Text('${_weatherModel?.main?.pressure}mBar'),
                    Text('Pressure'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/tit.png'),

                    Text('${_weatherModel?.wind?.speed} km/h'),
                    Text('Wind'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset('assets/sunrise.png'),
                  Text('${DateFormat('HH:mm').format(sunrise)}'),
                  Text('Sunrise'),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/sunset.png'),
                  Text('${DateFormat('HH:mm').format(sunset)}'),
                  Text('Sunset'),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/daytime.png'),
                  Text(' ${sunset.difference(sunrise).inHours}h'),
                  Text('DayTime'),
                ],
              ),
            ],
          ),
          SizedBox(height: 40,),

          // Text(
          //   '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_weatherModel?.sys?.sunset ?? 0) * 1000))}',
          // ),
          SizedBox(
            height: 114,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _forcastModel?.list?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(12),
                  width: 95,
                  height: 114,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        getIcon(
                          _forcastModel?.list?[index].weather?.first.icon,
                        ),
                      ),
                      Text(
                        '${DateFormat('E, d HH:mm').format(DateTime.fromMillisecondsSinceEpoch((_forcastModel?.list?[index].dt ?? 0) * 1000))}',
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
          SizedBox(height: 40,),

        ],
      ),
    );
  }

  String getIcon(icon) {
    return 'https://openweathermap.org/img/wn/${icon}.png';
  }
}
