import 'package:flutter/material.dart';
import 'package:review_isa_product/app/sign_in/email_sign_in_page.dart';
import 'package:review_isa_product/app/sign_in/sign_in_button.dart';
import 'package:review_isa_product/app/sign_in/social_sign_in_button.dart';
import 'package:review_isa_product/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    //To test this feature run by following command
    // flutter run -d chrome --web-hostname localhost --web-port 61441
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    //To test this feature run by following command
    // flutter run -d chrome --web-hostname localhost --web-port 61441
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EmailSignInPage(
        auth: auth,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReviewISAProduct'),
        elevation: 2.0,
      ),
      body: Center(
        child: _buildContent(context),
      ),
      backgroundColor: Colors.white30,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset('images/cover_pic.jpg'),
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("B.SC COMPUTER SCI PROJECT UNDER THE GUIDANCE OF DR. ANAL ACHARYA",
                            style: TextStyle(
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //ABOUT US
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 175,
                                    backgroundImage: AssetImage(
                                      'images/ishita.jpeg',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "ISHITA BAJORIA \n        513",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 175,
                                    backgroundImage: AssetImage(
                                      'images/sudeshna.jpeg',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "SUDESHNA SWAIN \n          538",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 175,
                                    backgroundImage: AssetImage(
                                      'images/anuj.jpeg',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "ANUJ MODI \n      506",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 0,
            thickness: 1,
          ),
          //SIGN IN SIDE BAR
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 48.0),
                  SocialSignInButton(
                    assetName: 'images/google-logo.png',
                    text: 'Sign in with Google',
                    textColor: Colors.black87,
                    color: Colors.white,
                    onPressed: _signInWithGoogle,
                  ),
                  SizedBox(height: 8.0),
                  SocialSignInButton(
                    assetName: 'images/facebook-logo.png',
                    text: 'Sign in with Facebook',
                    textColor: Colors.white,
                    color: Color(0xFF334D92),
                    onPressed: _signInWithFacebook,
                  ),
                  SizedBox(height: 8.0),
                  SignInButton(
                    text: 'Sign in with email',
                    textColor: Colors.white,
                    color: Colors.teal[700],
                    onPressed: () => _signInWithEmail(context),
                  ),
                  SizedBox(height: 8.0),
                  SignInButton(
                    text: 'Go anonymous',
                    textColor: Colors.black,
                    color: Colors.lime[300],
                    onPressed: _signInAnonymously,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
