part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class StartConversationEvent extends ConversationEvent {
  final String userId;
  final String otherUserId;

  const StartConversationEvent(this.userId, this.otherUserId);

  @override
  List<Object> get props => [userId, otherUserId];
}

class ListConversationEvent extends ConversationEvent {
  final List<Conversation> list;

  const ListConversationEvent(this.list);

  @override
  List<Object> get props => [list];
}

class SendMessageEvent extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendMessageEvent(
    this.conversationId,
    this.content,
  );

  @override
  List<Object> get props => [conversationId, content];
}
