import 'dart:io';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:manitoxpress/maps.dart';
import 'package:flutter/material.dart';
import 'package:manitoxpress/Login.dart';
import 'package:manitoxpress/Solicitud.dart';
import 'package:sqflite/sqflite.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:day_night_switch/day_night_switch.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rive/rive.dart';
import 'package:manitoxpress/Home_services.dart';
import 'package:manitoxpress/Professional_services.dart';
import 'package:manitoxpress/business_services_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ManitoXpress',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.grey,
          background: Colors.white,
          onBackground: Colors.grey,
        ),
      ),
      home: isLoading ? LoadingScreen() : HomeScreen(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.network('https://i.imgur.com/RgJ6Im5.png'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.phonelink_ring),
        title: 'Servicio',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.explore),
        title: 'Mapa',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle_outlined),
        title: 'Solicitudes',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black38,
      ),
    ];
  }

  ServiceRequest myServiceRequest = ServiceRequest(
    id: 1,
    serviceName: '',
    address: '',
    latitude: 12.345,
    longitude: 67.890,
    serviceType: 'plomeria', buttonText: '',
  );

  List<Widget> _buildScreens() {
    return [
      ServiceScreen(),
      MapScreen(serviceRequest: myServiceRequest),
      CartScreen(serviceRequests: [],),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.network('https://i.imgur.com/RgJ6Im5.png',
                width: 34,
                height: 34,
              ),
            ),
            const SizedBox(width: 8), // Espacio entre el logo y el título
            Text(
              'ManitoXpress',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'RobotoMono',
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    child: Image.network("https://i.imgur.com/RgJ6Im5.png"),
                    margin: const EdgeInsets.only(top: 70, bottom: 40),
                  ),
                  const Text(
                    "a necesidades drasticas, soluciones rapidas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text("Perfil"),
              ),
              const SizedBox(height: 3.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen(serviceRequests: [],)),
                  );
                },
                icon: const Icon(Icons.trending_up),
                label: const Text("Solicitudes"),
              ),
              const SizedBox(height: 3.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReferralScreen(
                          referralCode: '12345',
                        )),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text("Referidos"),
              ),
              const SizedBox(height: 3.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                },
                icon: const Icon(Icons.help),
                label: const Text("Ayuda"),
              ),
              const SizedBox(height: 3.0),
              ElevatedButton.icon(
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "ManitoXpress",
                    applicationVersion: "1.0.0",
                    applicationIcon: Image.asset(
                      'assets/images/manitoxpress_logo.png',
                      width: 10,
                      height: 10,
                    ),
                    children: const [
                      Text("Esta es una aplicación Demo"),
                    ],
                  );
                },
                icon: const Icon(Icons.info),
                label: const Text("Licencia"),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.grey,
                child: const Center(
                  child: Text(
                    'Espacio de Publicidad',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: PersistentTabController(initialIndex: _currentIndex),
        screens: _buildScreens(),
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.green,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}

class RankingScreen extends StatelessWidget {
  final List<User> users = generateRandomUsers(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Text(users[index].name[0]),
                    ),
                    const SizedBox(width: 2),
                    Text(users[index].name),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 2),
                    Text(users[index].rating.toString()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static List<User> generateRandomUsers(int count) {
    final List<User> users = [];

    for (int i = 0; i < count; i++) {
      final name = getRandomName();
      final rating = Random().nextInt(6); // Generates a random rating from 0 to 5

    }

    return users;
  }

  static String getRandomName() {
    // Generate random names or use a list of predefined names
    // Here's an example using predefined names
    final List<String> names = [
      'John',
      'Jane',
      'Michael',
      'Emma',
      'David',
      'Sarah',
      'Daniel',
      'Olivia',
      'Christopher',
      'Sophia',
    ];

    final random = Random();
    final index = random.nextInt(names.length);

    return names[index];
  }
}
class ReferralScreen extends StatelessWidget {
  final String referralCode; // Código de referido del usuario

  ReferralScreen({required this.referralCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Gana puntos invitando a tus amigos!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tu código de referido:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              referralCode,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                _compartirEnlaceReferido(referralCode, SharePlatform.Whatsapp);
              },
              icon: const FaIcon(FontAwesomeIcons.whatsapp),
              iconSize: 48,
            ),
            IconButton(
              onPressed: () {
                _compartirEnlaceReferido(referralCode, SharePlatform.Facebook);
              },
              icon: const FaIcon(FontAwesomeIcons.facebook),
              iconSize: 48,
            ),
            IconButton(
              onPressed: () {
                _compartirEnlaceReferido(referralCode, SharePlatform.Twitter);
              },
              icon: const FaIcon(FontAwesomeIcons.twitter),
              iconSize: 48,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.grey, // Color de fondo del "Sector Publicidad"
        child: const Center(
          child: Text(
            'Sector Publicidad',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _compartirEnlaceReferido(String referralCode, SharePlatform platform) {
    // Lógica para compartir el enlace de referido
  }
}

enum SharePlatform {
  Whatsapp,
  Facebook,
  Twitter,
}
void _shareReferralLink(String referralCode) {
  // Lógica para compartir el enlace de referido
  // Aquí puedes implementar la funcionalidad para compartir el código de referido con amigos a través de diferentes canales (mensajes, redes sociales, etc.)
}

class RaisedButton {
}
class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}
class _HelpScreenState extends State<HelpScreen> {
  final List<Faq> faqs = [
    Faq(
      question: '¿Cómo funciona la aplicación?',
      answer:
      'La aplicación te permite solicitar servicios de mano de obra a través de una plataforma en línea. Simplemente regístrate, explora los servicios disponibles y elige el que necesites. Luego, selecciona un proveedor de servicios y coordina los detalles con ellos.',
    ),
    Faq(
      question: '¿Qué tipos de servicios de mano de obra se ofrecen en la aplicación?',
      answer:
      'Nuestra aplicación ofrece una amplia gama de servicios de mano de obra, que incluyen plomería, electricidad, carpintería, pintura, jardinería, limpieza, reparaciones domésticas, instalaciones y muchos otros. ¡Estamos aquí para ayudarte con tus necesidades de mano de obra!',
    ),
    Faq(
      question: '¿Cómo elijo al proveedor de servicios adecuado?',
      answer:
      'Nuestra aplicación te muestra perfiles detallados de los proveedores de servicios, que incluyen información sobre su experiencia, calificaciones y reseñas de clientes anteriores. Puedes comparar y elegir al proveedor de servicios que mejor se adapte a tus necesidades y presupuesto.',
    ),
    Faq(
      question: '¿Cómo se calcula el costo de los servicios?',
      answer:
      'El costo de los servicios de mano de obra puede variar según la naturaleza del trabajo, la ubicación y otros factores. Los proveedores de servicios establecen sus propias tarifas, y podrás verlas en sus perfiles. Algunos proveedores también pueden ofrecer cotizaciones personalizadas para proyectos específicos.',
    ),
    Faq(
      question: '¿Cómo se coordina la fecha y hora del servicio?',
      answer:
      'Una vez que hayas seleccionado a un proveedor de servicios, podrás comunicarte directamente con ellos a través de la aplicación para coordinar la fecha y hora que te convenga. Podrás discutir los detalles y acordar una cita conveniente para ambas partes.',
    ),
    Faq(
      question: '¿Cómo puedo pagar por los servicios?',
      answer:
      'Actualmente, ofrecemos opciones de pago en línea a través de tarjetas de crédito o débito. Algunos proveedores también pueden aceptar pagos en efectivo, pero eso deberá ser acordado directamente con el proveedor de servicios.',
    ),
    Faq(
      question: '¿Qué debo hacer en caso de que haya un problema con el servicio?',
      answer:
      'Si encuentras algún problema con el servicio recibido, te recomendamos comunicarte directamente con el proveedor de servicios para resolver el problema. También puedes contactar a nuestro equipo de soporte, y estaremos encantados de ayudarte a encontrar una solución satisfactoria.',
    ),
  ];
  TextEditingController _textEditingController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _showClearButton = _textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _clearSearchText() {
    setState(() {
      _textEditingController.clear();
      _showClearButton = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarAnimation(
              buttonWidget: const Icon(Icons.search),
              secondaryButtonWidget: _showClearButton
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearSearchText,
              )
                  : Container(), // Envuelve el IconButton en un Container vacío
              trailingWidget: Container(), // Agrega el trailingWidget según tus necesidades
              onChanged: (String value) {
                // Acción a realizar al buscar
              },
              isOriginalAnimation: true,
              textEditingController: _textEditingController,
            ),
          ),
          // Resto del código
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(faqs[index].question),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faqs[index].answer),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Soporte Técnico'),
            onPressed: () {
              // Acción para el botón de soporte técnico
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Faq {
  final String question;
  final String answer;

  Faq({required this.question, required this.answer});
}



class UserProfileScreen extends StatelessWidget {
  final Service service;

  const UserProfileScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              service.imageUrl,
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 16),
            Text(
              service.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Aquí puedes agregar más información del perfil del usuario relacionado con el servicio
          ],
        ),
      ),
    );
  }
}


