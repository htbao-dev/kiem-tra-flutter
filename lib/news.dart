import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News {
  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  static Future<News> fetchData(String newsType) async{
    String url = "https://newsapi.org/v2/everything?q=" + newsType + "&from=2021-11-15&to=2021-11-15&sortBy=popularity&apiKey=22017bed8d2e44d8aa8b38d4aececb76";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<Article> articles = [];
      print(jsonData["status"]);
      for (var item in jsonData["articles"]){
        Source source = Source(id: item["id"], name: item["name"]);
        Article article = Article(
            source: source,
            author: item["author"],
            title: item["title"],
            description: item["description"],
            url: item["url"],
            urlToImage: item["urlToImage"],
            publishedAt: DateTime.parse(item["publishedAt"]),
            content: item["content"]
        );
        articles.add(article);
      }
      News news = News(status: jsonData["status"], totalResults: jsonData["totalResults"], articles: articles);
      return news;
    }
    else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết : ${response.statusCode}");
    }
  }
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime? publishedAt;
  String content;
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String? id;
  String? name;
}
