import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema/data/operation.dart';
import 'package:sistema/presentation/detalle_bache_page.dart';
import 'package:sistema/providers/session_provider.dart';

class MisRegistrosPage extends StatelessWidget {
  static const String route = "/mis-registros";

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionProvider>(context);
    final usuario = session.usuario;

    // Verificamos que el usuario exista antes de llamar al FutureBuilder
    if (usuario?.id_usuario == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Baches Registrados")),
        body: Center(child: Text("Usuario no disponible")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Baches Registrados"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Operation.obtenerBachesPorUsuario(usuario!.id_usuario!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay baches registrados"));
          }

          final baches = snapshot.data!;
          return ListView.builder(
            itemCount: baches.length,
            itemBuilder: (context, index) {
              final bache = baches[index];
              //recuperando la imagen
              //Uint8List? imagen = bache['foto'];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading:
                      bache['foto'] != null
                          ? Image.memory(
                            bache['foto'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                          : Icon(Icons.image_not_supported),
                  title: Text(bache['direccion'] ?? 'Sin dirección'),
                  subtitle: Text("Fecha: ${bache['fecha'] ?? 'Sin fecha'}"),
                  //mostrando de forma extendida la informacion del bache
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleBachePage(bache: bache),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
