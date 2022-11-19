import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class detalle extends StatefulWidget {
  final String idCliente;
  const detalle({super.key,required this.idCliente});

  @override
  State<detalle> createState() => _detalleState();
}

class _detalleState extends State<detalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle cliente"),

      ),
    );
  }
}