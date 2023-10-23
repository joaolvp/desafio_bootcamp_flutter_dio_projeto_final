import 'package:brasil_fields/brasil_fields.dart';
import 'package:desafio_dio_projeto_final/model/contatos.dart';
import 'package:desafio_dio_projeto_final/repositories/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [Text('Criação de Contatos '), Icon(Icons.person)],
        ),
        backgroundColor: const Color(0xff4A5043),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
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
              Row(
                children: [
                  const Text(
                    ' Foto de Perfil: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.photo),
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff9AC2C9))),
                  ),
                  /* IconButton(onPressed: (){}, icon: const Icon(Icons.photo)) */
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            ContatosRepository().criarContato(
                                'teste',
                                nomeController.text,
                                cidadeController.text,
                                telefoneController.text,
                                emailController.text);
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff4A5043))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Criar ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Icon(Icons.create)
                            ],
                          ))),
                ],
              )
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xffFFCB47),
        child: const Icon(Icons.list),
      ),
    );
  }
}
