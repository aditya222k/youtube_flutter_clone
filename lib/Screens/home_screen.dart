import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_youtube_ui/Screens/video_details.dart';
import 'package:flutter_youtube_ui/widgets/video_widget.dart';

import 'package:inview_notifier_list/inview_notifier_list.dart';

import '../widgets/custom_sliver_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CustomSliverAppBar(),
      SliverFillRemaining(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/dataset.json'),
          builder: (context, snapshot) {
            var newData = json.decode(snapshot.data.toString());
            return InViewNotifierList(
              isInViewPortCondition:
                  (double deltaTop, double deltaBottom, double vpHeight) {
                return deltaTop < (0.5 * vpHeight) &&
                    deltaBottom > (0.5 * vpHeight);
              },
              itemCount: newData.length,
              builder: (BuildContext context, int index) {
                final InViewState inViewState = InViewNotifierList.of(context)!;
                inViewState.addContext(context: context, id: '$index');
                return InViewNotifierWidget(
                  id: '$index',
                  builder: (BuildContext context, bool isInView, widget) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print("IsInView --> $isInView & $index");
                      return GestureDetector(
                        onTap: () {
                          print("Hello");
                          Navigator.pushNamed(context, VideoDetails.id,
                              arguments: {
                                "VideoUrl": "${newData[index]['videoUrl']}",
                                "VideoTitle": "${newData[index]['title']}",
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
                                    child: isInView
                                        ? VideoWidget(
                                            autoPlay: isInView,
                                            url: newData[index]['videoUrl'],
                                            play: inViewState.inView('$index'))
                                        : Image(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => print('Navigate to profile'),
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
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 15.0),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Yellow Class • 8k views • 28 days ago ',
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
            );
          },
        ),
      )),
    ]);
  }
}