class Service {
  final String title;
  final String imageUrl;

  Service({required this.title, required this.imageUrl});
}
class User {
  final List<String> history;
  final String name;
  final String imageUrl;
  final double rating;
  final String serviceType;



  User(this.history, {
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.serviceType,
  });
}







class ServiceScreen extends StatelessWidget {
  final List<Service> services = [
    Service(title: 'Servicios de Hogar', imageUrl: 'https://i.imgur.com/PZYBjTs.jpg'),
    Service(title: 'Servicios Profesionales', imageUrl: 'https://i.imgur.com/gkgD6Wq.jpg'),
    Service(title: 'Servicio Empresariales', imageUrl: 'https://i.imgur.com/Wcu2dUn.jpg'),
  ];

  void navigateToServiceDetails(BuildContext context, int index) {
    // Lógica para navegar a los detalles del servicio seleccionado
    // Puedes implementar tu propia navegación o utilizar el enrutamiento de Flutter
  }

  void navigateToHomeServices(BuildContext context) {
    // Navegar a la página de servicios de hogar
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeServicesScreen()),
    );
  }

  void navigateToProfessionalServices(BuildContext context) {
    // Navegar a la página de servicios profesionales
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfessionalServicesScreen()),
    );
  }

  void navigateToBusinessServices(BuildContext context) {
    // Mostrar ventana de alerta
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Muy Pronto!'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: services.length,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 5.0), // Espacio de 2 píxeles
              GestureDetector(
                onTap: () {
                  switch (index) {
                    case 0:
                      navigateToHomeServices(context);
                      break;
                    case 1:
                      navigateToProfessionalServices(context);
                      break;
                    case 2:
                      navigateToBusinessServices(context);
                      break;
                  }
                },
                child: Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
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
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        services[index].title,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2.0), // Espacio de 2 píxeles
            ],
          );
        },
      ),
    );
  }
}
