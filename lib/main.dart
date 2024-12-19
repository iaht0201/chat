import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:text_to_speech/config/supbase_service.dart';
import 'package:text_to_speech/src/login/authen_screen.dart';
import 'package:text_to_speech/src/login/blog/login_bloc.dart';
import 'package:text_to_speech/src/login/repository.dart';
import 'package:text_to_speech/src/login/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load dotenv
  await dotenv.load(fileName: ".env");
  SupbaseConfig().initSupabase(
      dotenv.env['SUPABASE_URL'].toString(), dotenv.env['SUPABASE_CLIENT_API_KEY'].toString());
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthService>(create: (_) => AuthService(SupbaseConfig.client!)),
      RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepository(authService: context.read<AuthService>()),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(context.read<AuthRepository>()),
        ),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
