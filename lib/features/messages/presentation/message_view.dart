// import 'package:discussion_forum/core/common/widgets/appwrite_app.dart';
// import 'package:discussion_forum/core/common/widgets/avatar.dart';
// import 'package:discussion_forum/core/common/widgets/display_error_message.dart';
// import 'package:discussion_forum/core/common/widgets/helpers.dart';
// import 'package:discussion_forum/core/common/widgets/unread_indicator.dart';
// import 'package:discussion_forum/features/messages/data/model/story_data.dart';
// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

// class StackOverflowDashboard extends StatelessWidget {
//   const StackOverflowDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final channelListController = StreamChannelListController(
//       client: StreamChatCore.of(context).client,
//       filter: Filter.and(
//         [
//           Filter.equal('type', 'messaging'),
//           Filter.in_('members', [
//             StreamChatCore.of(context).currentUser!.id,
//           ])
//         ],
//       ),
//     );
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Add your search functionality here
//             },
//           ),
//           actions: const [
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//               ),
//             ),
//             SizedBox(
//                 width: 16), // Add some spacing between the avatar and the edge
//           ],
//         ),
//         body: PagedValueListenableBuilder<int, Channel>(
//           valueListenable: channelListController,
//           builder: (context, value, child) {
//             return value.when(
//               (channels, nextPageKey, error) {
//                 print("Channels length: ${channels.length}");
//                 if (channels.isEmpty) {
//                   return const Center(
//                     child: Text('So empty.\nGo and message someone.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                             color: Colors.black)),
//                   );
//                 }
//                 return LazyLoadScrollView(
//                   onEndOfPage: () async {
//                     if (nextPageKey != null) {
//                       channelListController.loadMore(nextPageKey);
//                     }
//                   },
//                   child: CustomScrollView(
//                     slivers: [
//                       const SliverToBoxAdapter(
//                         child: _Stories(),
//                       ),
//                       SliverList(
//                         delegate: SliverChildBuilderDelegate(
//                           (context, index) {
//                             return _MessageTile(
//                               channel: channels[index],
//                             );
//                           },
//                           childCount: channels.length,
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//               loading: () => const Center(
//                 child: SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//               error: (e) => DisplayErrorMessage(
//                 error: e,
//               ),
//             );
//           },
//         ));
//   }
// }

// // Widget _delegate(BuildContext context, int index) {
// //   final Faker faker = Faker();
// //   final date = Helpers.randomDate();
// //   final formattedDate = Jiffy.parseFromDateTime(date).fromNow();
// //   return _MessageTile(
// //       messagedata: Messagedata(
// //     senderName: faker.person.name(),
// //     message: faker.lorem.sentence(),
// //     messageDate: date,
// //     dateMessage: formattedDate,
// //     profile: Helpers.randomPictureUrl(),
// //   ));

// // }

// class _MessageTile extends StatelessWidget {
//   const _MessageTile({
//     Key? key,
//     required this.channel,
//   }) : super(key: key);

//   final Channel channel;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Navigator.of(context).push;
//       },
//       child: Container(
//         height: 100,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Theme.of(context).dividerColor,
//               width: 0.5,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Avatar.medium(
//                     url:
//                         Helpers.getChannelImage(channel, context.currentUser!)),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         Helpers.getChannelName(channel, context.currentUser!),
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           letterSpacing: 0.2,
//                           wordSpacing: 1.5,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                       child: _buildLastMessage(),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     _buildLastMessageAt(),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Center(
//                       child: UnreadIndicator(
//                         channel: channel,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLastMessage() {
//     return BetterStreamBuilder<int>(
//       stream: channel.state!.unreadCountStream,
//       initialData: channel.state?.unreadCount ?? 0,
//       builder: (context, count) {
//         return BetterStreamBuilder<Message>(
//           stream: channel.state!.lastMessageStream,
//           initialData: channel.state!.lastMessage,
//           builder: (context, lastMessage) {
//             return Text(
//               lastMessage.text ?? '',
//               overflow: TextOverflow.ellipsis,
//               style: (count > 0)
//                   ? const TextStyle(
//                       fontSize: 12,
//                     )
//                   : const TextStyle(
//                       fontSize: 12,
//                     ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildLastMessageAt() {
//     return BetterStreamBuilder<DateTime>(
//       stream: channel.lastMessageAtStream,
//       initialData: channel.lastMessageAt,
//       builder: (context, data) {
//         final lastMessageAt = data.toLocal();
//         String stringDate;
//         final now = DateTime.now();

