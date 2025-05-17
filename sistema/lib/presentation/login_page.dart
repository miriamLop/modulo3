import 'package:flutter/material.dart';
import 'package:sistema/data/operation.dart';
import 'package:sistema/domain/Usuario.dart';
import 'package:sistema/presentation/menu_page.dart';
import 'package:sistema/presentation/save_page.dart';
import 'package:provider/provider.dart';
import 'package:sistema/providers/session_provider.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    String usuario = usuarioController.text.trim();
    String password = passwordController.text.trim();

    bool autenticado = await Operation.autenticarUsuario(usuario, password);
    Usuario? user = await Operation.buscarUsuario(usuario);

    if (autenticado != null && user != null) {
      Provider.of<SessionProvider>(context, listen: false).setUsuario(user);
      Navigator.pushReplacementNamed(
        // context,  MaterialPageRoute(builder: (context) => ListPage()),
        context,
        MenuPage.route,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Datos incorrectos, verifique sus datos")),
      );
    }
  }

  void _registrarse() {
    Navigator.pushNamed(context, SavePage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar Sesión"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usuarioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Usuario (Cédula)"),
                validator:
                    (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Contraseña (Cédula)"),
                obscureText: true,
                validator:
                    (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: Text("Ingresar"),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: _registrarse,
                child: Text("¿Eres nuevo? Registrese, por favor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
