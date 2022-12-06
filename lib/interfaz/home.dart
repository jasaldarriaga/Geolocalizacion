import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:localizacion_r4/controlador/controladorGeneral.dart';
import 'package:localizacion_r4/interfaz/listar.dart';
import 'package:localizacion_r4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Geolocated Jaydron',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Geolocalización Jaydron'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  controladorGeneral Control = Get.find();

  void ObtenerPosicion() async {
    Position posicion = await PeticionesDB.determinePosition();
    Control.cargarUnaPosicion(posicion.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Alert(
                        title: "Atención!!",
                        desc: "Confirmar para eliminar todas la ubicaciones",
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                              color: Colors.orange,
                              child: Text("Confirmar"),
                              onPressed: () {
                                PeticionesDB.EliminarTodas();
                                Control.CargarTodaDB();

                                Navigator.pop(context);
                              }),
                          DialogButton(
                              color: Colors.lime,
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                        context: context)
                    .show();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: Listar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ObtenerPosicion();
          Alert(
                  title: "Atención!!",
                  desc:
                      "Confirmar para guardar ubicación " + Control.unaPosicion,
                  type: AlertType.info,
                  buttons: [
                    DialogButton(
                        color: Colors.green,
                        child: Text("Confirmar"),
                        onPressed: () {
                          PeticionesDB.GuardarPosicion(
                              Control.unaPosicion, DateTime.now().toString());
                          Control.CargarTodaDB();

                          Navigator.pop(context);
                        }),
                    DialogButton(
                        color: Colors.red,
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                  context: context)
              .show();
        },
        child: Icon(Icons.location_on_outlined),
      ),
    );
  }
}
