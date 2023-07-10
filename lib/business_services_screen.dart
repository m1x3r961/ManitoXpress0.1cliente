import 'package:flutter/material.dart';

class BusinessServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Muy Pronto!'),
          content: const Text('Los servicios empresariales estarán disponibles próximamente.'),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar la ventana de alerta
              },
            ),
          ],
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios Empresariales'),
      ),
      body: const Center(
        child: Text('Contenido de los servicios empresariales'),
      ),
    );
  }
}
