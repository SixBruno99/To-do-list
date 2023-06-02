// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_list/home.dart';
import 'package:to_do_list/widgets/login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  void registerRequest() {
    // Requisição com async await
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0xFF181818),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: senhaController,
              obscureText: true,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                labelText: 'Senha',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Já tem cadastro? Faça o login",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                registerRequest();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Entrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
