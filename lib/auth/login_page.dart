import 'package:flutter/material.dart';
import 'package:kuis_prak_mobile/page/home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool _obscurePassword = true;
  bool isLoginSuccess = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 1, 49, 138);
    
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Column(
            children: [
              _buildHeader(),
              _buildFormContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo-game.png', 
            height: 400,
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200, 
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _usernameField(),
            const SizedBox(height: 10),
            _passwordField(),
            _handleLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      margin: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) {
          setState(() {
            username = value;
          });
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Input Username",
          labelText: 'Username',
          contentPadding: const EdgeInsets.all(12.0),
          prefixIcon: const Icon(Icons.person_outline),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
          ),
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: "Input Password",
          labelText: "Password",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _handleLoginButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 1, 49, 138),
          padding: const EdgeInsets.symmetric(vertical: 16), 
        ),
        onPressed: () {
          String text = "";
          if (username == "fendyra" && password == "010") {
            setState(() {
              text = "Login Success";
              isLoginSuccess = true;
            });
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomePage(
                username: username,
              );
            }));
          } else {
            setState(() {
              text = "Login Failed";
              isLoginSuccess = false;
            });
          }

          final snackBar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Login'),
      ),
    );
  }
}