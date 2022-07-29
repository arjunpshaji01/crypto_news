import 'package:crypto_news/authenticaiton/bloc/authentication_bloc.dart';
import 'package:crypto_news/authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'package:crypto_news/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:crypto_news/authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'package:crypto_news/widgets/view/home_main_view.dart';
import 'package:crypto_news/news/data/news_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  ///fire base initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///using Bloc provider on root
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationFirebaseProvider: AuthenticationFirebaseProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
          googleSignInProvider: GoogleSignInProvider(
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CryptoN',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: const ColorScheme.dark(),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
            )),

        ///
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => NewsService(),
            ),
            // RepositoryProvider(create: (context)=>DeleteReminderService())
          ],
          child: const HomeMainView(),
        ),
      ),
    );
  }
}
// HomeMainView()
