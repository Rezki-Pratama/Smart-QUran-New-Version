import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_quran_new_version/pages/listAyat.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  Animation sizeAnimation, menuAnimation, slideAnimation;
  int flareAnimation = 0;

  myItems(IconData icon, String heading, int color) {
    return Material(
      color: Color(0xFF4ba592),
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: FlareActor(
              'assets/flare/wave.flr',
              animation: 'Untitled',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Icon
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),

                //Text
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    heading,
                    style: TextStyle(color: Color(color), fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  myItem(IconData icon, String heading, String numberOfAyat, int color) {
    return Material(
      color: Color(0xFF4ba592),
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Icon
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                    child: Text(
                  numberOfAyat,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xFF4ba592)),
                )),
              ],
            ),

            //Text
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                heading,
                style: TextStyle(color: Color(color), fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: 70, end: 100).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    sizeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    menuAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    slideAnimation = Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    new Timer(new Duration(seconds: 3), () {
      setState(() {
        animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFe4f2f5),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            FlareActor(
              'assets/flare/SmartQuran.flr',
              animation: (flareAnimation == 0) ? 'splash' : 'getstarted',
              fit: BoxFit.cover,
            ),
            (flareAnimation == 1)
                ? Opacity(
                    opacity: menuAnimation.value,
                    child: Container(
                      color: Color(0xFFe4f2f5),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      child: Padding(
                        padding: EdgeInsets.only(top: slideAnimation.value),
                        child: Container(
                          child: StaggeredGridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            children: <Widget>[
                              myItem(FontAwesomeIcons.certificate,
                                  'Al - Fatihah', '1', 0xFFFFFFFF),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListAyat()),
                                  );
                                },
                                child: myItems(FontAwesomeIcons.quran,
                                    'Al - Quran', 0xFFFFFFFF),
                              ),
                              myItems(FontAwesomeIcons.compass, 'Kiblat',
                                  0xFFFFFFFF),
                              myItems(
                                  FontAwesomeIcons.book, 'Haddist', 0xFFFFFFFF),
                              myItems(FontAwesomeIcons.bookOpen, 'Tajwid',
                                  0xFFFFFFFF),
                            ],
                            staggeredTiles: [
                              StaggeredTile.extent(2, 100.0),
                              StaggeredTile.extent(1, 140.0),
                              StaggeredTile.extent(1, 110.0),
                              StaggeredTile.extent(1, 140.0),
                              StaggeredTile.extent(1, 110.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: animation.value,
                    child: Opacity(
                      opacity: sizeAnimation.value,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            flareAnimation = 1;
                            animationController.reverse();
                            print(flareAnimation);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF4ba592),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: Offset(
                                      1, 4), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ));
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
