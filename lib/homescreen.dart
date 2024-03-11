import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> items = [];

  late Timer _timer;
  bool _showCircleAvatar = true;

  @override
  void initState() {
    super.initState();
    // Start the timer when the screen is loaded
    _timer = Timer(Duration(seconds: 3), () {
      // Hide the circle avatar after 3 seconds
      setState(() {
        _showCircleAvatar = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _addItem() {
    final int newIndex = items.length;
    items.add('Item ${newIndex + 1}');
    _listKey.currentState!.insertItem(newIndex);
  }

  void _removeItem(int index) {
    String removedItem = items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => buildItem(removedItem, animation, index),
    );
  }

  Widget buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          title: Text(item),
          subtitle: Text('\$10'), // You can replace this with the actual price
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://img.etimg.com/thumb/width-640,height-480,imgsize-134270,resizemode-75,msid-101364497/top-trending-products/lifestyle/top-7-adidas-sneakers-for-men-starting-at-rs-2253.jpg'), // Replace with actual shoe image
          ),
          onTap: () {
            _removeItem(index);
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen'),
        actions: _showCircleAvatar
            ? []
            : [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/splashscreen.png'),
              radius: 16,
            ),
          ),
        ],
      ),
      body: _showCircleAvatar ? Center(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: _showCircleAvatar ? 1.0 : 0.0,
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/splashscreen.png'),
            radius: 50,
          ),
        ),
       ) : Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return buildItem(items[index], animation, index);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                _addItem();
              },
              child: Text('Add Item'),
            ),
          ),
        ],
      )
    );
  }
}
