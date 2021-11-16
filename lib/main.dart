import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kiem_tra/common.dart';
import 'package:kiem_tra/news_webview.dart';

import 'news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<News> news;
  late List<NewsType> listNewsType = NewsType.getListNewsType();
  @override
  void initState() {
    super.initState();
    news = News.fetchData(listNewsType[0].type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: news,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              var data =snapshot.data as News;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: newsTitle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: myCarousel()
                    ),
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.articles.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: newsItem(context, data.articles[index])
                          )
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget myCarousel(){
    return CarouselSlider.builder(
      itemCount: listNewsType.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => itemBuilder(listNewsType[itemIndex]),
      options: CarouselOptions(
        height: 80,
        viewportFraction: 0.5,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        // onPageChanged: callbackFunction,
        // scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget newsItem(BuildContext context, Article article){
    return GestureDetector(
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(article.urlToImage),
            borderRadius: BorderRadius.circular(10.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(article.title, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),),
          ),
          Text(article.content, style: const TextStyle(
              fontWeight: FontWeight.w300
          ),)
        ],
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute (
            builder: (BuildContext context) =>  NewsWebView(url: article.url,),
          ),
        );
      },
    );
  }

  Widget itemBuilder(NewsType item){
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            child: Image.network(item.imgUrl, width: 150,fit: BoxFit.fill,),
            borderRadius: BorderRadius.circular(10.0),
          ),
          Text(item.displayName, style: TextStyle(
            color: Colors.lightBlue.shade400,
            fontSize: 20,
            fontWeight: FontWeight.w700
          ),)
        ],
      ),
      onTap: (){
        setState(() {
          news = News.fetchData(item.type);
        });
      },
    );
  }

  Widget newsTitle(){
    double size = 25;
    var fontWeight = FontWeight.w800;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Flutter", style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight
        ),),
        Text("News", style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: Colors.lightBlue.shade400
        ),),
      ],
    );
  }
}
