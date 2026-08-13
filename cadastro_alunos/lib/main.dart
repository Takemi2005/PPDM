import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Alunos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TelaCadastroAlunos(),
    );
  }
}

// Classe que representa um aluno
class Aluno {
  final String nome;
  final int idade;
  final String curso;

  Aluno({required this.nome, required this.idade, required this.curso});
}

class TelaCadastroAlunos extends StatefulWidget {
  const TelaCadastroAlunos({super.key});

  @override
  State<TelaCadastroAlunos> createState() => _TelaCadastroAlunosState();
}

class _TelaCadastroAlunosState extends State<TelaCadastroAlunos> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();

  final List<Aluno> _alunos = [];

  void _cadastrarAluno() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _alunos.add(
          Aluno(
            nome: _nomeController.text.trim(),
            idade: int.parse(_idadeController.text.trim()),
            curso: _cursoController.text.trim(),
          ),
        );
      });

      // Limpa os campos após cadastrar
      _nomeController.clear();
      _idadeController.clear();
      _cursoController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aluno cadastrado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _removerAluno(int index) {
    setState(() {
      _alunos.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Alunos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Formulário de cadastro
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o nome do aluno';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _idadeController,
                    decoration: const InputDecoration(
                      labelText: 'Idade',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe a idade';
                      }
                      final idade = int.tryParse(value.trim());
                      if (idade == null || idade <= 0) {
                        return 'Idade inválida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _cursoController,
                    decoration: const InputDecoration(
                      labelText: 'Curso',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o curso';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _cadastrarAluno,
                    icon: const Icon(Icons.add),
                    label: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Alunos cadastrados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Lista de alunos cadastrados
            Expanded(
              child: _alunos.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum aluno cadastrado ainda.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _alunos.length,
                      itemBuilder: (context, index) {
                        final aluno = _alunos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(aluno.nome),
                            subtitle: Text(
                              'Idade: ${aluno.idade} • Curso: ${aluno.curso}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removerAluno(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}