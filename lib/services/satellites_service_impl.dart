import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:dart_predict/dart_predict.dart' as dp;
import 'package:dart_predict/interfaces/qth.dart';
import 'package:forecast_app/interfaces/satellites_above.dart';
import 'package:forecast_app/services/interfaces/satellites_service.dart';
import 'package:http/http.dart' as http;

class SatellitesServiceImpl implements SatellitesService {
  final _tleUrl =
      'https://www.celestrak.com/NORAD/elements/supplemental/gps.txt';
  final Map<String, String> _satellites = {};
  bool _loaded = false;

  @override
  Future<void> load({bool download = true}) async {
    final file = await (download ? _loadUrl() : _loadFile());
    _parseFile(file);
    _loaded = true;
  }

  Future<String> _loadUrl() async {
    final response = await http.get(Uri.parse(_tleUrl));

    return response.body;
  }

  Future<String> _loadFile() {
    return rootBundle.loadString('../data/gps-ops.txt');
  }

  int _parseFile(String content) {
    LineSplitter ls = const LineSplitter();
    List<String> lines = ls.convert(content);
    var loaded = 0;
    while (lines.length >= 3) {
      var lte = lines.sublist(0, 3).join("\n");
      var prn = RegExp(r'PRN (\d+)').firstMatch(lines[0])?.group(1);
      if (prn != null) {
        loaded++;
        _satellites[prn] = lte;
      }
      lines = lines.sublist(3);
    }
    return loaded;
  }

  @override
  Future<List<SatellitesAbove>> getSattelitesAbove({
    required double latitude,
    required double longitude,
    double altitude = 0.1,
    double minimalElevation = 15,
  }) async {
    if (!_loaded) {
      throw Exception('.load() hasn\'t been called before');
    }
    List<SatellitesAbove> visible = [];
    var ref = _satellites;
    try {
      for (var id in ref.keys) {
        var satellite = ref[id];
        if (satellite == null) {
          continue;
        }
        var data = dp.observe(
            satellite,
            Qth(latitude: 55.7762, longitude: 37.7369, altitude: altitude),
            DateTime.now());
        if (data != null && data['elevation'] > minimalElevation) {
          visible.add(SatellitesAbove(
            pnr: id,
            azimuth: data['azimuth'],
            elevation: data['elevation'],
          ));
        }
      }
    } catch (_) {
      print(_);
    }
    return visible;
  }
}
