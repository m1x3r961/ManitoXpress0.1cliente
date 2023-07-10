import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manitoxpress/Login.dart';
import 'package:manitoxpress/main.dart';

class ProfessionalServicesScreen extends StatefulWidget {
  @override
  _ProfessionalServicesScreenState createState() => _ProfessionalServicesScreenState();
}

class _ProfessionalServicesScreenState extends State<ProfessionalServicesScreen> {
  final List<Service> services = [
    Service(
      title: 'Servicio 1',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Service(
      title: 'Servicio 2',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Service(
      title: 'Servicio 3',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Service(
      title: 'Servicio 4',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios Profesionales'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen(service: services[index])),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          services[index].imageUrl,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      services[index].title,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
