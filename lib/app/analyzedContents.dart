import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'analysisASIN.dart';

//display the response from flask app in the homepage after searching for asin
class AnalyzedContents extends StatefulWidget {
  @override
  _AnalyzedContentsState createState() => _AnalyzedContentsState();
}

class _AnalyzedContentsState extends State<AnalyzedContents> {
  @override
  Widget build(BuildContext context) {
    code = getCode();
    if (code == 200) {
      final IFrameElement scatterPlotIFrame = IFrameElement();
      scatterPlotIFrame.src = getScatterPlot();
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'scatter_plot',
        (int viewId) => scatterPlotIFrame,
      );
      Widget scatterPlot = HtmlElementView(
        key: UniqueKey(),
        viewType: 'scatter_plot',
      );
      final IFrameElement barPlotIFrame = IFrameElement();
      barPlotIFrame.src = getBarPlot();
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'bar_plot',
        (int viewId) => barPlotIFrame,
      );
      Widget barPlot = HtmlElementView(
        key: UniqueKey(),
        viewType: 'bar_plot',
      );
      final PageController controller = PageController(initialPage: 0);
      print("app running");
      return Container(
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      List imagesUrl = [
                        getGoodWordcloud(),
                        getBadWordcloud(),
                        getPieChart(),
                        getSalesChart(),
                      ];
                      List subs = [
                        "GOOD WORDCLOUD",
                        "BAD WORDCLOUD",
                      ];
                      return index == 3
                            ? Center(
                                child: Stack(
                                   children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        imagesUrl[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        getSalesIndex().toString(),
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35.0),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : index == 2
                                ? Image.network(
                                    imagesUrl[index],
                                    fit: BoxFit.contain,
                                  )
                                : Column(
                          mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        imagesUrl[index],
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        subs[index],
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      )
                                    ],
                                  );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: scatterPlot,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: barPlot,
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 0,
              thickness: 1,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(
                          "Product Title",
                          textScaleFactor: 1.5,
                        ),
                        subtitle: Text(
                          getProductTtile().toUpperCase(),
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(73, 128, 3, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(
                          "Competitive Index",
                          textScaleFactor: 1.5,
                        ),
                        subtitle: Container(
                          alignment: Alignment.center,
                          child: Text(
                            getCompetitionIndex().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Color.fromRGBO(73, 128, 3, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(
                          "Rank Index",
                          textScaleFactor: 1.5,
                        ),
                        subtitle: Container(
                          alignment: Alignment.center,
                          child: Text(
                            getBsr().toString() +
                                "/" +
                                getTotalProds().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromRGBO(73, 128, 3, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(
                          "Recommendation Score",
                          textScaleFactor: 1.2,
                        ),
                        subtitle: Container(
                          alignment: Alignment.center,
                          child: Text(
                            getRecommendationScore().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Color.fromRGBO(73, 128, 3, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Text(
            "TRY AGAIN, INVALID ASIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromRGBO(73, 128, 3, 1.0),
            ),
          ),
        ),
      );
    }
  }
}
//flutter run -d chrome --web-renderer html // to run the app
//flutter build web --web-renderer html --release // to generate a production build
