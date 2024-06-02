import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/widgets/helpers.dart';
import 'package:discussion_forum/features/messages/data/model/message_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class StackOverflowDashboard extends StatelessWidget {
  const StackOverflowDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
          ),
          SizedBox(
              width: 16), // Add some spacing between the avatar and the edge
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(_delegate),
          ),
        ],
      ),
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    final formattedDate = Jiffy.parseFromDateTime(date).fromNow();
    return _MessageTile(
        messagedata: Messagedata(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: formattedDate,
      profile: Helpers.randomPictureUrl(),
    ));
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.messagedata}) : super(key: key);

  final Messagedata messagedata;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Navigator.pushNamed(
          context,
          AppRoute.chatsScreenRoute,
          arguments: messagedata,
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    messagedata.profile,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        messagedata.senderName,
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
                      child: Text(
                        messagedata.message,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    messagedata.dateMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
