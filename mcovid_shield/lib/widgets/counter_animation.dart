import 'package:flutter/material.dart';

class AnimatedCount extends StatefulWidget {
  final String status;
  final int count;

  AnimatedCount({Key key, @required this.status, this.count = 0}) : super(key: key);

  @override
  _AnimatedCountState createState() => new _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController _controller;
  String i = 0.toString();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration:const Duration(seconds: 3), vsync: this);
    animation =Tween<double>(begin: 0, end: double.parse(widget.count.toString())).animate(_controller)
      ..addListener((){
        setState((){
           i = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(i , textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w200),),
        SizedBox(width: 10,),
        Text('${widget.status}' , textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w200),)
      ],
    );
  }
}