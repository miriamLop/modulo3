import 'package:flutter/material.dart';
import 'package:sistema/domain/Usuario.dart';

class SessionProvider with ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void cerrarSesion() {
    _usuario = null;
    notifyListeners();
  }
}
