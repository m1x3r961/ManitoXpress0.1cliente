import 'package:flutter/material.dart';
import 'package:manitoxpress/Home_services.dart';
import 'package:manitoxpress/Solicitud.dart';
import 'dart:math';
import 'package:manitoxpress/maps.dart';

class ServiceFormPage extends StatefulWidget {
  final ServiceRequest serviceRequest;

  ServiceFormPage({required this.serviceRequest, required String buttonText, required String serviceType});

  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  String? price;
  ServiceRequest myServiceRequest = ServiceRequest(
    id: 1,
    serviceName: 'My Service',
    address: '123 Main St',
    latitude: 12.345,
    longitude: 67.890,
    serviceType: '',
    buttonText: '',
  );
  late ServiceFormPage formPage;

  late bool requireMaterials = false;

  get selectedService => null;

  set selectedDate(DateTime selectedDate) {}

  @override
  Widget build(BuildContext context) {
    var selectedDate;
    var random = Random();

    // Generar nombre y correo electrónico aleatorios
    String randomName = 'Usuario ${random.nextInt(100)}';
    String randomEmail = 'correo${random.nextInt(100)}@example.com';

    // Generar un número aleatorio de 2 a 3 cifras para el precio sugerido
    int minPrice = 200;
    int maxPrice = 400;
    int suggestedPrice = minPrice + random.nextInt(maxPrice - minPrice + 1);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Servicio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 75,
              child: ClipOval(
                child: Image.network(
                  'https://media.giphy.com/media/3RUpczKmWUwRGfPQWB/giphy.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                randomName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                randomEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tipo de servicio: ${widget.serviceRequest.serviceType}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Rango de precio: $minPrice - $maxPrice Bs.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Ingrese el precio del servicio:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Precio',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    price = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Seleccione la fecha y hora del servicio:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (selectedDate != null) {
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                }
              },
              child: Text(selectedDate != null ? selectedDate.toString() : 'Seleccionar fecha'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Detalles del servicio:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Detalles',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    var additionalDetails = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                Text('Acepto los Términos y Condiciones'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Envía el formulario
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica del botón flotante de chat
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.green,
      ),
    );
  }
}
