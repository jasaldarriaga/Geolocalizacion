import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:localizacion_r4/proceso/peticiones.dart';

class controladorGeneral extends GetxController {
  final Rxn<List<Map<String, dynamic>>> _listaPosiciones =
      Rxn<List<Map<String, dynamic>>>();
  final _unaPosicion = "".obs;

  /* ********************** */
  void cargarUnaPosicion(String X) {
    _unaPosicion.value = X;
  }

  String get unaPosicion => _unaPosicion.value;

  /* *************************** */

  void cargarListaPosiciones(List<Map<String, dynamic>> X) {
    _listaPosiciones.value = X;
  }

  List<Map<String, dynamic>>? get ListaPosiciones => _listaPosiciones.value;

  /* ************************* */
  Future<void> CargarTodaDB() async {
    final datos = await PeticionesDB.MostrarTodasUbicaciones();
    cargarListaPosiciones(datos);
  }
}
