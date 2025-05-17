import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema/providers/session_provider.dart';
import 'package:sistema/presentation/registro_bache_page.dart';
import 'package:sistema/presentation/mis_registros_page.dart';

// ignore: use_key_in_widget_constructors
class MenuPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String route = "/menu";

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final usuario = session.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario != null
              ? "Bienvenido, ${usuario.nombre} ${usuario.paterno}"
              : "Menú Principal",
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              session.cerrarSesion();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.add_location_alt),
              label: Text("Registrar Bache"),
              onPressed: () {
                Navigator.pushNamed(context, RegistroBachePage.route);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.list),
              label: Text("Mis Registros"),
              onPressed: () {
                Navigator.pushNamed(context, MisRegistrosPage.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
