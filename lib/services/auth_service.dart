import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_role.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? _user;
  AppRole _currentRole = AppRole.visitante;
  String _userName = 'Visitante';

  User? get user => _user;
  AppRole get currentRole => _currentRole;
  String get userName => _userName;

  bool get isLoggedIn => _user != null;

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    _user = _supabase.auth.currentUser;
    if (_user != null) {
      await _fetchProfileData();
    }
    
    // Escutar mudanças no estado de autenticação
    _supabase.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      
      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.tokenRefreshed) {
        _user = session?.user;
        await _fetchProfileData();
      } else if (event == AuthChangeEvent.signedOut) {
        _user = null;
        _currentRole = AppRole.visitante;
        _userName = 'Visitante';
        notifyListeners();
      }
    });
  }

  Future<void> _fetchProfileData() async {
    if (_user == null) return;

    try {
      final response = await _supabase
          .from('profiles')
          .select('full_name, role')
          .eq('id', _user!.id)
          .maybeSingle();

      if (response != null) {
        _userName = response['full_name'] ?? 'Usuário';
        _currentRole = AppRole.fromString(response['role'] ?? 'visitante');
      }
    } catch (e) {
      debugPrint('Erro ao buscar perfil: \$e');
      _currentRole = AppRole.membro; // Fallback se falhar
    }
    notifyListeners();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      debugPrint('Erro no login: \$e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
