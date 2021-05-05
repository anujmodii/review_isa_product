import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'analysisASIN.dart';

//flutter run -d chrome --web-renderer html // to run the app
//flutter build web --web-renderer html --release // to generate a production build
class AnalyzedContents extends StatefulWidget {
  @override
  _AnalyzedContentsState createState() => _AnalyzedContentsState();
}

class _AnalyzedContentsState extends State<AnalyzedContents> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    print(getCompetitionIndex());
    print(getBadWordcloud());
    print(getGoodWordcloud());
    print(getRecommendationScore());
    print(getBarPlot());
    print(getPieChart());
    print(getBsr());
    print(getSalesChart());
    print(getSalesIndex());
    print(getTotalProds());
    print(getScatterPlot());
    print(getSufficientDataReviews());
    print(getTotalReviews());
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
                      "GOOD REVIEWS V/S BAD REVIEWS",
                      "RATING"
                    ];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            imagesUrl[index],
                            fit: BoxFit.fitWidth,
                          ),
                          Text(subs[index])
                        ],
                      ),
                    );
                  },
                ),
                // Container(child: createIFrame(getScatterPlot()))
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
                        "BSR",
                        textScaleFactor: 1.5,
                      ),
                      subtitle: Container(
                        alignment: Alignment.center,
                        child: Text(
                          getBsr().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
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
                        "Recommendaton Score",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Container(
                        alignment: Alignment.center,
                        child: Text(
                          getRecommendationScore().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: Text("Details"),
                      subtitle: Text(
                        "Total Similar Products : " +
                            getTotalProds().toString() +
                            "\nTotal reviews : " +
                            getTotalReviews().toString() +
                            "\nTotal reviews with sufficient data : " +
                            getSufficientDataReviews().toString() +
                            "\n\n",
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
  }

  // Widget createIFrame(String src) {
  //   final IFrameElement _iframeElement = IFrameElement();
  //   _iframeElement.height = '500';
  //   _iframeElement.width = '500';
  //
  //   _iframeElement.src = src;
  //   _iframeElement.style.border = 'none';
  //
  //   // ignore: undefined_prefixed_name
  //   ui.platformViewRegistry.registerViewFactory(
  //     src,
  //     (int viewId) => _iframeElement,
  //   );
  //
  //   return HtmlElementView(
  //     key: UniqueKey(),
  //     viewType: src,
  //   );
  // }
}