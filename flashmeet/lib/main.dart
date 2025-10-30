import 'package:flashmeet/services/auth_service.dart';
import 'package:flashmeet/view_models/auth_view_model.dart';
import 'package:flashmeet/views/screens/home_screen.dart';
import 'package:flashmeet/views/screens/login_screen.dart';
import 'package:flashmeet/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService authService = AuthService();

  runApp(
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(authService),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FlashMeet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: '/',
        redirect: (context, state) async {
          // Attendre que le check d'auth soit terminé
          if (authViewModel.isLoading) {
            return null; // On laisse passer pendant le chargement
          }

          final isAuthenticated = authViewModel.isAuthenticated;
          final isGoingToLogin = state.matchedLocation == '/';
          final isGoingToRegister = state.matchedLocation == '/register';

          // Si l'utilisateur n'est pas connecté et n'est pas déjà sur login/register
          if (!isAuthenticated && !isGoingToLogin && !isGoingToRegister) {
            return '/';
          }

          // Si l'utilisateur est connecté et essaie d'aller sur login/register
          if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
            return '/home';
          }

          return null; // Pas de redirection
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),
    );
  }
}

