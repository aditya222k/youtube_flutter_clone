import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_ui/Screens/video_details.dart';
import 'package:flutter_youtube_ui/widgets/custom_sliver_app_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.history),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          'History',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.55),
                        child: Text('VIEW ALL',
                            style: TextStyle(color: Colors.blue, fontSize: 14)),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    // height: 90,

                    child: FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/dataset.json'),
                      builder: ((context, snapshot) {
                        var newData = json.decode(snapshot.data.toString());

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  // width: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,

                                  child: GestureDetector(
                                    onTap: () {
                                      print("Hello");
                                      Navigator.pushNamed(
                                          context, VideoDetails.id,
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
                                      shadowColor: Colors.transparent,
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                // color: isInView ? Colors.green : Colors.red,
                                                width: double.infinity,
                                                // height: MediaQuery.of(context).size.height *
                                                //     0.31,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Image(
                                                  image: NetworkImage(
                                                    newData[index]
                                                        ['coverPicture'],
                                                  ),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.14,
                                                  // width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              height: 60,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => print(
                                                        'Navigate to profile'),
                                                    child: CircleAvatar(
                                                      foregroundImage: AssetImage(
                                                          'assets/yellowclass.png'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            newData[index]
                                                                ['title'],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.0),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            'Yellow Class • 8k views • 28 days ago ',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Icon(
                                                        Icons.more_vert,
                                                        size: 20.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        Icon(Icons.smart_display),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'Your videos',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07,
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      children: [
                        Icon(Icons.download_sharp),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'Download',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.45),
                          child: Icon(Icons.download_done_rounded),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        Icon(Icons.theaters),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'Your movies',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text("Playlists",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.51),
                        child: Text('Recently added'),
                      ),
                      Icon(Icons.expand_more),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blueAccent,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.04),
                          child: Text('New playlist',
                              style:
                                  // Theme.of(context)
                                  //     .textTheme
                                  //     .bodyText1!
                                  //     .copyWith(fontSize: 16.0),
                                  TextStyle(color: Colors.blue, fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        Icon(Icons.browse_gallery),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'Watch Later',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'Watch Later',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
