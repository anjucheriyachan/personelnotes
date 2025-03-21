import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/repositories/auth_reository.dart';
import 'package:note/shared/routes/app_routes.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'screens/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => FirebaseAuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: context.read<FirebaseAuthRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: const AuthWrapper(),
        ),
      ),
    );
  }
}
