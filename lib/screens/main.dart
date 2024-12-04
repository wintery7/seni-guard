import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  List<RouteInfo> _routes = [];
  int _selectedRouteIndex = 0;

  // 산책 경로 옵션 - 이곡역 방향 코스
  final List<LatLng> _destinations = [
    LatLng(35.8570, 128.5000),  // 달구벌대로 시작점
    LatLng(35.8540, 128.5040),  // 달구벌대로 중간
    LatLng(35.8510, 128.5080),  // 이곡역
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(35.85545507671219, 128.4925301902473),  // 계명대 동문
          infoWindow: const InfoWindow(title: '계명대학교 동문'),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _loadAllRoutes();
    
    // 지도 초기 위치 설정
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(35.85545507671219, 128.4925301902473),  // 계명대 동문 위치
        15.0,
      ),
    );
  }

  Future<void> _loadAllRoutes() async {
    _routes.clear();
    _polylines.clear();

    for (int i = 0; i < _destinations.length; i++) {
      await _getRoute(_destinations[i], i);
    }
  }

  Future<void> _getRoute(LatLng destination, int index) async {
    try {
      List<LatLng> points;
      String distance;
      String duration;
      String routeName;

      switch(index) {
        case 0:  // 첫 번째 경로 - 달구벌대로 직진 코스
          points = [
            LatLng(35.85545507671219, 128.4925301902473),  // 동문
            LatLng(35.8545, 128.4940),  // 달구벌대로 진입
            LatLng(35.8535, 128.4960),  // 달구벌대로 1
            LatLng(35.8525, 128.4980),  // 달구벌대로 2
            LatLng(35.8515, 128.5020),  // 달구벌대로 3
            LatLng(35.8510, 128.5080),  // 이곡역
          ];
          distance = '약 2.0km';
          duration = '도보 25분';
          routeName = '달구벌대로 직진 코스';
          break;

        case 1:  // 두 번째 경로 - 주택가 경유 코스
          points = [
            LatLng(35.85545507671219, 128.4925301902473),  // 동문
            LatLng(35.8540, 128.4930),  // 주택가 진입
            LatLng(35.8530, 128.4950),  // 주택가 1
            LatLng(35.8520, 128.4970),  // 주택가 2
            LatLng(35.8515, 128.5000),  // 주택가 3
            LatLng(35.8510, 128.5040),  // 달구벌대로 합류
            LatLng(35.8510, 128.5080),  // 이곡역
          ];
          distance = '약 2.2km';
          duration = '도보 30분';
          routeName = '주택가 경유 코스';
          break;

        case 2:  // 세 번째 경로 - 공원 경유 코스
          points = [
            LatLng(35.85545507671219, 128.4925301902473),  // 동문
            LatLng(35.8550, 128.4950),  // 공원 방향
            LatLng(35.8540, 128.4970),  // 공원 1
            LatLng(35.8530, 128.5000),  // 공원 2
            LatLng(35.8520, 128.5030),  // 공원 3
            LatLng(35.8515, 128.5060),  // 달구벌대로 합류
            LatLng(35.8510, 128.5080),  // 이곡역
          ];
          distance = '약 2.3km';
          duration = '도보 32분';
          routeName = '공원 경유 코스';
          break;

        default:
          return;
      }

      setState(() {
        _routes.add(RouteInfo(
          points: points,
          distance: distance,
          duration: duration,
          routeName: routeName,
          index: index,
        ));

        _polylines.add(Polyline(
          polylineId: PolylineId('route_$index'),
          visible: true,
          points: points,
          color: _getRouteColor(index),
          width: 4,
        ));

        _markers.add(Marker(
          markerId: MarkerId('destination_$index'),
          position: destination,
          infoWindow: InfoWindow(
            title: routeName,
            snippet: '거리: $distance, 시간: $duration',
          ),
        ));
      });
    } catch (e) {
      print('Error creating route: $e');
    }
  }

  Color _getRouteColor(int index) {
    final colors = [Colors.blue, Colors.red, Colors.green];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('산책 경로 추천'),
          backgroundColor: const Color.fromARGB(255, 114, 243, 232),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(35.85545507671219, 128.4925301902473),
                zoom: 15.0,
              ),
              polylines: {
                if (_routes.isNotEmpty) _polylines.elementAt(_selectedRouteIndex)
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedRouteIndex = 0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedRouteIndex == 0 ? Colors.blue : Colors.grey,
                      ),
                      child: Text('경로 1'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedRouteIndex = 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedRouteIndex == 1 ? Colors.red : Colors.grey,
                      ),
                      child: Text('경로 2'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedRouteIndex = 2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedRouteIndex == 2 ? Colors.green : Colors.grey,
                      ),
                      child: Text('경로 3'),
                    ),
                  ],
                ),
              ),
            ),
            if (_routes.isNotEmpty)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _routes[_selectedRouteIndex].routeName,  // 경로 이름 표시
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('거리: ${_routes[_selectedRouteIndex].distance}'),
                      Text('예상 시간: ${_routes[_selectedRouteIndex].duration}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RouteInfo {
  final List<LatLng> points;
  final String distance;
  final String duration;
  final String routeName;
  final int index;

  RouteInfo({
    required this.points,
    required this.distance,
    required this.duration,
    required this.routeName,
    required this.index,
  });
}
