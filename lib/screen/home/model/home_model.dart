import 'dart:math';

class HomeModel {
  String? base, name;
  num? timezone, visibility;
  int? dt, id, cod;
  List<WeatherModel>? weatherList = [];
  MainModel? mainModel;
  CoordModel? coordModel;
  WindModel? windModel;
  SysModel? sysModel;

  HomeModel(
      {this.base,
      this.name,
      this.timezone,
      this.visibility,
      this.dt,
      this.id,
      this.cod,
      this.weatherList,
      this.mainModel,
      this.coordModel,
      this.windModel,
      this.sysModel});

  factory HomeModel.mapToModel(Map m1) {
    List l1 = m1['weather'];
    return HomeModel(
        id: m1['id'],
        name: m1['name'],
        base: m1['base'],
        cod: m1['cod'],
        coordModel: CoordModel.mapToModel(m1['coord']),
        dt: m1['dt'],
        mainModel: MainModel.mapToModel(m1['main']),
        sysModel: SysModel.mapToModel(m1['sys']),
        timezone: m1['timezone'],
        visibility: m1['visibility'],
        weatherList: l1.map((e) => WeatherModel.mapToModel(e)).toList(),
        windModel: WindModel.mapToModel(m1['wind']));
  }
}

class CoordModel {
  double? lon, lat;

  CoordModel({this.lon, this.lat});

  factory CoordModel.mapToModel(Map m1) {
    return CoordModel(lat: m1['lon'], lon: m1['lon']);
  }
}

class WeatherModel {
  int? id;
  String? main, description;

  WeatherModel({this.id, this.main, this.description});

  factory WeatherModel.mapToModel(Map m1) {
    return WeatherModel(
        id: m1['id'], description: m1['description'], main: m1['main']);
  }
}

class MainModel {
  double? temp, feels_like, temp_min, temp_max;
  int? pressure, humidity, sea_level, grnd_level;

  MainModel(
      {this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity,
      this.sea_level,
      this.grnd_level});

  factory MainModel.mapToModel(Map m1) {
    return MainModel(
        feels_like: m1['feels_like'],
        grnd_level: m1['grnd_level'],
        humidity: m1['humidity'],
        pressure: m1['pressure'],
        sea_level: m1['sea_level'],
        temp: m1['temp'],
        temp_max: m1['temp_max'],
        temp_min: m1['temp_min']);
  }
}

class WindModel {
  num? speed, deg;

  WindModel({this.speed, this.deg});

  factory WindModel.mapToModel(Map m1) {
    return WindModel(speed: m1['speed'], deg: m1['deg']);
  }
}

class SysModel {
  int? type, id, sunrise, sunset;
  String? country;

  SysModel({this.type, this.id, this.sunrise, this.sunset, this.country});

  factory SysModel.mapToModel(Map m1) {
    return SysModel(
        id: m1['id'],
        country: m1['country'],
        sunrise: m1['sunrise'],
        sunset: m1['sunset'],
        type: m1['type']);
  }
}
