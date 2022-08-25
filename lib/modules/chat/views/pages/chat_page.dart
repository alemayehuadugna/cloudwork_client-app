import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../domain/entities/conversation.dart';
import '../../router.dart';
import '../bloc/conversation_bloc/conversation_bloc.dart';
import '../bloc/message_bloc/message_bloc.dart';
import '../bloc/selected_conversation/selected_conversation_cubit.dart';

class Message {
  final bool isSender;
  final String message;
  final String sentTime;

  Message(this.isSender, this.message, this.sentTime);
}

final messageList = [
  Message(
    true,
    "Good morning, How are you? What about our next meeting?",
    "10:02 AM",
  ),
  Message(
    false,
    "Good morning",
    "10.04 AM",
  ),
  Message(
    true,
    "I am good thanks",
    "10.25 AM",
  ),
  Message(
    false,
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor",
    "10.28 AM",
  ),
];

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = GoRouter.of(context).location;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 56,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            flex: 2,
            child: _Conversation(),
          ),
          if (route != '/chat')
            const Expanded(
              flex: 4,
              child: Messages(),
            ),
          if (route == '/chat')
            Expanded(
              flex: 4,
              child: Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/messages-chat.svg',
                        height: 300,
                        width: 300,
                      ),
                      const SizedBox(height: 10),
                      Text("Select Conversation, to start chatting",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 56,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Expanded(
            flex: 2,
            child: _Conversation(),
          ),
          Expanded(
            flex: 4,
            child: Messages(),
          ),
        ],
      ),
    );
  }
}

class ChatMobilePage extends StatelessWidget {
  const ChatMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Conversation();
  }
}

class MessageMobilePage extends StatelessWidget {
  const MessageMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: const Messages(),
    );
  }
}

class _Conversation extends StatelessWidget {
  const _Conversation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          splashRadius: 24,
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0.5),
                if (state is ConversationLoaded)
                  SizedBox(
                    height: ResponsiveWrapper.of(context).isMobile
                        ? MediaQuery.of(context).size.height - 130 - 55
                        : MediaQuery.of(context).size.height - 130,
                    child: ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        return ConversationTile(
                          conversation: state.conversations[index],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String currentUserId = '';
        String userName = '';
        String profilePicture = '';
        if (state is Authenticated) {
          currentUserId = state.user.id;
        }
        for (var e in conversation.members) {
          if (e.userId != currentUserId) {
            userName = "${e.user!.firstName} ${e.user!.lastName}";
            profilePicture = e.user!.profilePicture;
          }
        }
        return InkWell(
          onTap: () {
            BlocProvider.of<SelectedConversationCubit>(context)
                .selectConversation(conversation);

            BlocProvider.of<MessageBloc>(context)
                .add(LoadMessageEvent(conversation.id, null, null));

            context.goNamed(conversationRouteName,
                params: {"conversationId": conversation.id});
          },
          child:
              BlocBuilder<SelectedConversationCubit, SelectedConversationState>(
            builder: (context, state) {
              bool isSelected = false;
              if (state is SelectedConversationSuccess) {
                isSelected = state.conversation.id == conversation.id;
              }
              return Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.09)
                      : null,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.2),
                    ),
                  ),
                ),
                height: 75,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: profilePicture == 'profile_image_url'
                              ? Text(
                                  userName.characters.first.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                )
                              : Image.network(profilePicture),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              conversation.lastMessage != null
                                  ? conversation.lastMessage!.content
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? _messageField = TextEditingController();
    String conversationId = '';
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String currentUserId = '';
        if (state is Authenticated) {
          currentUserId = state.user.id;
        }
        return BlocBuilder<SelectedConversationCubit,
            SelectedConversationState>(
          builder: (context, state) {
            if (state is SelectedConversationSuccess) {
              conversationId = state.conversation.id;
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    const MessageHeader(),
                    const Divider(height: 0.5),
                    Expanded(
                      child: BlocBuilder<MessageBloc, MessageState>(
                        builder: (context, state) {
                          if (state is MessageLoaded) {
                            var list =
                                state.messageMapList[conversationId] ?? [];
                            return SizedBox(
                                child: ListView.builder(
                              reverse: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return MessageTile(
                                  isSender:
                                      currentUserId == list[index].senderId,
                                  message: list[index].content,
                                  sentTime: list[index].sentAt,
                                );
                              },
                            ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RawKeyboardListener(
                          focusNode: FocusNode(onKey: (node, event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              return KeyEventResult
                                  .handled; // prevent passing the event into the TextField
                            }
                            return KeyEventResult
                                .ignored; // pass the event to the TextField
                          }),
                          onKey: (event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              // Do something
                              // print("messageToSend: ${_messageField.text}");
                              if (_messageField.text.isNotEmpty) {
                                BlocProvider.of<ConversationBloc>(context).add(
                                  SendMessageEvent(
                                    conversationId,
                                    _messageField.text,
                                  ),
                                );
                                _messageField.text = '';
                              }
                            }
                          },
                          child: TextFormField(
                            textInputAction: TextInputAction.send,
                            controller: _messageField,
                            minLines: 1,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.emoji_emotions),
                              ),
                              // pre
                              suffixIcon: SizedBox(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.attach_file),
                                      splashRadius: 24,
                                    ),
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        if (_messageField.text.isNotEmpty) {
                                          BlocProvider.of<ConversationBloc>(
                                                  context)
                                              .add(
                                            SendMessageEvent(
                                              conversationId,
                                              _messageField.text,
                                            ),
                                          );
                                          _messageField.text = '';
                                        }
                                      },
                                      icon: const Icon(Icons.send),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MessageHeader extends StatelessWidget {
  const MessageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedConversationCubit, SelectedConversationState>(
      builder: (context, state) {
        var conversation = Conversation(null, id: "", members: []);
        if (state is SelectedConversationSuccess) {
          conversation = state.conversation;
        }
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String currentUserId = '';
            String userName = '';
            String profilePicture = '';
            if (state is Authenticated) {
              currentUserId = state.user.id;
            }
            for (var e in conversation.members) {
              if (e.userId != currentUserId) {
                userName = "${e.user!.firstName} ${e.user!.lastName}";
                profilePicture = e.user!.profilePicture;
              }
            }
            return SizedBox(
              height: 75,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: profilePicture == 'profile_image_url'
                            ? Text(
                                userName.characters.first.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              )
                            : Image.network(profilePicture),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "online",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                    const SizedBox(width: 10),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        const PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.visibility),
                            title: Text('Profile'),
                          ),
                        ),
                        const PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MessageTile extends StatefulWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.sentTime,
    required this.isSender,
  }) : super(key: key);

  final String message;
  final DateTime sentTime;
  final bool isSender;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  Timer? timer;
  String sentAt = '';

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 55), (Timer t) {
      setState(() {
        sentAt = Jiffy(widget.sentTime).fromNow();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sentAt = Jiffy(widget.sentTime).fromNow();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (widget.isSender) const SizedBox(width: 50),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: widget.isSender
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: widget.isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    sentAt,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                  )
                ],
              ),
            ),
          ),
          if (!widget.isSender) const SizedBox(width: 50),
        ],
      ),
    );
  }
}
