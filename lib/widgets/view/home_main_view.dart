import 'package:crypto_news/authenticaiton/bloc/authentication_bloc.dart';
import 'package:crypto_news/widgets/view/login_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_news/widgets/view/news_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///stores current user data
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Latest'),
          actions: [
            Row(
              children: [
                ///uses Name of the current user
                Text('${user?.displayName}'),
              ],
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.personWalkingArrowRight,
                color: Colors.red,
                size: 20,
              ),

              ///calls event AuthenticationExited '(logout-event)'
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationExited(),
              ),
            ),
          ],
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailiure) {
              ///checks the state, if its failure-state routes to login page
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginMainView()));
            }
          },
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              ///on initialized state start event AuthenticationStarted
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationStarted());
              return const CircularProgressIndicator(
                color: Colors.orange,
              );
            } else if (state is AuthenticationLoading) {
              ///shows loading indicator until success state
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (state is AuthenticationSuccess) {
              ///if authentication is success, returns News viewing screen
              return const NewsScreen();
            }
            return Text('');
          },
        ),
      ),
    );
  }
}
