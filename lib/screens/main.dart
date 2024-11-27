import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Set<Polyline> _polylines = {};

  // 계명대학교 성서캠퍼스 위치
  final LatLng _startLocation = const LatLng(35.8562, 128.4927); // 출발지
  final LatLng _destination = const LatLng(35.8512, 128.5000); // 목적지 예시

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getRoute(); // 지도 생성 시 경로 불러오기
  }

  Future<void> _getRoute() async {
    // Google Directions API 요청 URL
    final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=${_startLocation.latitude},${_startLocation.longitude}&destination=${_destination.latitude},${_destination.longitude}&mode=walking&key=YOUR_API_KEY',
    ));

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      //final steps = json['routes'][0]['legs'][0]['steps'] as List;

      // Polyline 좌표 추출 및 추가
      final points = _decodePolyline(json['routes'][0]['overview_polyline']['points']);
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId("recommended_route"),
          visible: true,
          points: points,
          color: Colors.blue,
          width: 4,
        ));
      });
    } else {
      print("Failed to load directions: ${response.statusCode}");
    }
  }

  // Polyline 경로 디코딩 함수
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('경로 추천'),
          backgroundColor: const Color.fromARGB(255, 114, 243, 232),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _startLocation,
            zoom: 15.0,
          ),
          polylines: _polylines,
        ),
      ),
    );
  }
}
