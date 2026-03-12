import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/app_role.dart';
import '../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Drawer(
      backgroundColor: Colors.black.withOpacity(0.95),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFD32F2F)),
            accountName: Text(authService.userName, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            accountEmail: Text(authService.currentRole.displayName,
              style: const TextStyle(color: Color(0xFFFFC107))), // Amarelo
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFFD32F2F), size: 40),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildMenuItems(context, authService.currentRole),
            ),
          ),

          // Rodapé do Menu (Botão Login/Sair)
          const Divider(color: Colors.white24),
          authService.isLoggedIn 
            ? ListTile(
                leading: const Icon(Icons.logout, color: Colors.white70),
                title: const Text('Sair', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await authService.signOut();
                },
              )
            : ListTile(
                leading: const Icon(Icons.login, color: Color(0xFFFFC107)),
                title: const Text('Fazer Login', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Fechar drawer
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context, AppRole role) {
    List<Widget> items = [];

    // Todos podem ver
    items.add(_buildItem(Icons.book, 'Bíblia Completa', () {}));
    items.add(_buildItem(Icons.location_on, 'Localização & Horários', () {}));

    if (role == AppRole.visitante) return items;

    // Membro em diante
    items.add(const Divider(color: Colors.white12));
    items.add(_buildItem(Icons.volunteer_activism, 'Pedir Oração', () {}));
    items.add(_buildItem(Icons.calendar_today, 'Minha Escala', () {}));
    items.add(_buildItem(Icons.how_to_reg, 'Check-in Culto', () {}));

    // Líder
    if (role.index <= AppRole.lider.index) {
      items.add(const Divider(color: Colors.white12));
      items.add(_buildItem(Icons.groups, 'Gestão do Ministério', () {}));
    }

    // Mídia
    if (role == AppRole.midia || role.index <= AppRole.adminIgreja.index) {
      items.add(_buildItem(Icons.cloud_upload, 'Upload de Mídia', () {}));
    }

    // Tesouraria
    if (role == AppRole.tesouraria || role.index <= AppRole.adminIgreja.index) {
      items.add(const Divider(color: Colors.white12));
      items.add(_buildItem(Icons.monetization_on, 'Área Financeira', () {}));
    }

    // Admin Igreja
    if (role.index <= AppRole.adminIgreja.index) {
      items.add(_buildItem(Icons.person_add, 'Cadastrar Membro', () {}));
    }

    // Pastor
    if (role.index <= AppRole.pastor.index) {
      items.add(const Divider(color: Colors.white12));
      items.add(_buildItem(Icons.send, 'Enviar Push Inteligente', () {}));
      items.add(_buildItem(Icons.record_voice_over, 'Bom Dia Pastoral', () {}));
    }

    // Super Admin
    if (role == AppRole.superAdmin) {
      items.add(const Divider(color: Colors.white12));
      items.add(_buildItem(Icons.security, 'Painel do Sistema (Super)', () {}));
    }

    return items;
  }

  Widget _buildItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
