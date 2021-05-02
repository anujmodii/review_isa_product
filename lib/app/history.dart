import 'package:flutter/material.dart';
import 'package:review_isa_product/services/auth.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key,@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void _logout(BuildContext context){
    _homePageClicked(context);
    _signOut();
  }

  void _homePageClicked(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReviewISAProduct'),
        actions: <Widget>[
          TextButton(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 50,
              ),
              child: Text(
                'ANALYSE',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            //TODO: attach HOMEPAGE func
            onPressed:  () => _homePageClicked(context),
          ),
          TextButton(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 50,
              ),
              child: Text(
                'LOGOUT',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container()
    );
  }
}
