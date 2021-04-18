import 'package:flutter/material.dart';
import 'package:review_isa_product/app/sign_in/email_signin_form.dart';
import 'package:review_isa_product/services/auth.dart';
class EmailSignInPage extends StatelessWidget {

  EmailSignInPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Card(
          child: EmailSignInForm(auth: auth),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
