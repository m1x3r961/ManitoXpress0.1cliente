import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ServiceRequest {
  final int id;
  final String serviceName;
  final String address;
  final double latitude;
  final double longitude;
  final String serviceType;
  final String buttonText;

  ServiceRequest({
    required this.id,
    required this.serviceName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.serviceType,
    required this.buttonText,
  });
}

class MapScreen extends StatefulWidget {
  final ServiceRequest serviceRequest;

  const MapScreen({required this.serviceRequest});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    final serviceRequest = widget.serviceRequest;
    final location = LatLng(serviceRequest.latitude, serviceRequest.longitude);
    markers.add(
      Marker(
        markerId: MarkerId(serviceRequest.id.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: serviceRequest.serviceName,
          snippet: serviceRequest.address,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceRequest = widget.serviceRequest;
    final location = LatLng(serviceRequest.latitude, serviceRequest.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación de la solicitud'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 15,
        ),
        markers: markers,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}