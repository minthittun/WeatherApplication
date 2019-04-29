import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_application/models/WeatherResultModel.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _isLoading = false;
  var _result = "";
  var _icon = "";


  @override
  void initState() {
    _fetchWeather();
  }

  void _fetchWeather() async {

    setState(() {
      this._isLoading = true;
    });

    try{

      final response = await http.get('https://api.openweathermap.org/data/2.5/weather?q=Yangon&appid=b4d81e0bf8b2c3ed3b40836596491b5d&units=metric');

      if(response.statusCode == 200) {

        WeatherResultModel result = WeatherResultModel.fromJson(json.decode(response.body));

        setState(() {

          this._isLoading = false;
          this._result = result.main.temp.toString() + " °C";
          this._icon = result.weather[0].icon + ".png";

        });

      }

    }
    catch(e){
      //catch exception
      setState(() {
        this._isLoading = false;
        this._result = "Network error";
      });
    }

  }

  Widget getMainWieget() {

    if(_isLoading) {
      return Text("Loading ....",
                  style: TextStyle(
                    color: Colors.white
                  ));
      //return CircularProgressIndicator();
    }
    else {

      return getWeatherWidget();

    }


  }

  Widget getWeatherWidget() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
          child: Text("Yangon",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 70),
          child: Text(DateFormat("EEEE").format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
        ),
        Container(
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 35),
          child: Image(
            image: AssetImage("assets/images/" + _icon),
            width: 50,
          )
        ),
        Container(
          child: Text("Temperature",
              style: TextStyle(
                  color: Colors.white,
              )),
        ),
        Container(
          child: Text("$_result",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      )),
        )
        
      ],
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.blueGrey[900],
      body: Center(child: getMainWieget()),
    );
  }
}
