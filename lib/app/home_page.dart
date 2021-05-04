import 'dart:html';
import 'package:flutter/material.dart';
import 'package:review_isa_product/app/analysisASIN.dart';
import 'package:review_isa_product/app/analyzedContents.dart';
import 'package:review_isa_product/app/history.dart';
import 'package:review_isa_product/services/auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

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

  void historyPageClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryPage(
        auth: widget.auth,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReviewISAProduct'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(480)),
        elevation: 0.00,
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
            onPressed: () => historyPageClicked(context),
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
                            print(e.toString() + " catched");
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
                      child: Text(
                          "Please search for an asin eg. B00570QQ5G, B01G91Y4VE"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
