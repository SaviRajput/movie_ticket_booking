import 'package:book_my_movie/utils/common/exports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYouTubePlayer extends StatelessWidget {
  final String videoId;

  const MyYouTubePlayer({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true),
      body: YoutubePlayer(
        controller: YoutubePlayerController(initialVideoId: videoId),
        onEnded: (metaData) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
