import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialWidget extends StatefulWidget {
  final url;

  TutorialWidget(this.url);

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  VideoPlayerController? _controller;
  late YoutubePlayerController controllers;
  Widget placeholder() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
    );
  }

  int state = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.url.toString().endsWith('mp4')) {
      controllers = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(widget.url).toString(),
          flags: YoutubePlayerFlags(autoPlay: false, loop: false));
    }
    print('error found : ${widget.url}');
    if (widget.url.toString().endsWith('.mp4')) {
      _controller = VideoPlayerController.network(
          widget.url ?? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        });
      _controller?.addListener(() {
        setState(() {
          if (state == 0) {
            state = 1;
          } else {
            state = 1;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Here? Watch our quick tutorial",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Learn to invest in Service Bee in just 4 steps",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            if (!widget.url.toString().endsWith('.mp4'))
              YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: controllers),
                  builder: (context, player) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      // child: CachedNetworkImage(
                      //   imageUrl: "https://img.freepik.com/free-psd/youtube-mobile-phone-mockup_106244-1673.jpg?size=626&ext=jpg&ga=GA1.1.1131756573.1638728824",
                      //   height: 200,
                      //   fit: BoxFit.cover,
                      //   width: double.infinity,
                      //   placeholder: (context, _) => placeholder(),
                      //   errorWidget: (context, err, _) => placeholder(),
                      // ),
                      child: SizedBox(width: 400, height: 200, child: player),
                    );
                  }),
            if (widget.url.toString().endsWith('.mp4'))
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state == 1) {
                        _controller?.pause();
                        state = 0;
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      // child: CachedNetworkImage(
                      //   imageUrl: "https://img.freepik.com/free-psd/youtube-mobile-phone-mockup_106244-1673.jpg?size=626&ext=jpg&ga=GA1.1.1131756573.1638728824",
                      //   height: 200,
                      //   fit: BoxFit.cover,
                      //   width: double.infinity,
                      //   placeholder: (context, _) => placeholder(),
                      //   errorWidget: (context, err, _) => placeholder(),
                      // ),
                      child: SizedBox(
                        width: 400,
                        height: 200,
                        child: VideoPlayer(
                          _controller!,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state == 1 ? false : true,
                    child: GestureDetector(
                      onTap: () {
                        _controller?.play();
                        setState(() {
                          state = 1;
                        });
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
