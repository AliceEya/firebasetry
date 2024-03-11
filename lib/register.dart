import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
 
 final formKey = GlobalKey<FormState>();
 var email = TextEditingController();
 var pass = TextEditingController();
 var name = TextEditingController();
 var course = TextEditingController();
 
 
void RegAccount () async{
 if(!formKey.currentState!.validate()){
  return;
 }
 QuickAlert.show(
  context: context ,
  type: QuickAlertType.confirm,
  title: 'Are you sure?',
  confirmBtnText: 'Yes',
  cancelBtnText: 'No',
  onConfirmBtnTap: (){
    Navigator.of(context).pop();
    registerss();
  }
  );
}

 
void registerss () async {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: pass.text);
  String user_id = userCredential.user!.uid;
  await FirebaseFirestore.instance.collection('users').doc(user_id).set({
    'name': name.text,
    'course': course.text,
  });
  Navigator.of(context).pop();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Account'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
              validator:  (value){
                if(value == null || value.isEmpty){
                  return 'Required';
                } if (!EmailValidator.validate(value)){
                  return 'Enter a valid email';
                }
              },
            ),
             TextFormField(
              obscureText: true,
              controller: pass,
              decoration: InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required.';
                    }
            }
            ),
             TextFormField(
              controller: name,
              decoration: InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required.';
                    }
                  },
            ),
             TextFormField(
              controller: course,
              decoration: InputDecoration(
                label: Text('Course'),
                border: OutlineInputBorder(),
              ),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required.';
                    };
                  },
            ),
            ElevatedButton(onPressed: RegAccount, child: Text('Register'))
          ],
        ),
      ),
    );
  }
}