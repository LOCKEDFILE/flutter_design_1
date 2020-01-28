import 'dart:math';

import 'package:design_1/depth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Concept 1',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Design(),
    );
  }
}

class Design extends StatefulWidget {
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  int page = 0;
  List item = [for (var i = 0; i < 10; i++) i];
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Color.fromRGBO(240, 241, 245, 1),
        body: SafeArea(
          // top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              header(),
              bodyText(),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView(
                  controller: pageController
                    ..addListener(() {
                      setState(() {
                        page = pageController.page.round();
                      });
                    }),
                  children: item.map((v) => pageItem(index: v)).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 28, top: 20),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    small(),
                    medium(),
                    large(flag: true),
                    medium(),
                    small(),
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: drawer(),
      ),
    );
  }

  Widget small() => CircleAvatar(
        radius: 3,
        backgroundColor: Colors.deepPurple[200],
      );
  Widget medium() => CircleAvatar(
        radius: 5,
        backgroundColor: Colors.deepPurple[400],
      );
  Widget large({double size = 20, bool flag = false}) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: size,
            backgroundColor: Colors.deepPurple,
          ),
          if (flag)
            CircleAvatar(
              radius: size - 0.5,
              backgroundColor: Colors.white,
              child: Text(
                page.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
        ],
      );
  Widget header() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                _globalKey.currentState?.openDrawer();
              });
            },
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyText() {
    return Container(
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Test App',
            style: TextStyle(
              fontSize: 32,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Design Reference',
            style: TextStyle(
              fontSize: 32,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'this app is test application for design. from internet by hj',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey[200],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget pageItem({int index}) {
    String title = 'Page Item index::$index';
    String desc = 'Description';
    return Container(
      margin: EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Depth(
                    index: index,
                    title: title,
                    desc: desc,
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 3,
                color: Colors.grey[300],
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: 'img$index',
                    transitionOnUserGestures: true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image:
                                NetworkImage('https://picsum.photos/20$index'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: 'des$index',
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              '$desc',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Hero(
                          tag: 'title$index',
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              '$title',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: ListTile(
                  title: Text(
                    '\$ ${437 + index * 7}',
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                  trailing: Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListTile(
              onTap: () {},
              subtitle: Text('Test'),
              title: Text('Title'),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: _globalKey.currentState?.openEndDrawer,
              title: Container(
                // color: Colors.grey[300],
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '닫기',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.keyboard_backspace,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
