import 'package:flutter/material.dart';

mostrarDialogHome(String texto, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(texto)),
            actions: [
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff4A5043))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Fechar')),
              ),
            ],
          );
        });
  }