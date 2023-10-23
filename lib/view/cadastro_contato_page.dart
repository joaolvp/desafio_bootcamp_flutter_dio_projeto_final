import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:desafio_dio_projeto_final/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CadastroContatoPage extends StatefulWidget {
  const CadastroContatoPage({super.key});

  @override
  State<CadastroContatoPage> createState() => _CadastroContatoPageState();
}

class _CadastroContatoPageState extends State<CadastroContatoPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String namePhoto = "";
  String pathPhoto = "";
  File? _image;
  var isLoading = false;

  cameraPhoto() async {
    final XFile? imgFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imgFile == null) return;

    print(imgFile.name);

    setState(() {
      namePhoto = imgFile.name;
      pathPhoto = imgFile.path;
      _image = File(imgFile.path);
    });
  }

  galeriaPhoto() async {
    final XFile? imgFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imgFile == null) return;

    print(imgFile.name);
    setState(() {
      namePhoto = imgFile.name;
      pathPhoto = imgFile.path;
      _image = File(imgFile.path);
    });
  }

  mostrarDialog(String texto) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Criar Contato '),
          ],
        ),
        backgroundColor: const Color(0xff4A5043),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centraliza o CircleAvatar horizontalmente
                children: [
                  _image != null
                      ? ClipOval(
                          child: Image.file(
                          _image!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ))
                      : const CircleAvatar(
                          radius: 75,
                          backgroundColor: Color(0xff9AC2C9),
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff9AC2C9))),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Câmera'),
                                    onTap: () {
                                      
                                      cameraPhoto();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo),
                                    title: const Text('Galeria'),
                                    onTap: () {
                                      
                                      galeriaPhoto();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Row(
                        children: [
                          Text('Editar'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.edit),
                        ],
                      )),
                ],
              ),
              //Text(namePhoto),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nomeController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    label: Text('Nome'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: cidadeController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    label: Text('Cidade'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                controller: telefoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Telefone'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    label: Text('E-mail'), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            dynamic response;
                            print(response);
                            setState(() {
                              isLoading = true;
                            });
                            response = await ContatosRepository().criarContato(
                                pathPhoto,
                                nomeController.text,
                                cidadeController.text,
                                telefoneController.text,
                                emailController.text);

                            if (response == 201) {
                              setState(() {
                                isLoading = false;
                              });
                              nomeController.text = "";
                              cidadeController.text = "";
                              telefoneController.text = "";
                              emailController.text = "";
                              _image = null;
                              return mostrarDialog('Criado com sucesso!');
                            } else {
                              setState(() {
                                isLoading = false;
                              });

                              return mostrarDialog('Erro ao criar contato');
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff4A5043))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Salvar ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Icon(Icons.save_sharp)
                            ],
                          ))),
                         
                          
                ],
              ),
              isLoading == true ? const CircularProgressIndicator(color: Color(0xffFFCB47)) : const Text("")
            ]),
          ),
        ],
      ),
      
    );
  }
}
