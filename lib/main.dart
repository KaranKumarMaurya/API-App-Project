import 'package:api_app/components/customListTile.dart';
import 'package:api_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'models/article_models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices client = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Karan News",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal,
      ),

//Now let's call the api services with futurebuilder widget
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            );
          }else{
            return Center(child: Text("No Record Found",style: TextStyle(fontSize: 20),));
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
