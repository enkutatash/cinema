import 'package:cinema/features/auth/domain/usecase/login_usecase.dart';
import 'package:cinema/features/auth/domain/usecase/register_usecase.dart';
import 'package:cinema/features/auth/presentation/auth_page/login_page.dart';
import 'package:cinema/features/auth/presentation/auth_page/register_page.dart';
import 'package:cinema/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cinema/features/movie/presentaion/pages/buy_tickets_page.dart';
import 'package:cinema/features/movie/presentaion/pages/movie_detail_page.dart';
import 'package:cinema/features/movie/presentaion/pages/movie_display_page.dart';
import 'package:cinema/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              registerUsecase: locator<RegisterUsecase>(),
              loginUsecase: locator<LoginUsecase>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/buyticket',
          routes: {
            // '/': (context) => SplashScreen(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            '/displaymovie':(context)=>MovieDisplayPage(),
            '/detailmovie':(context)=>MovieDetailPage(),
            '/buyticket':(context)=>BuyTicketsPage(),
            '/home': (context) => Home(
                  loginUsecase: locator<LoginUsecase>(),
                )
          },
        ));
  }
}

// ignore: must_be_immutable
class Home extends StatelessWidget {
  LoginUsecase loginUsecase;

  Home({required this.loginUsecase, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                var result = await loginUsecase.execute(
                    "enkutatash@gmail.com", "enkuenku");
                result.fold(
                  (failure) {
                    print("Login failed: ${failure.message}");
                  },
                  (entity) {
                    print("User logged in successfully: $entity");
                  },
                );
              },
              child: Text("Click me")),
        ),
      ),
    );
  }
}
