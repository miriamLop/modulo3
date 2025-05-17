import 'dart:typed_data';

import 'package:sistema/domain/Bache.dart';
import 'package:sistema/domain/BacheRegistroBache.dart';
import 'package:sistema/domain/RegistroBache.dart';

import 'package:sistema/domain/Usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'baches.db'),
      onCreate: (database, version) {
        database.execute(
          "CREATE TABLE bache( id_bache  INTEGER PRIMARY KEY AUTOINCREMENT not null,   latitud   REAL,   longitud  REAL,   direccion TEXT,   foto    longblob,   estado  TEXT) ",
        );
        database.execute(
          "CREATE TABLE usuario(   id_usuario  INTEGER PRIMARY KEY AUTOINCREMENT not null,   paterno TEXT, materno TEXT, nombre TEXT, nro_celular INTEGER, cedula INTEGER, usuario TEXT, password TEXT)",
        );
        database.execute(
          "CREATE TABLE registro_bache(id_registro INTEGER PRIMARY KEY AUTOINCREMENT not null, id_bache    INTEGER not null, id_usuario  INTEGER not null, fecha TEXT, seguimiento TEXT, FOREIGN KEY (id_bache) REFERENCES bache (id_bache), FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario))",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUsuario(Usuario usuario) async {
    Database database = await _openDB();

    database.insert("usuario", usuario.toMap());
    print(" Datos registrados");
  }

  static Future<List<Usuario>> usuario() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> usuarioMap = await database.query(
      'usuario',
    );

    for (var n in usuarioMap) {
      //print("____" + n['id_usuario']);
      print("____" + n['paterno']);
      print("____" + n['materno']);
    }

    return List.generate(
      usuarioMap.length,
      (i) => Usuario(
        id_usuario: usuarioMap[i]['id_usuario'],
        paterno: usuarioMap[i]['paterno'],
        materno: usuarioMap[i]['materno'],
        nombre: usuarioMap[i]['nombre'],
        nro_celular: usuarioMap[i]['nro_celular'],
        cedula: usuarioMap[i]['cedula'],
        usuario: usuarioMap[i]['usuario'],
        password: usuarioMap[i]['password'],
      ),
    );
  }

  static Future<bool> autenticarUsuario(String usuario, String password) async {
    final db = await _openDB();

    final resultado = await db.query(
      'usuario',
      where: 'usuario = ? AND password = ?',
      whereArgs: [usuario, password],
    );

    return resultado.isNotEmpty;
  }

  static Future<Usuario?> buscarUsuario(String usu) async {
    Database db = await _openDB();

    final resultado = await db.query(
      'usuario',
      where: 'usuario = ?',
      whereArgs: [usu],
    );

    //return usuario;
    if (resultado.isNotEmpty) {
      return Usuario(
        id_usuario: int.parse(resultado[0]['id_usuario'].toString()),
        paterno: resultado[0]['paterno'].toString(),
        materno: resultado[0]['materno'].toString(),
        nombre: resultado[0]['nombre'].toString(),
        nro_celular: int.parse(resultado[0]['nro_celular'].toString()),
        cedula: int.parse(resultado[0]['cedula'].toString()),
        usuario: resultado[0]['usuario'].toString(),
        password: resultado[0]['password'].toString(),
      );
    } else {
      return null; // Si no se encuentra ningún usuario
    }
  }

  static Future<int> insertBache(Bache bache) async {
    final db = await _openDB();

    final id = await db.insert('bache', {
      'latitud': bache.latitud,
      'longitud': bache.longitud,
      'direccion': bache.direccion,
      'foto': bache.foto, // debe ser de tipo Uint8List
      'estado': bache.estado,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<int> insertRegistroBache(RegistroBache registro) async {
    final db = await _openDB();

    final id = await db.insert('registro_bache', {
      'id_bache': registro.id_bache,
      'id_usuario': registro.id_usuario,
      'fecha': registro.fecha,
      'seguimiento': registro.seguimiento,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  //obteniendo las tuplas de bache de un determinado usuario
  static Future<List<Map<String, dynamic>>> obtenerBachesPorUsuario(
    int idUsuario,
  ) async {
    final db = await _openDB();
    final resultado = await db.rawQuery(
      '''
    SELECT b.direccion, b.foto, r.fecha 
    FROM bache b
    INNER JOIN registro_bache r ON b.id_bache = r.id_bache
    WHERE r.id_usuario = ?
  ''',
      [idUsuario],
    );

    return resultado;
  }
}
