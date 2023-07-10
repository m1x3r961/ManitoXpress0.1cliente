import 'package:flutter/material.dart';
import 'package:manitoxpress/Login.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      appBar: AppBar(
        title: Text('Register'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: const FlareActor(
              "images/background_flow.flr",
              animation: "Flow",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: const EdgeInsets.only(bottom: 15),
                    margin: const EdgeInsets.only(bottom: 15 * 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Email",
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
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Phone",
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
                            controller: _usernameController,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Username",
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
                          ElevatedButton(
                            onPressed: () {
                              // Acción del botón de registro
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff13fcc3),
                            ),
                            child: const Text("Registrarme"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
