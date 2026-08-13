// Testes de widget para o app de Cadastro de Alunos.
//
// Para realizar interações com um widget no teste, use o utilitário
// WidgetTester do pacote flutter_test. Por exemplo, você pode enviar
// gestos de tap e scroll, encontrar widgets filhos, ler texto e
// verificar se as propriedades dos widgets estão corretas.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cadastro_alunos/main.dart';

void main() {
  testWidgets('Tela inicial exibe o formulário de cadastro',
      (WidgetTester tester) async {
    // Constrói o app e dispara um frame.
    await tester.pumpWidget(const MeuApp());

    // Verifica se o título aparece na AppBar.
    expect(find.text('Cadastro de Alunos'), findsWidgets);

    // Verifica se os campos do formulário estão presentes.
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Idade'), findsOneWidget);
    expect(find.text('Curso'), findsOneWidget);

    // Verifica se a lista começa vazia.
    expect(find.text('Nenhum aluno cadastrado ainda.'), findsOneWidget);
  });

  testWidgets('Cadastrar aluno com dados válidos adiciona à lista',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // Preenche os campos do formulário.
    await tester.enterText(find.widgetWithText(TextFormField, 'Nome'), 'Maria Silva');
    await tester.enterText(find.widgetWithText(TextFormField, 'Idade'), '20');
    await tester.enterText(find.widgetWithText(TextFormField, 'Curso'), 'Engenharia');

    // Toca no botão Cadastrar.
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    // Verifica se o aluno aparece na lista.
    expect(find.text('Maria Silva'), findsOneWidget);
    expect(find.textContaining('Idade: 20'), findsOneWidget);
    expect(find.textContaining('Engenharia'), findsOneWidget);

    // A mensagem de lista vazia não deve mais existir.
    expect(find.text('Nenhum aluno cadastrado ainda.'), findsNothing);
  });

  testWidgets('Não cadastra aluno com campos vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // Toca em Cadastrar sem preencher nada.
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    // Deve mostrar mensagens de validação.
    expect(find.text('Informe o nome do aluno'), findsOneWidget);
    expect(find.text('Informe a idade'), findsOneWidget);
    expect(find.text('Informe o curso'), findsOneWidget);

    // A lista continua vazia.
    expect(find.text('Nenhum aluno cadastrado ainda.'), findsOneWidget);
  });
}