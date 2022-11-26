import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parcial04/detalleCliente.dart';
import 'package:parcial04/newUser.dart';

class clientes extends StatefulWidget {
  const clientes({super.key});

  @override
  State<clientes> createState() => _clientesState();
}

class _clientesState extends State<clientes> {
  CollectionReference clientes =
      FirebaseFirestore.instance.collection('clientes');

  Future<void> _eliminar(String idCliente) async {
    await clientes.doc(idCliente).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: clientes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => detalle(
                                    idCliente: documentSnapshot.id,
                                    estado: false,
                                  )))),
                      title: Text(documentSnapshot['nombre'].toString() +
                          "\t" +
                          documentSnapshot['apellido'].toString()),
                      subtitle: Text(documentSnapshot['cedula'].toString()),
                      trailing: SizedBox( 
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _eliminar(documentSnapshot.id),
                            ),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>detalle(idCliente: documentSnapshot.id, estado: true)));
                            }, icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const newUser()));
          }),
    );
  }
}
