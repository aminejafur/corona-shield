import 'package:flutter/material.dart';
import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/ui/singup.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mcovidshield/util/screen_navigation.dart';
import 'package:mcovidshield/util/style.dart';

class OnBoardingPage extends StatefulWidget {
  final Tracker tracker;
  OnBoardingPage(this.tracker);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    pushScreen(context, Singup(widget.tracker));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "M-Corona Shield",
          body:
          "The moroccan corona shield, consectetur adipiscing elit. Integer sed mattis orci.",
          image: _buildImage('medical'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "This Mobile App will",
          body:
          "Sed in orci leo. Duis maximus massa libero, at posuere ipsum ullamcorper eu.",
          image: _buildImage('arround'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Another title for this page",
          body:
          "Phasellus condimentum gravida purus. Duis scelerisque neque et odio iaculis rutrum.",
          image: _buildImage('out'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Stay home, Stay safe",
          body: "Vivamus sed rutrum velit, vitae consectetur dolor.",
          image: _buildImage('list_colide'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Last page title",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),
          footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Repeat',
              style: TextStyle(color: Colors.white),
            ),
            color: MyColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          image: _buildImage('check'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFF1B5E20),
        activeColor: Color(0xFFDD2C00),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
