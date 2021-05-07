import 'dart:html';
import 'package:flutter/material.dart';
import 'package:review_isa_product/app/analysisASIN.dart';
import 'package:review_isa_product/app/analyzedContents.dart';
import 'package:review_isa_product/services/auth.dart';
import 'package:flutter/material.dart';
//page after signing in, provides interface for analysing asin, connects to flask app
class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.auth, this.analyzed}) : super(key: key);
  final AuthBase auth;
  bool analyzed;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _asinTextController = TextEditingController();

  var response = "";

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReviewISAProduct'),
        centerTitle: true,
        actions: <Widget>[
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
              flex: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        autofocus: true,
                        controller: _asinTextController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'ASIN',
                        ),
                      ),
                      SizedBox(height: 50.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(73, 128, 3, 1.0), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          try {
                            final path = Uri.parse(
                                'http://127.0.0.1:5000/product_review/' +
                                    _asinTextController.text);
                            var response = await getKey(path);
                            // response = jsonDecode(re);
                            setState(() {
                              widget.analyzed = true;
                            });
                          } catch (e) {
                            setState(() {
                              widget.analyzed = true;
                            });
                            setCode(404);
                          }
                        },
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
              child: widget.analyzed
                  ? AnalyzedContents()
                  : Container(
                      child: Center(
                        child: Text(
                            "Please search for an asin eg. B00570QQ5G, B01G91Y4VE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromRGBO(73, 128, 3, 1.0),
                        ),),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
