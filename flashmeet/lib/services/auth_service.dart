import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  // Clés de stockage
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user';
  static const String _tokenExpiryKey = 'token_expiry';

  // DONNÉES HARDCODÉES POUR LES TESTS (à remplacer par l'API plus tard)
  static const String _mockAccessToken = 'mock_access_token_123456789';
  static const String _mockRefreshToken = 'mock_refresh_token_987654321';

  // Base de données mock d'utilisateurs
  static final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'email': 'test@flashmeet.com',
      'password': 'password123',
      'first_name': 'John',
      'last_name': 'Doe',
      'phone_number': '+33612345678',
    },
    {
      'id': '2',
      'email': 'marie@flashmeet.com',
      'password': 'marie123',
      'first_name': 'Marie',
      'last_name': 'Dupont',
      'phone_number': '+33698765432',
    },
  ];

  // LOGIN - Connexion avec email et mot de passe
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 1));

    // Chercher l'utilisateur dans la base mock
    final mockUser = _mockUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (mockUser.isEmpty) {
      // Utilisateur non trouvé ou mauvais mot de passe
      return false;
    }

    // Créer l'objet User
    final user = User(
      id: mockUser['id'],
      firstName: mockUser['first_name'],
      lastName: mockUser['last_name'],
      email: mockUser['email'],
      phoneNumber: mockUser['phone_number'],
    );

    // Sauvegarder les tokens (valides pour 24h)
    await saveTokens(
      accessToken: _mockAccessToken,
      refreshToken: _mockRefreshToken,
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
    );

    // Sauvegarder l'utilisateur
    await setUser(user);

    return true;
  }

  // REGISTER - Inscription d'un nouvel utilisateur
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 1));

    // Vérifier si l'email existe déjà
    final emailExists = _mockUsers.any((user) => user['email'] == email);
    if (emailExists) {
      // Email déjà utilisé
      return false;
    }

    // Créer un nouvel utilisateur (dans la vraie app, l'API générera l'id)
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID temporaire
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );

    // Ajouter à la liste mock (en mémoire uniquement pour cette session)
    _mockUsers.add({
      'id': newUser.id,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    });

    // Sauvegarder les tokens
    await saveTokens(
      accessToken: _mockAccessToken,
      refreshToken: _mockRefreshToken,
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
    );

    // Sauvegarder l'utilisateur
    await setUser(newUser);

    return true;
  }

  // REFRESH - Rafraîchir le token d'accès avec le refresh token
  Future<bool> refreshAccessToken() async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    final refreshToken = await getRefreshToken();

    if (refreshToken == null) {
      // Pas de refresh token, l'utilisateur doit se reconnecter
      return false;
    }

    // Dans une vraie app, on enverrait le refresh token à l'API
    // Pour le mock, on génère juste un nouveau token
    await saveTokens(
      accessToken: '${_mockAccessToken}_refreshed_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: refreshToken, // Le refresh token reste le même
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
    );

    return true;
  }

  // Sauvegarder les tokens d'authentification
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiryDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_tokenExpiryKey, expiryDate.toIso8601String());
  }

  // Récupérer l'access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Récupérer le refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Vérifier si le token est expiré
  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString(_tokenExpiryKey);

    if (expiryString == null) return true;

    final expiryDate = DateTime.parse(expiryString);
    return DateTime.now().isAfter(expiryDate);
  }

  // Sauvegarder l'utilisateur
  Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  // Récupérer l'utilisateur
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);

    if (userString == null) return null;

    final userJson = jsonDecode(userString) as Map<String, dynamic>;
    return User.fromJson(userJson);
  }

  // Vérifier si l'utilisateur est connecté
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final user = await getUser();
    final tokenExpired = await isTokenExpired();

    return accessToken != null && user != null && !tokenExpired;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userKey);
    await prefs.remove(_tokenExpiryKey);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}