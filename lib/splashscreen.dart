import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool hide = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 40.0
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HomeScreen()));
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
           Stack(alignment: Alignment.center,
            children: [
              FadeInUp(child: CircleAvatar(radius: 235,foregroundImage:  NetworkImage(
                  "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGYtczExMy1hay02MDIwLTAxYS5qcGc.jpg"),
                backgroundImage: NetworkImage(
                    "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGYtczExMy1hay02MDIwLTAxYS5qcGc.jpg"),
              ), ),
              FadeInUp(child: Image.asset("assets/images/splashscreen.png"),)
            ],
          ),
          FadeInUp(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find the perfect",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Shoes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Everyday",
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 35,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 44,
          ),
          FadeInUp(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "More than 20 thousand shoes of",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  "attractive and cool.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height/34,
          ),
          InkWell(
            onTap: () {
              setState(() {
                hide = true;
              });
              _scaleController.forward();
            },
            child: AnimatedBuilder(
              animation: _scaleController,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: FadeInUp(duration: Duration(milliseconds: 1500), child: Container(
                  width: size.width/1.5,
                  height: size.height/18,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: hide == false ? FadeInUp(child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold),)) : Container(),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
