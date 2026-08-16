import 'package:e_commerce/screens/constant.dart';
import 'package:e_commerce/screens/loginAndRegisterScreen/dart/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../main.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  late FocusNode myFocus;

  static final _fieldDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Constants.primaryColor, width: 2),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  );

  @override
  void initState() {
    super.initState();
    myFocus = FocusNode();
  }

  @override
  void dispose() {
    myFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 210 + topInset,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff69b7cf), Color(0xff3be6bc)])),
              ),
              Container(
                height: 450,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Color(0xff3fedbd),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              cursorColor: Constants.primaryColor,
                              decoration: _fieldDecoration.copyWith(
                                hintText: ' Email ',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              focusNode: myFocus,
                              obscureText: true,
                              cursorColor: Constants.primaryColor,
                              decoration: _fieldDecoration.copyWith(
                                hintText: 'Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                      const Color(0xff3fedbd),
                                    )),
                                    onPressed: () {},
                                    child: const Text(
                                      "Forget Password ?",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                    const Color(0xff3fedbd),
                                  )),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('logged in')),
                                      );
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage()));
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xff3fedbd),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: const Center(
                    heightFactor: 2.9,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
