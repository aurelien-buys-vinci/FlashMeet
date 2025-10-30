import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  AuthViewModel(this._authService) {
    _checkAuthStatus();
  }

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  // Vérifier si l'utilisateur est déjà connecté au démarrage
  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isLoggedIn = await _authService.isLoggedIn();

      if (isLoggedIn) {
        _currentUser = await _authService.getUser();
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _currentUser = null;
      }
    } catch (e) {
      _errorMessage = 'Erreur lors de la vérification de l\'authentification';
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // LOGIN - Connexion
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.login(
        email: email,
        password: password,
      );

      if (success) {
        _currentUser = await _authService.getUser();
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _errorMessage = 'Email ou mot de passe incorrect';
        _isAuthenticated = false;
      }

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = 'Erreur lors de la connexion: $e';
      _isLoading = false;
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  // REGISTER - Inscription
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      if (success) {
        _currentUser = await _authService.getUser();
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _errorMessage = 'Cet email est déjà utilisé';
        _isAuthenticated = false;
      }

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = 'Erreur lors de l\'inscription: $e';
      _isLoading = false;
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  // LOGOUT - Déconnexion
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _currentUser = null;
      _isAuthenticated = false;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erreur lors de la déconnexion';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // REFRESH TOKEN - Rafraîchir le token d'accès
  Future<bool> refreshToken() async {
    try {
      final success = await _authService.refreshAccessToken();

      if (!success) {
        // Le refresh a échoué, déconnecter l'utilisateur
        await logout();
      }

      return success;
    } catch (e) {
      _errorMessage = 'Erreur lors du rafraîchissement du token';
      await logout();
      return false;
    }
  }

  // Vérifier si le token est expiré et le rafraîchir si nécessaire
  Future<bool> ensureValidToken() async {
    final isExpired = await _authService.isTokenExpired();

    if (isExpired) {
      return await refreshToken();
    }

    return true;
  }

  // Réinitialiser le message d'erreur
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Recharger les données de l'utilisateur
  Future<void> reloadUser() async {
    try {
      _currentUser = await _authService.getUser();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors du rechargement des données utilisateur';
      notifyListeners();
    }
  }
}

