class Contatos {
  String? fotoPerfil;
  String? nome;
  String? cidade;
  String? telefone;
  String? email;

  Contatos(
      {this.fotoPerfil, this.nome, this.cidade, this.telefone, this.email});

  factory Contatos.fromMap(Map<String, dynamic> json){
    return Contatos(
      fotoPerfil: json['foto_perfil'],
      nome: json['nome'],
      cidade: json['cidade'],
      telefone: json['telefone'],
      email: json['email']
    );
  }

}