import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localizacion_r4/controlador/controladorGeneral.dart';
import 'package:localizacion_r4/interfaz/home.dart';

void main() {
  runApp(const MyApp());
  Get.put(controladorGeneral());
}
