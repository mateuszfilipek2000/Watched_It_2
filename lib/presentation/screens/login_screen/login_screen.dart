import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_events.dart';
import 'package:watched_it_2/presentation/blocs/authentication_bloc/authentication_state.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/dashboard_screen.dart';

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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: context.read<AuthenticationBloc>()
          ..add(const AuthenticationEventInitialize()),
        listener: (context, state) {
          // if (state is AuthenticationStateInitial) {
          //   context.read<AuthenticationBloc>().add(
          //         const AuthenticationEventInitialize(),
          //       );
          // } else
          if (state is AuthenticationStateLoggedIn) {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          } else if (state is AuthenticationStateLoginFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.exception.toString()),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            );
          } else if (state is AuthenticationStateWaitingForConfirmation) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                      "Tap the ok button after you've approved of request token!"),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationEventConfirmDialog());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: TextButton(
                  child: const Text("Log in"),
                  onPressed: () => context.read<AuthenticationBloc>().add(
                        const AuthenticationEventLogIn(
                          username: "",
                          password: "",
                        ),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
