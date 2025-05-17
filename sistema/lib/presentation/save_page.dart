//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'package:sistema/data/operation.dart';
import 'package:sistema/domain/Usuario.dart';

class SavePage extends StatelessWidget {
  static const String route = "/save";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guardar")),
      body: Container(child: _FormSave()),
    );
  }
}

class _FormSave extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final paternoController = TextEditingController();
  final maternoController = TextEditingController();
  final celularController = TextEditingController();
  final cedulaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nombreController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Debe añadir datos ";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),
            TextFormField(
              controller: paternoController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Debe añadir datos ";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Paterno",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),
            TextFormField(
              controller: maternoController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Debe añadir datos ";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Materno",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),
            TextFormField(
              controller: cedulaController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Debe añadir datos ";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Nro. Cedula",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            TextFormField(
              controller: celularController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Debe añadir datos ";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Numero de celular",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            ElevatedButton(
              child: Text("Registrar"),
              onPressed: () {
                //verifica la validacion de cada campo
                if (_formKey.currentState!.validate()) {
                  //printToConsole("Valido: " + nombreController.text);
                  print("Valido: " + nombreController.text);
                  //instanciando un objeto de tipo Usuario
                  var usu = Usuario(
                    nombre: nombreController.text,
                    paterno: paternoController.text,
                    materno: maternoController.text,
                    nro_celular: int.parse(celularController.text),
                    cedula: int.parse(cedulaController.text),
                    usuario: cedulaController.text,
                    password: cedulaController.text,
                  );

                  Operation.insertUsuario(usu);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Usuario registrado")));
                  Navigator.pop(
                    context,
                  ); // o ir al login: Navigator.pushReplacementNamed(context, LoginPage.route);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