//         final startOfDay = DateTime(now.year, now.month, now.day);

//         if (lastMessageAt.millisecondsSinceEpoch >=
//             startOfDay.millisecondsSinceEpoch) {
//           stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).jm;
//         } else if (lastMessageAt.millisecondsSinceEpoch >=
//             startOfDay
//                 .subtract(const Duration(days: 1))
//                 .millisecondsSinceEpoch) {
//           stringDate = 'YESTERDAY';
//         } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
//           stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).EEEE;
//         } else {
//           stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).yMd;
//         }
//         return Text(
//           stringDate,
//           style: const TextStyle(
//             fontSize: 11,
//             letterSpacing: -0.2,
//             fontWeight: FontWeight.w600,
//           ),
//         );
//       },
//     );
//   }
// }

// class _Stories extends StatelessWidget {
//   const _Stories({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Card(
//         elevation: 0,
//         child: SizedBox(
//           height: 140,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
//                 child: Text(
//                   'Stories',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w900,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     final faker = Faker();
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         width: 60,
//                         child: _StoryCard(
//                           storyData: StoryData(
//                             name: faker.person.firstName(),
//                             url: Helpers.randomPictureUrl(),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _StoryCard extends StatelessWidget {
//   const _StoryCard({
//     Key? key,
//     required this.storyData,
//   }) : super(key: key);

//   final StoryData storyData;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Avatar.medium(url: storyData.url),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Text(
//               storyData.name,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 11,
//                 letterSpacing: 0.3,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:discussion_forum/core/common/widgets/avatar.dart';
import 'package:discussion_forum/core/common/widgets/helpers.dart';
import 'package:discussion_forum/core/common/widgets/unread_indicator.dart';
import 'package:discussion_forum/features/messages/data/model/story_data.dart';
import 'package:discussion_forum/features/messages/presentation/chat_screen.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [
          StreamChatCore.of(context).currentUser!.id,
        ])
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    print("Initializing MessagesPage...");
    channelListController.doInitialLoad();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: PagedValueListenableBuilder<int, Channel>(
        valueListenable: channelListController,
        builder: (context, value, child) {
          print("Building PagedValueListenableBuilder...");
          return value.when(
            (channels, nextPageKey, error) {
              print("Channels loaded: ${channels.length}");
              if (channels.isEmpty) {
                return const Center(
                  child: Text(
                    'So empty.\nGo and message someone.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return LazyLoadScrollView(
                onEndOfPage: () async {
                  if (nextPageKey != null) {
                    channelListController.loadMore(nextPageKey);
                  }
                },
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: _Stories(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _MessageTile(
                            channel: channels[index],
                          );
                        },
                        childCount: channels.length,
                      ),
                    )
                  ],
                ),
              );
            },
            loading: () {
              print("Loading channels...");
              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (e) {
              print("Error loading channels: $e");
              return DisplayErrorMessage(
                error: e,
              );
            },
          );
        },
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                    url: Helpers.getChannelImage(
                        channel, StreamChatCore.of(context).currentUser!)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        Helpers.getChannelName(
                            channel, StreamChatCore.of(context).currentUser!),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: _buildLastMessage(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: UnreadIndicator(
                        channel: channel,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: (count > 0)
                  ? const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    )
                  : const TextStyle(
                      fontSize: 12,
                    ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();
        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal())
              .format(pattern: 'jm');
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal())
              .format(pattern: 'EEEE');
        } else {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal())
              .format(pattern: 'yMd');
        }

        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 0,
        child: SizedBox(
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
                child: Text(
                  'Stories',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                          storyData: StoryData(
                            name: faker.person.firstName(),
                            url: Helpers.randomPictureUrl(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DisplayErrorMessage extends StatelessWidget {
  final Object error;

  const DisplayErrorMessage({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text('Error: $error'),
        ],
      ),
    );
  }
}