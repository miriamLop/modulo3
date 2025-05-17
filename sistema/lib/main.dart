import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema/presentation/save_page.dart';
import 'package:sistema/presentation/login_page.dart';
import 'package:sistema/providers/session_provider.dart';
import 'package:sistema/presentation/registro_bache_page.dart';
import 'package:sistema/presentation/mis_registros_page.dart';
import 'package:sistema/presentation/menu_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => SessionProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (_) => LoginPage(),
        MenuPage.route: (_) => MenuPage(),
        RegistroBachePage.route: (_) => RegistroBachePage(),
        MisRegistrosPage.route: (_) => MisRegistrosPage(),
        SavePage.route: (_) => SavePage(),
      },
    );
  }
}
