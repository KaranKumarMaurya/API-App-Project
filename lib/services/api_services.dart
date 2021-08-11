import 'dart:convert';

import 'package:api_app/models/article_models.dart';
import 'package:http/http.dart';

//Now let's make the HTTP request services
//this class will allow us to make a simple get http request
//from the API and get the Articles and then return a list of Articles

class ApiServices {
  //let's add an Endpoint URl,you can check the website documentation
  //and learn about the different Endpoint
  //for this example I'm going to use a single endpoint

  final endPointUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2021-07-11&sortBy=publishedAt&apiKey=958bac8bbc624b28adbf9e0c6de57118";

  //HTTP request function
  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    //first of all let's check that we got a 200 status code:this mean that the request was a success
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allows us to get the different articles from the json
      //file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Article");
    }
  }
}
