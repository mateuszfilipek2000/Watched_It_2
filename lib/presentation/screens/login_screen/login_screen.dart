import 'package:flutter/material.dart';

/*
  All devices share the same login screen ui
*/
class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late AnimationController _backgroundAnimationController;
  late Animation<double> _backgroundOpacityAnimation;
  // late Animation<Offset> _backgroundPositionAnimation;

  @override
  void initState() {
    // instantiating controllers
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _backgroundAnimationController = AnimationController(vsync: this);

    // background animation is controlling background opacity animation
    _backgroundOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundAnimationController,
        curve: Curves.easeIn,
      ),
    );
    //background position animation is responsible for a simple 'parallax' effect

    //TODO CREATE BACKGROUND POSITION ANIMATION

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
