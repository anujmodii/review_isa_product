import 'package:flutter/material.dart';
import 'package:review_isa_product/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
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
                'HISTORY',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            //TODO: attach history func
            onPressed: () {},
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
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Color.fromRGBO(246, 232, 209, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'ASIN',
                          ),
                        ),
                        SizedBox(height: 50.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("ANALYSE"),
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
              Expanded(
                flex: 7,
                child: Container(),
                //TODO: Output window
              )
            ],
          ),
        ),
    );
  }
}
