import 'package:flutter/material.dart';
import 'package:manitoxpress/MapS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartScreen extends StatelessWidget {
  final List<ServiceRequest> serviceRequests;

  const CartScreen({required this.serviceRequests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitudes de Servicios'),
      ),
      body: ListView.builder(
        itemCount: serviceRequests.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(serviceRequests[index].serviceName),
            subtitle: Text(serviceRequests[index].address),
            onTap: () {
              _navigateToMap(context, serviceRequests[index]);
            },
          );
        },
      ),
    );
  }

  void _navigateToMap(BuildContext context, ServiceRequest serviceRequest) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(serviceRequest: serviceRequest),
      ),
    );
  }

  void ServiceDetailsScreen() {
    // Lógica para recibir la llamada
    // Puedes implementar aquí el código para manejar la llamada recibida
    print('Llamada recibida desde otra clase');
  }
}