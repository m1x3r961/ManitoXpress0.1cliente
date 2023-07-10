import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:manitoxpress/maps.dart';
import 'package:manitoxpress/Service_DetailsScreen.dart';


class Service {
  final String title;
  final String imageUrl;
  final String description;
  List<String> buttonTexts;

  Service({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.buttonTexts,
  });
}

class HomeServicesScreen extends StatefulWidget {
  @override
  _HomeServicesScreenState createState() => _HomeServicesScreenState();
}
class _HomeServicesScreenState extends State<HomeServicesScreen> {
  ServiceFormPage formPage = ServiceFormPage(
    serviceRequest: ServiceRequest(
      id: 1,
      serviceName: 'My Service',
      address: '123 Main St',
      latitude: 12.345,
      longitude: 67.890,
      serviceType: 'Some Service Type',
      buttonText: '',
    ),
    buttonText: '',
    serviceType: '',
  );
  late List<Service> services;
  int _selectedServiceIndex = -1;
  String selectedButtonType = '';

  @override
  void initState() {
    super.initState();
    services = [
      Service(
        title: 'Plomero',
        imageUrl: 'https://i.imgur.com/ZDbKahC.jpg',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Refacción de cañerías descubiertas',
          'Refacción de cañerías cubiertas',
          'Instalacion de grifo',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Carpintero',
        imageUrl: 'https://i.imgur.com/ZDbKahC.jpg',
        description:  'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Muebles',
          'Instalacion de puerta',
          'Instalacion de ventanas',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Electricista',
        imageUrl: 'https://i.imgur.com/0Lp7B59.png',
        description:  'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Instalacion por punto',
          'Deteccion de corto circuito',
          'Trabajo general',
          'Personalizado',

        ],
      ),
      // Agrega más servicios con sus preguntas
      Service(
        title: 'Jardinero',
        imageUrl: 'https://i.imgur.com/pC6CMAg.jpg',
        description:  'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Corte general pequeño',
          'Corte general mediano',
          'Corte general grande',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Albañil',
        imageUrl: 'https://i.imgur.com/T2Ye5al.jpg',
        description:  'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Rebocado de pared',
          'sellado de gotera',
          'instalacion de pisos',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Mecánico',
        imageUrl: 'https://i.imgur.com/LxDMZDG.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Auxilio de llanta',
          'Asistencia mecanica',
          'Grua',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Cerrajero',
        imageUrl: 'https://i.imgur.com/Nh9S9ls.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Cambio de chapa',
          'Copia de llave',
          'Otra opción',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Vidriero',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description:  'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Realizacion de vidrios de ventanas',
          'Espejos',
          'Otra opción',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Tecnico A/C',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Reparacion de A/C',
          'Instalacion de A/C',
          'Otra opción',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Cocina',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Chef almuerzo simple',
          'Chef Cena simple',
          'Ayudante por evento',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Limpieza',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Domicilio pequeño',
          'Domicilio mediano',
          'Domicilio grande',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Mudanza',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Cargadores',
          'Transporte',
          'Servicio completo',
          'Personalizado',
        ],
      ),
      Service(
        title: 'Niñera',
        imageUrl: 'https://i.imgur.com/SYiST7l.png',
        description: 'Escoja el tipo de servicio que requiere',
        buttonTexts: [
          'Personalizado',
        ],
      ),
    ];
    // Resto de servicios...

  }

  void toggleDescription(int index) {
    setState(() {
      if (_selectedServiceIndex == index) {
        _selectedServiceIndex = -1;
      } else {
        _selectedServiceIndex = index;
      }
    });
  }

  void openNewPage(String buttonText) {
    var myServiceRequest = ServiceRequest(
      id: 1,
      serviceName: 'My Service',
      address: '123 Main St',
      latitude: 12.345,
      longitude: 67.890,
      serviceType: buttonText,  // Cambio aquí
      buttonText: '',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceFormPage(
          buttonText: buttonText,
          serviceType: buttonText,
          serviceRequest: myServiceRequest,
        ),
      ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios de Hogar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    toggleDescription(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
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
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedServiceIndex != -1)
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      services[_selectedServiceIndex].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      services[_selectedServiceIndex].description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: services[_selectedServiceIndex].buttonTexts.length,
                        itemBuilder: (context, index) {
                          final buttonText = services[_selectedServiceIndex].buttonTexts[index];
                          return GestureDetector(
                            onTap: () {
                              openNewPage(buttonText);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                buttonText,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (selectedButtonType.isNotEmpty)
            Text(
              'Selected Button Type: $selectedButtonType',
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    title: 'Servicios de Hogar',
    home: HomeServicesScreen(),
  ));
}