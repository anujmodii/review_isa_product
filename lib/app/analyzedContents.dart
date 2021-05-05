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
                            fit: BoxFit.contain,
                          ),
                          Text(subs[index])
                        ],
                      ),
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
                        "Rank Index",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
