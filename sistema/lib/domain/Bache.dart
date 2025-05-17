import 'dart:typed_data';

class Bache {
  final int? id_bache;
  final double latitud;
  final double longitud;
  final String direccion;
  //final List<int>? foto; // imagen en bytes
  final Uint8List foto;
  final String estado;

  Bache({
    this.id_bache,
    required this.latitud,
    required this.longitud,
    required this.direccion,
    required this.foto,
    required this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_bache': id_bache,
      'latitud': latitud,
      'longitud': longitud,
      'direccion': direccion,
      'foto': foto,
      'estado': estado,
    };
  }

  @override
  String toString() {
    return 'Bache{id_bache:$id_bache, latitud:$latitud, longitud:$longitud, direccion:$direccion, foto:$foto, estado:$estado}';
  }
}
