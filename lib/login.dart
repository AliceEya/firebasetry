import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetry/dashboard.dart';
import 'package:firebasetry/register.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
 
 
final formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passController = TextEditingController();
bool showPassword = true;


void login () async {
 if(formKey.currentState!.validate()){
  EasyLoading.show(status: 'Processing...');
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passController.text);
    EasyLoading.dismiss();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DashBooard()));
}
}


  void toggleShowPassword() {
  setState(() {
    showPassword = !showPassword;
  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('Email Address'),
              border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Required';
                }
              if (!EmailValidator.validate(value)){
                return 'Enter a valid email';
              }
              return null;
              }
              ),  
            Gap (4),
            TextFormField(
              
              obscureText: showPassword,
              controller: passController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: toggleShowPassword,
                    icon: Icon (showPassword ? Icons.visibility_off : Icons.visibility)
                ),
                label: Text('Password'),
              border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                if (value.length <= 5){
                  return 'Must be 6 or more characters';
                }
                return null;
              },
            ),
            Gap(4),
            ElevatedButton(onPressed: login, child: Text('LOGIN')),
            ElevatedButton(onPressed: ()=>
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Registration())),
            child: Text('Register here'))
          ],
        ),
      ),
    );
  }
}

