import 'package:flutter/material.dart';

import '../../../flutter_chat_ui_kit.dart';

enum ChatsAlignment { standard, side }

///[CometChatConversationsWithMessages] is a container component that wraps and formats the [CometChatConversations] and [CometChatMessages] component
///
/// it is a wrapper component which provides functionality to open the [CometChatMessages] module with a click of any conversation shown in the conversation list.
///
/// ```dart
///CometChatConversationsWithMessages()
///
/// ```
///
class CometChatConversationsWithMessages extends StatefulWidget {
  const CometChatConversationsWithMessages({
    Key? key,
    required this.onTapUrl,
    this.theme,
    this.conversationConfigurations = const ConversationConfigurations(),
    this.messageConfiguration = const MessageConfiguration(),
    this.stateCallBack,
    this.appBarTrailingWidget,
    this.onTapMessageHeader,
    this.physics,
    this.shrinkWrap = false,
    this.groupTags,
    this.trailingIcon,
    this.onTapTrailingIcon,
  }) : super(key: key);

  ///[onTapUrl] handle url tap inside message bubble
  final Function(String) onTapUrl;

  final CometChatTheme? theme;

  final ConversationConfigurations conversationConfigurations;

  final MessageConfiguration messageConfiguration;

  ///[stateCallBack] a call back to give state to its parent
  final void Function(CometChatConversationsWithMessagesState)? stateCallBack;

  ///[appBarTrailingWidget] to show at the end of appBar
  final Widget? appBarTrailingWidget;

  ///[onTapMessageHeader] handles the tap on message header
  final void Function(String)? onTapMessageHeader;

  final bool shrinkWrap;

  final ScrollPhysics? physics;

  final Set<String>? groupTags;

  final Widget? trailingIcon;

  final void Function(String groupId)? onTapTrailingIcon;

  @override
  State<CometChatConversationsWithMessages> createState() =>
      CometChatConversationsWithMessagesState();
}

class CometChatConversationsWithMessagesState
    extends State<CometChatConversationsWithMessages>
    with CometChatMessageEventListener, CometChatConversationEventListener {
  final String listenerId = "CometChatConversationWithMessage";
  final String conversationListener =
      "CometChatConversationWithMessagesConversationListener";
  CometChatConversationsState? conversationState;
  CometChatMessagesState? messageState;

  conversationStateCallBack(CometChatConversationsState _conversationState) {
    conversationState = _conversationState;
  }

  messageStateCallBack(CometChatMessagesState _messageState) {
    messageState = _messageState;
  }

  @override
  void onConversationTap(Conversation conversation) {
    String? _userId;
    String? _groupId;
    if (conversation.conversationType == ReceiverTypeConstants.user) {
      _userId = (conversation.conversationWith as User).uid;
    } else if (conversation.conversationType == ReceiverTypeConstants.group) {
      _groupId = (conversation.conversationWith as Group).guid;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatMessages(
            showAppBar: true,
            onTapUrl: widget.onTapUrl,
            user: _userId,
            group: _groupId,
            theme: widget.theme,
            enableSoundForMessages:
                widget.messageConfiguration.enableSoundForMessages,
            enableTypingIndicator:
                widget.messageConfiguration.enableTypingIndicator,
            messageComposerConfiguration:
                widget.messageConfiguration.messageComposerConfiguration,
            messageListConfiguration:
                widget.messageConfiguration.messageListConfiguration,
            messageHeaderConfiguration:
                widget.messageConfiguration.messageHeaderConfiguration,
            hideMessageComposer:
                widget.messageConfiguration.hideMessageComposer,
            messageTypes: widget.messageConfiguration.messageTypes,
            excludeMessageTypes:
                widget.messageConfiguration.excludeMessageTypes,
            stateCallBack: messageStateCallBack,
            notifyParent: changeActiveId,
            trailingIcon: widget.trailingIcon,
            onTapTrailingIcon: widget.onTapTrailingIcon,
            onTapMessageHeader: widget.onTapMessageHeader,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    CometChatMessageEvents.addMessagesListener(listenerId, this);
    CometChatConversationEvents.addConversationListListener(
        conversationListener, this);
    if (widget.stateCallBack != null) {
      widget.stateCallBack!(this);
    }
  }

  @override
  void dispose() {
    super.dispose();
    CometChatMessageEvents.removeMessagesListener(listenerId);
    CometChatConversationEvents.removeConversationListListener(
        conversationListener);
  }

  changeActiveId(String? id) {
    conversationState?.conversationListState?.activeID = id;
  }

  @override
  Widget build(BuildContext context) {
    return CometChatConversations(
      conversationType: widget.conversationConfigurations.conversationType,
      showBackButton: widget.conversationConfigurations.showBackButton,
      theme: widget.theme,
      title: widget.conversationConfigurations.title,
      hideSearch: widget.conversationConfigurations.hideSearch,
      backButton: widget.conversationConfigurations.backButton,
      hideStartConversation:
          widget.conversationConfigurations.hideStartConversation,
      search: widget.conversationConfigurations.search,
      startConversationIcon:
          widget.conversationConfigurations.startConversationIcon,
      avatarConfiguration:
          widget.conversationConfigurations.avatarConfiguration,
      badgeCountConfiguration:
          widget.conversationConfigurations.badgeCountConfiguration,
      conversationListItemConfiguration:
          widget.conversationConfigurations.conversationListItemConfiguration,
      dateConfiguration: widget.conversationConfigurations.dateConfiguration,
      messageReceiptConfiguration:
          widget.conversationConfigurations.messageReceiptConfiguration,
      statusIndicatorConfiguration:
          widget.conversationConfigurations.statusIndicatorConfiguration,
      conversationListConfiguration:
          widget.conversationConfigurations.conversationListConfiguration ??
              const ConversationListConfigurations(),
      stateCallBack: conversationStateCallBack,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      groupTags: widget.groupTags,
    );
  }
}
