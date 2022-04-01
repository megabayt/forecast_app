import 'dart:convert';

WeatherInfo weatherInfoFromJson(String str) => WeatherInfo.fromJson(json.decode(str));

String weatherInfoToJson(WeatherInfo data) => json.encode(data.toJson());

class WeatherInfo {
    WeatherInfo({
        required this.version,
        required this.user,
        required this.dateGenerated,
        required this.status,
        required this.data,
    });

    final String version;
    final String user;
    final DateTime dateGenerated;
    final String status;
    final List<Datum> data;

    WeatherInfo copyWith({
        String? version,
        String? user,
        DateTime? dateGenerated,
        String? status,
        List<Datum>? data,
    }) => 
        WeatherInfo(
            version: version ?? this.version,
            user: user ?? this.user,
            dateGenerated: dateGenerated ?? this.dateGenerated,
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
        version: json["version"],
        user: json["user"],
        dateGenerated: DateTime.parse(json["dateGenerated"]),
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "user": user,
        "dateGenerated": dateGenerated.toIso8601String(),
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.parameter,
        required this.coordinates,
    });

    final String parameter;
    final List<Coordinate> coordinates;

    Datum copyWith({
        String? parameter,
        List<Coordinate>? coordinates,
    }) => 
        Datum(
            parameter: parameter ?? this.parameter,
            coordinates: coordinates ?? this.coordinates,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        parameter: json["parameter"],
        coordinates: List<Coordinate>.from(json["coordinates"].map((x) => Coordinate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "parameter": parameter,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x.toJson())),
    };
}

class Coordinate {
    Coordinate({
        required this.lat,
        required this.lon,
        required this.dates,
    });

    final double lat;
    final double lon;
    final List<Date> dates;

    Coordinate copyWith({
        double? lat,
        double? lon,
        List<Date>? dates,
    }) => 
        Coordinate(
            lat: lat ?? this.lat,
            lon: lon ?? this.lon,
            dates: dates ?? this.dates,
        );

    factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
    };
}

class Date {
    Date({
        required this.date,
        required this.value,
    });

    final DateTime date;
    final dynamic value;

    Date copyWith({
        DateTime? date,
        dynamic value,
    }) => 
        Date(
            date: date ?? this.date,
            value: value ?? this.value,
        );

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["date"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "value": value,
    };
}
