import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sistema/data/operation.dart';
import 'package:sistema/domain/Bache.dart';
import 'package:sistema/domain/RegistroBache.dart';
import 'package:sistema/providers/session_provider.dart';

class RegistroBachePage extends StatefulWidget {
  static const String route = "/registro-bache";

  @override
  State<RegistroBachePage> createState() => _RegistroBachePageState();
}

class _RegistroBachePageState extends State<RegistroBachePage> {
  final _formKey = GlobalKey<FormState>();
  final direccionController = TextEditingController();

  LatLng? _selectedLatLng;
  File? _selectedImage;
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<SessionProvider>(context).usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Bache"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Seleccione la ubicación en el mapa:"),
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      -16.5000,
                      -68.1500,
                    ), // posición inicial (La Paz)
                    zoom: 15,
                  ),

                  onTap: (latLng) {
                    setState(() => _selectedLatLng = latLng);
                  },
                  markers:
                      _selectedLatLng != null
                          ? {
                            Marker(
                              markerId: MarkerId("ubicacion"),
                              position: _selectedLatLng!,
                            ),
                          }
                          : {},
                  onMapCreated: (controller) => _mapController = controller,
                ),
              ),
              TextFormField(
                controller: direccionController,
                decoration: InputDecoration(
                  labelText: "Descripcion del bache",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),

              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
                onPressed: _pickImage,
              ),

              if (_selectedImage != null)
                Image.file(_selectedImage!, height: 150, fit: BoxFit.cover),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _selectedLatLng != null &&
                      _selectedImage != null) {
                    // Crear el objeto Bache
                    Bache bache = Bache(
                      latitud: _selectedLatLng!.latitude,
                      longitud: _selectedLatLng!.longitude,
                      direccion: direccionController.text,
                      foto: _selectedImage!.readAsBytesSync(),
                      estado: "Registrado",
                    );

                    int bacheId = await Operation.insertBache(bache);

                    RegistroBache registro = RegistroBache(
                      id_bache: bacheId,
                      id_usuario: usuario!.id_usuario!,
                      //idUsuario: usuario!.idUsuario!,
                      fecha: DateTime.now().toIso8601String(),
                      seguimiento: "Registrado",
                    );

                    await Operation.insertRegistroBache(registro);
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text(" Datos guardados"),
                            content: Text(
                              "¡Su registro de bache fue guardado, correctamente!",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Cierra el diálogo
                                  Navigator.of(
                                    context,
                                  ).pop(); // Regresa a la pantalla anterior
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Complete todos los campos")),
                    );
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }
}
