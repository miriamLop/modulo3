// ignore: file_names
class Usuario {
  final int? id_usuario;
  final String paterno;
  final String materno;
  final String nombre;
  final int nro_celular;
  final int cedula;
  final String usuario;
  final String password;

  Usuario({
    this.id_usuario,
    required this.paterno,
    required this.materno,
    required this.nombre,
    required this.nro_celular,
    required this.cedula,
    required this.usuario,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': id_usuario,
      'paterno': paterno,
      'materno': materno,
      'nombre': nombre,
      'nro_celular': nro_celular,
      'cedula': cedula,
      'usuario': usuario,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Usuario{id_usuario:$id_usuario, paterno:$paterno, materno:$materno, nombre:$nombre,nro_celular:$nro_celular, cedula:$cedula, usuario:$usuario, password:$password}';
  }
}
