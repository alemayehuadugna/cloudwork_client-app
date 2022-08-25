import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/conversation.dart';

part 'selected_conversation_state.dart';

class SelectedConversationCubit extends Cubit<SelectedConversationState> {
  SelectedConversationCubit() : super(SelectedConversationInitial());

  void selectConversation(Conversation conversation) {
    emit(SelectedConversationSuccess(conversation));
  }
}
