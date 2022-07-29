import 'package:crypto_news/authenticaiton/bloc/authentication_bloc.dart';
import 'package:crypto_news/widgets/view/home_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_news/news/data/news_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginMainView extends StatelessWidget {
  const LoginMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                ///listen for states
                if (state is AuthenticationSuccess) {
                  ///if state is success state, route to Home screen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        ///
                        builder: (context) => MultiRepositoryProvider(
                          providers: [
                            RepositoryProvider(
                              create: (context) => NewsService(),
                            ),
                          ],
                          child: const HomeMainView(),
                        ),
                      ));

                  ///if its in failure state, shows error message in snackbar
                } else if (state is AuthenticationFailiure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },

              ///check for state, build again only when the state is false
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                ///if state is initial or failure, builds widget
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailiure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///asset image
                        const CircleAvatar(
                          radius: 90,
                          backgroundImage:
                              AssetImage('asset/images/unnamed-modified.png'),
                        ),
                        const SizedBox(height: 30),

                        ///login button
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(
                                width: 1.0, color: Colors.orange),
                          ),
                          onPressed: () =>

                              ///load AuthenticationGoogleStarted event
                              BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationGoogleStarted(),
                          ),
                          icon: const FaIcon(FontAwesomeIcons.googlePlusG),
                          label: const Text('Login with Google'),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  ///if state is AuthenticationLoading shows loading circle
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  ));
                }
                return Center(
                    child: Text('Undefined state : ${state.runtimeType}'));
              },
            );
          },
        ),
      ),
    );
  }
}
