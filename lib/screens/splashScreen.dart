import 'package:flutter/material.dart';

import 'loginAndRegisterScreen/dart/Login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadedAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);

    fadedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
    navigateToHome();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff69b7cf), Color(0xff3be6bc)])),
        child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              return Center(
                child: FadeTransition(
                    opacity: fadedAnimation,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 150,
                    )),
              );
            }));
  }
}
