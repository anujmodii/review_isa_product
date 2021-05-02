import 'dart:convert';

import 'package:http/http.dart' as http;

var decodedResp;

Future getKey(url) async {
  var response = await http.get(url);
  decodedResp= jsonDecode(response.body);
  return response.body;
}

int getCompetitionIndex(){
  return decodedResp["Competition_Index"];
}

String getBadWordcloud(){
  return decodedResp["bad_wordcloud"];
}

String getGoodWordcloud(){
  return decodedResp["good_wordcloud"];
}

String getBarPlot(){
  return decodedResp["bar_plot"];
}

String getPieChart(){
  return decodedResp["pie_good_bad"];
}

int getBsr(){
  return decodedResp["bsr"];
}

double getRecommendationScore(){
  return decodedResp["recommendation_score"];
}

String getSalesChart(){
  return decodedResp["sales_chart"];
}

double getSalesIndex(){
  return decodedResp["sales_potential_index"];
}

String getScatterPlot(){
  return decodedResp["scatter_plot"];
}

int getSufficientDataReviews(){
  return decodedResp["similar_objects_with_sufficient_data"];
}

int getTotalProds(){
  return decodedResp["total_products_in_category"];
}

int getTotalReviews(){
  return decodedResp["total_reviews"];
}

int getTotalSimilarObjects(){
  return decodedResp["total_similar_objects"];
}