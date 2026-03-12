enum AppRole {
  superAdmin('Super Admin'),
  pastor('Pastor'),
  adminIgreja('Admin Igreja'),
  tesouraria('Tesouraria'),
  midia('Mídia'),
  lider('Líder'),
  membro('Membro'),
  visitante('Visitante');

  final String displayName;
  const AppRole(this.displayName);

  static AppRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'super_admin':
      case 'super admin':
        return AppRole.superAdmin;
      case 'pastor':
        return AppRole.pastor;
      case 'admin_igreja':
      case 'admin igreja':
        return AppRole.adminIgreja;
      case 'tesouraria':
        return AppRole.tesouraria;
      case 'midia':
      case 'mídia':
        return AppRole.midia;
      case 'lider':
      case 'líder':
        return AppRole.lider;
      case 'membro':
        return AppRole.membro;
      default:
        return AppRole.visitante;
    }
  }
}
