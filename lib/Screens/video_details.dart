import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube_ui/widgets/video_items.dart';

class VideoDetails extends StatefulWidget {
  static String id = "video_details";

  const VideoDetails({Key? key}) : super(key: key);

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    final videoDetails = ModalRoute.of(context)!.settings.arguments as Map;
    String VideoUrl = videoDetails["VideoUrl"];
    String VideoTitle = videoDetails["VideoTitle"];
    String CoverPicture = videoDetails["CoverPicture"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 220,
                  color: Colors.black,
                  child: VideoListItems(
                    looping: true,
                    autoPlay: true,
                    videoPlayerController:
                        VideoPlayerController.network(VideoUrl),
                  ),
                ),
                // Image.network(
                //   selectedVideo!.thumbnailUrl,
                //   height: 220.0,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
                IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {}),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    VideoTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '8k views • 28 days ago',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14.0),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAction(context, Icons.thumb_up_outlined, '200'),
                    _buildAction(context, Icons.thumb_down_outlined, '2'),
                    _buildAction(context, Icons.reply_outlined, 'Share'),
                    _buildAction(context, Icons.download_outlined, 'Download'),
                    _buildAction(context, Icons.library_add_outlined, 'Save'),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: buildOwnerData(context),
                ),
                const Divider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/dataset.json'),
                    builder: (context, snapshot) {
                      var newData = json.decode(snapshot.data.toString());
                      return ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return GestureDetector(
                              onTap: () {
                                print("Hello");
                                Navigator.pushNamed(context, VideoDetails.id,
                                    arguments: {
                                      "VideoUrl":
                                          "${newData[index]['videoUrl']}",
                                      "VideoTitle":
                                          "${newData[index]['title']}",
                                      "CoverPicture":
                                          "${newData[index]['coverPicture']}",
                                    });
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          // color: isInView ? Colors.green : Colors.red,
                                          width: double.infinity,
                                          // height: MediaQuery.of(context).size.height *
                                          //     0.31,
                                          height: 220,
                                          child: Image(
                                            image: NetworkImage(
                                              newData[index]['coverPicture'],
                                            ),
                                            height: 220,
                                            // width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                print('Navigate to profile'),
                                            child: CircleAvatar(
                                              foregroundImage: AssetImage(
                                                  'assets/yellowclass.png'),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    newData[index]['title'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 15.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'Yellow Class • 8k views • 28 days ago ',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                            fontSize: 14.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Icon(Icons.more_vert,
                                                size: 20.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildOwnerData(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Navigate to profile'),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: AssetImage('assets/yellowclass.png'),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Yellow Class',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                ),
                Flexible(
                  child: Text(
                    '100k subscribers',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: Colors.pink,
            ),
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
