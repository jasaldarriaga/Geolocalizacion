import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localizacion_r4/controlador/controladorGeneral.dart';
import 'package:localizacion_r4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Listar extends StatefulWidget {
  const Listar({super.key});

  @override
  State<Listar> createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  controladorGeneral Control = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Control.CargarTodaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Control.ListaPosiciones?.isEmpty == false
              ? ListView.builder(
                  itemCount: Control.ListaPosiciones!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.location_searching_rounded),
                        trailing: IconButton(
                          onPressed: () {
                            Alert(
                                    type: AlertType.warning,
                                    context: context,
                                    title: "Atencion!!!",
                                    buttons: [
                                      DialogButton(
                                          color: Colors.amber,
                                          child: Text('Confirmar'),
                                          onPressed: () {
                                            PeticionesDB.EliminarPosicion(
                                                Control.ListaPosiciones![index]
                                                    ["id"]);
                                            Control.CargarTodaDB();
                                            Navigator.pop(context);
                                          }),
                                      DialogButton(
                                          color: Colors.purple,
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                    desc: "Confirmar para eliminar posición")
                                .show();
                          },
                          icon: Icon(Icons.delete_outlined),
                        ),
                        title: Text(
                            Control.ListaPosiciones![index]["coordenadas"]),
                        subtitle:
                            Text(Control.ListaPosiciones![index]["fecha"]),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No hay datos para visualizar!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.orangeAccent,
                      ),
                    ),
                  ],
                )),
        ));
  }
}
