import 'package:flutter/material.dart';

class Depth extends StatefulWidget {
  final index;

  final title, desc;
  Depth({Key key, this.index, this.title, this.desc}) : super(key: key);

  @override
  _DepthState createState() => _DepthState();
}

class _DepthState extends State<Depth> {
  int index;
  String title;
  String desc;

  @override
  void initState() {
    index = widget.index;
    title = widget.title;
    desc = widget.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 241, 245, 1),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backView(),
            heroContent(),
          ],
        ),
      ),
    );
  }

  Widget backView() => Container(
        margin: EdgeInsets.fromLTRB(12, 10, 0, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 3,
              color: Colors.grey[300],
            )
          ],
        ),
      );

  Widget heroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: 'img$index',
          transitionOnUserGestures: true,
          child: Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/20$index'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
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
                    style: TextStyle(color: Colors.grey, fontSize: 16),
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
              SizedBox(height: 10),
              Text(
                'this is application that is design reference.',
                style: TextStyle(
                    color: Colors.blueGrey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              onTap: () {},
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    child: Icon(Icons.touch_app),
                  ),
                ),
              ),
              trailing: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }
}
