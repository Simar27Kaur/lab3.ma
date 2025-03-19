import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(PictureFrameApp());
}

class PictureFrameApp extends StatefulWidget {
  @override
  _PictureFrameAppState createState() => _PictureFrameAppState();
}

class _PictureFrameAppState extends State<PictureFrameApp> {
  // Updated image URLs
  final List<String> imageUrls = [
    'https://travloger.in/wp-content/uploads/2024/06/1-3.png',
    'https://miro.medium.com/v2/resize:fit:1200/0*rRA4RsGSdWceDIp-',
    'https://th.bing.com/th/id/R.5001dbc74adc8966691ee6f6046d7adf?rik=NocE5mA%2ba1tflw&riu=http%3a%2f%2f1.bp.blogspot.com%2f-n4NEIcKQMbQ%2fUlkaLxmtD7I%2fAAAAAAAAGmY%2fD3IJ4Qq97iE%2fs1600%2fHeaven%2bon%2bEarth!%2bKashmir%2bValley%2bin%2bPakistan%2b(8).jpg&ehk=kX7E7pN%2bSsm1auPniFzM4usrPMeTgtry7uMZxLIjwr8%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.itoAI5hpPh3-ul-aIBvLAQAAAA?rs=1&pid=ImgDetMain',
  ];

  int currentIndex = 0;
  Timer? _timer;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (isPlaying) {
        setState(() {
          currentIndex = (currentIndex + 1) % imageUrls.length;
        });
      }
    });
  }

  void _togglePauseResume() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Digital Picture Frame')),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 10),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              imageUrl: imageUrls[currentIndex],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: 300,
              height: 300,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _togglePauseResume,
          child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        ),
      ),
    );
  }
}
