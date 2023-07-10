import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manitoxpress/main.dart';
import 'package:rive/rive.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';
import 'package:manitoxpress/Register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginScreen> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;
  void _navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/animations/login.riv'
        : 'animations/login.riv';
    rootBundle.load(animationURL).then(
          (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          stateMachineController!.inputs.forEach((e) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          });

          stateMachineController!.inputs.forEach((element) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          });
        }

        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  void login() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (_emailController.text == "m1x3r" && _passwordController.text == "1234") {
      successTrigger?.fire();
      _navigateToProfilePage(); // Redirige al perfil si la autenticación es exitosa
    } else {
      failTrigger?.fire();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Inicio de sesión fallido"),
            content: Text("Email o contraseña incorrectos. Inténtalo de nuevo."),
            actions: [
              TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_teddyArtboard != null)
              SizedBox(
                width: 400,
                height: 300,
                child: Rive(
                  artboard: _teddyArtboard!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            Container(
              alignment: Alignment.center,
              width: 400,
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(bottom: 15 * 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 15 * 2),
                        TextField(
                          controller: _emailController,
                          onTap: lookOnTheTextField,
                          onChanged: moveEyeBalls,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: const Color(0xffb04863),
                          decoration: const InputDecoration(
                            hintText: "Email/Username",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            focusColor: Color(0xffb04863),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffb04863),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          onTap: handsOnTheEyes,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: const Color(0xffb04863),
                          decoration: const InputDecoration(
                            hintText: "Password",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            focusColor: Color(0xffb04863),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffb04863),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //remember me checkbox
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                                const Text("Recuerdame"),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff13fcc3),
                                  ),
                                  child: const Text("INGRESAR"),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text("Registrarse"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: _buildProfileInfo(),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(
                'https://media.giphy.com/media/3RUpczKmWUwRGfPQWB/giphy.gif'),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 24),
              Icon(Icons.star, color: Colors.yellow, size: 24),
              Icon(Icons.star, color: Colors.yellow, size: 24),
              Icon(Icons.star, color: Colors.yellow, size: 24),
              Icon(Icons.star_half, color: Colors.yellow, size: 24),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Pelon Gonzales',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Plomero',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(10.0),
              child: const SingleChildScrollView(
                child: Text(
                  'Experiencia\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod tincidunt semper. Nunc facilisis cursus lobortis.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}