import 'package:flutter/material.dart';

import 'analysisASIN.dart';

class AnalyzedContents extends StatefulWidget {
  @override
  _AnalyzedContentsState createState() => _AnalyzedContentsState();
}

class _AnalyzedContentsState extends State<AnalyzedContents> {
  @override
  Widget build(BuildContext context) {
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
    child: Text("Data is analyzed"),
    );
  }
}
