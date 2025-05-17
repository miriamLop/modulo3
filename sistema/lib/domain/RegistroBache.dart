class RegistroBache {
  final int? id_registro;
  final int id_bache;
  final int id_usuario;
  final String fecha;
  final String seguimiento;

  RegistroBache({
    this.id_registro,
    required this.id_bache,
    required this.id_usuario,
    required this.fecha,
    required this.seguimiento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_registro': id_registro,
      'id_bache': id_bache,
      'id_usuario': id_usuario,
      'fecha': fecha,
      'seguimiento': seguimiento,
    };
  }
}
