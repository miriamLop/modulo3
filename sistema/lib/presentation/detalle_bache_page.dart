import 'package:flutter/material.dart';
import 'dart:typed_data';

class DetalleBachePage extends StatelessWidget {
  final Map<String, dynamic> bache;

  const DetalleBachePage({Key? key, required this.bache}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List? imagen = bache['foto'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle del Bache"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagen != null
                ? Image.memory(
                  imagen,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                : Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.image, size: 50)),
                ),
            SizedBox(height: 16),
            Text("Dirección:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(bache['direccion'] ?? 'Sin dirección'),
            SizedBox(height: 8),
            Text(
              "Fecha de registro:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(bache['fecha'] ?? 'Sin fecha'),
            SizedBox(height: 8),
            if (bache['latitud'] != null && bache['longitud'] != null) ...[
              Text("Ubicación:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Latitud: ${bache['latitud']}"),
              Text("Longitud: ${bache['longitud']}"),
            ],
            if (bache['estado'] != null) ...[
              SizedBox(height: 8),
              Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${bache['estado']}"),
            ],
          ],
        ),
      ),
    );
  }
}
