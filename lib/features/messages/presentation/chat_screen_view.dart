
import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:discussion_forum/core/common/widgets/appwrite_app.dart';
import 'package:discussion_forum/core/common/widgets/avatar.dart';
import 'package:discussion_forum/core/common/widgets/display_error_message.dart';
import 'package:discussion_forum/core/common/widgets/helpers.dart';
import 'package:discussion_forum/core/common/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreen extends StatefulWidget {
  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
        builder: (context) => StreamChannel(
          channel: channel,
          child: const ChatScreen(),
        ),
      );

  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    super.initState();

    unreadCountSubscription = StreamChannel.of(context)
        .channel
        .state!
        .unreadCountStream
        .listen(_unreadCountHandler);
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const _AppBarTitle(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.video_camera_solid,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.phone_solid,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListCore(
                loadingBuilder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
                emptyBuilder: (context) => const SizedBox.shrink(),
                errorBuilder: (context, error) =>
                    DisplayErrorMessage(error: error),
                messageListBuilder: (context, messages) =>
                    _MessageList(messages: messages),
              ),
            ),
            const _ActionBar(),
          ],
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message.user?.id == context.currentUser?.id) {
            return _MessageOwnTile(message: message);
          } else {
            return _MessageTile(message: message);
          }
        },
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Text(
              message.text ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Text(
              message.text ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
  late String dayInfo;

  @override
  void initState() {
    final createdAt = Jiffy.parseFromDateTime(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy.parseFromDateTime(createdAt.dateTime)
        .isSame(Jiffy.parseFromDateTime(now))) {
      dayInfo = 'TODAY';
    } else if (Jiffy.parseFromDateTime(createdAt.dateTime).isSame(
        Jiffy.parseFromDateTime(now.subtract(const Duration(days: 1))))) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy.parseFromDateTime(createdAt.dateTime).isAfter(
      Jiffy.parseFromDateTime(now.subtract(const Duration(days: 7))),
    )) {
      dayInfo = createdAt.format(pattern: 'EEEE');
    } else if (Jiffy.parseFromDateTime(createdAt.dateTime).isAfter(
      Jiffy.parseFromDateTime(now).subtract(years: 1),
    )) {
      dayInfo = createdAt.format(pattern: 'MMMd');
    } else {
      dayInfo = createdAt.format(pattern: 'MMMd');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Row(
      children: [
        Avatar.small(
          url: Helpers.getChannelImage(channel, context.currentUser!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              BetterStreamBuilder<List<Member>>(
                stream: channel.state!.membersStream,
                initialData: channel.state!.members,
                builder: (context, data) => ConnectionStatusBuilder(
                  statusBuilder: (context, status) {
                    switch (status) {
                      case ConnectionStatus.connected:
                        return _buildConnectedTitleState(context, data);
                      case ConnectionStatus.connecting:
                        return const Text(
                          'Connecting',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      case ConnectionStatus.disconnected:
                        return const Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildConnectedTitleState(
    BuildContext context,
    List<Member>? members,
  ) {
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = 'Members: $memberCount';
      final watcherCount = channel.state?.watcherCount ?? 0;
      if (watcherCount > 0) {
        text = 'watchers $watcherCount';
      }
      alternativeWidget = Text(
        text,
      );
    } else {
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members?.firstWhereOrNull(
        (element) => element.userId != userId,
      );

      if (otherMember != null) {
        if (otherMember.user?.online == true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last online: '
            '${Jiffy.parseFromDateTime(otherMember.user?.lastActive ?? DateTime.now()).fromNow()}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }
      }
    }

    return TypingIndicator(
      alternativeWidget: alternativeWidget,
    );
  }
}

/// Widget to show the current list of typing users
class TypingIndicator extends StatelessWidget {
  /// Instantiate a new TypingIndicator
  const TypingIndicator({
    Key? key,
    this.alternativeWidget,
  }) : super(key: key);

  /// Widget built when no typings is happening
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = StreamChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const SizedBox.shrink();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream
          .map((typings) => typings.entries.map((e) => e.key)),
      builder: (context, data) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty == true
                ? const Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey('typing-text'),
                    child: Text(
                      'Typing message',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    key: const ValueKey('altwidget'),
                    child: altWidget,
                  ),
          ),
        );
      },
    );
  }
}

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream] of type [ConnectionStatus].
///
/// The widget will use the closest [StreamChatClient.wsConnectionStatusStream]
/// in case no stream is provided.
class ConnectionStatusBuilder extends StatelessWidget {
  /// Creates a new ConnectionStatusBuilder
  const ConnectionStatusBuilder({
    Key? key,
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  /// The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  /// The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  /// The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status)
      statusBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ??
        StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = StreamChatCore.of(context).client;
    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      StreamChannel.of(context)
          .channel
          .sendMessage(Message(text: _controller.text));
      _controller.clear(); // This line clears the input field
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey[600]!,
              width: 0.3,
            ),
          ),
        ),
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.camera_fill,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
