import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../flutter_chat_ui_kit.dart';

///[CometChatConversationsWithMessages] is a container component that wraps and formats the [CometChatConversations] and [CometChatMessages] component
///
/// it is a wrapper component which provides functionality to open the [CometChatMessages] module with a click of any conversation shown in the conversation list.
///
/// ```dart
///     CometChatConversationsWithMessages(
///       user: User(
///           uid: 'superhero2',
///           name: 'Captain America',
///           avatar:
///               'https://data-us.cometchat.io/assets/images/avatars/captainamerica.png',
///           ),
///       group: Group(
///         guid: 'guid',
///         name: 'group name',
///         type: 'group type'
///       ),
///       conversationsConfiguration: ConversationsConfiguration(
///           conversationsRequestBuilder: ConversationsRequestBuilder(),
///           conversationsStyle: ConversationsStyle(),
///           listItemStyle: ListItemStyle()),
///       messageConfiguration: MessageConfiguration(
///           messageHeaderConfiguration:
///               MessageHeaderConfiguration(),
///           messageListConfiguration:
///               MessageListConfiguration(),
///           messageComposerConfiguration:
///               MessageComposerConfiguration(),
///           detailsConfiguration:
///               DetailsConfiguration(),
///           messagesStyle: MessagesStyle()),
///       theme: CometChatTheme(
///           palette: Palette(),
///           typography: Typography()),
///     )
/// ```
///
class CometChatConversationsWithMessages extends StatefulWidget {
  const CometChatConversationsWithMessages({
    Key? key,
    this.user,
    this.group,
    this.theme,
    this.conversationsConfiguration,
    this.messageConfiguration,
    this.hideAppBar = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.trailingIcon,
    this.onTapTrailingIcon,
    this.onTapUrl,
    this.onTapItem,
    this.onAddMediaClick,
    this.onSendMessageClick,
    this.onTapChatPageHeader,
    this.groupIDs,
  }) : super(key: key);

  ///[hideAppBar] toggle visibility of AppBar
  final bool hideAppBar;

  ///[padding] padding
  final EdgeInsetsGeometry? padding;

  ///[shrinkWrap] shrinkWrap for listview
  final bool shrinkWrap;

  ///[physics] physics for listview
  final ScrollPhysics? physics;

  ///[header trailing Icon]
  final Widget? trailingIcon;

  ///[header trailing Icon click]
  final void Function(String groupId)? onTapTrailingIcon;

  ///[onTapUrl] handle url tap inside message bubble
  final Function(String)? onTapUrl;

  ///[on Tap groups chat listing Item]
  final Function(String guid)? onTapItem;

  ///[add media option click in chat screen]
  final Function(String guid, String mediaType)? onAddMediaClick;

  ///[send button click in chat screen]
  final Function(String guid, String messageType)? onSendMessageClick;

  ///[on Tap chat page Header] handles the tap on chat page header
  final void Function(String)? onTapChatPageHeader;

  ///[selected groups ids] fetch only selected groups
  final Set<String>? groupIDs;

  ///[user] if null will return [CometChatConversations] screen else will navigate to [CometChatMessages]
  final User? user;

  ///[group] if null will return [CometChatConversations] screen else will navigate to [CometChatMessages]
  final Group? group;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[conversationsConfiguration] CometChatConversation configurations
  final ConversationsConfiguration? conversationsConfiguration;

  ///[messageConfiguration] CometChatMessage configurations
  final MessageConfiguration? messageConfiguration;

  @override
  State<CometChatConversationsWithMessages> createState() =>
      _CometChatConversationsWithMessagesState();
}

class _CometChatConversationsWithMessagesState
    extends State<CometChatConversationsWithMessages> {
  late CometChatConversationsWithMessagesController
      _cometChatConversationsWithMessagesController;

  //initialization methods
  @override
  void initState() {
    super.initState();
    _cometChatConversationsWithMessagesController =
        CometChatConversationsWithMessagesController(
            theme: widget.theme,
            messageConfiguration: widget.messageConfiguration);
    if (widget.user != null || widget.group != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _cometChatConversationsWithMessagesController.navigateToMessagesScreen(
          user: widget.user,
          group: widget.group,
          context: context,
          onTapChatPageHeader: widget.onTapChatPageHeader,
          onTapTrailingIcon: widget.onTapTrailingIcon,
          trailingIcon: widget.trailingIcon,
          onTapItem: widget.onTapItem,
        );
      });
    }
  }

  @override
  void dispose() {
    _cometChatConversationsWithMessagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _cometChatConversationsWithMessagesController,
        global: false,
        dispose: (GetBuilderState<CometChatConversationsWithMessagesController>
                state) =>
            state.controller?.onClose(),
        builder: (CometChatConversationsWithMessagesController
            conversationsWithMessagesController) {
          conversationsWithMessagesController.context = context;
          return CometChatConversations(
            hideAppBar: widget.hideAppBar,
            padding: widget.padding,
            physics: widget.physics,
            groupIDs: widget.groupIDs,
            shrinkWrap: widget.shrinkWrap,
            conversationsProtocol:
                widget.conversationsConfiguration?.conversationsProtocol,
            conversationsRequestBuilder:
                widget.conversationsConfiguration?.conversationsRequestBuilder,
            activateSelection:
                widget.conversationsConfiguration?.activateSelection,
            appBarOptions: widget.conversationsConfiguration?.appBarOptions,
            controller: widget.conversationsConfiguration?.controller,
            hideError: widget.conversationsConfiguration?.hideError,
            stateCallBack: widget.conversationsConfiguration?.stateCallBack,
            showBackButton:
                widget.conversationsConfiguration?.showBackButton ?? true,
            theme: widget.conversationsConfiguration?.theme ?? widget.theme,
            title: widget.conversationsConfiguration?.title,
            subtitleView: widget.conversationsConfiguration?.subtitleView,
            backButton: widget.conversationsConfiguration?.backButton,
            avatarStyle: widget.conversationsConfiguration?.avatarStyle,
            customSoundForMessages:
                widget.conversationsConfiguration?.customSoundForMessages,
            disableSoundForMessages:
                widget.conversationsConfiguration?.disableSoundForMessages ??
                    true,
            disableReceipt: widget.conversationsConfiguration?.disableReceipt,
            disableUsersPresence:
                widget.conversationsConfiguration?.disableUsersPresence,
            datePattern: widget.conversationsConfiguration?.datePattern,
            dateStyle: widget.conversationsConfiguration?.dateStyle,
            deliveredIcon: widget.conversationsConfiguration?.deliveredIcon,
            emptyText: widget.conversationsConfiguration?.emptyText,
            emptyView: widget.conversationsConfiguration?.emptyView,
            errorText: widget.conversationsConfiguration?.errorText,
            errorView: widget.conversationsConfiguration?.errorView,
            hideSeparator: widget.conversationsConfiguration?.hideSeparator,
            listItemStyle: widget.conversationsConfiguration?.listItemStyle,
            listItemView: widget.conversationsConfiguration?.listItemView,
            loadingView: widget.conversationsConfiguration?.loadingView,
            onSelection: widget.conversationsConfiguration?.onSelection,
            options: widget.conversationsConfiguration?.options,
            privateGroupIcon:
                widget.conversationsConfiguration?.privateGroupIcon,
            protectedGroupIcon:
                widget.conversationsConfiguration?.protectedGroupIcon,
            readIcon: widget.conversationsConfiguration?.readIcon,
            selectionMode: widget.conversationsConfiguration?.selectionMode,
            sentIcon: widget.conversationsConfiguration?.sentIcon,
            statusIndicatorStyle:
                widget.conversationsConfiguration?.statusIndicatorStyle,
            badgeStyle: widget.conversationsConfiguration?.badgeStyle,
            receiptStyle: widget.conversationsConfiguration?.receiptStyle,
            tailView: widget.conversationsConfiguration?.tailView,
            typingIndicatorText:
                widget.conversationsConfiguration?.typingIndicatorText,
            conversationsStyle:
                widget.conversationsConfiguration?.conversationsStyle ??
                    const ConversationsStyle(),
            onBack: widget.conversationsConfiguration?.onBack,
            onError: widget.conversationsConfiguration?.onError,
            // onItemTap: widget.conversationsConfiguration?.onItemTap ??
            //     conversationsWithMessagesController.onItemTap,
            onItemTap: (conversation) {
              User? user;
              Group? group;
              if (conversation.conversationType == ReceiverTypeConstants.user) {
                user = (conversation.conversationWith as User);
              } else if (conversation.conversationType ==
                  ReceiverTypeConstants.group) {
                group = (conversation.conversationWith as Group);
              }
              _cometChatConversationsWithMessagesController
                  .navigateToMessagesScreen(
                user: user,
                group: group,
                context: context,
                onTapChatPageHeader: widget.onTapChatPageHeader,
                onTapTrailingIcon: widget.onTapTrailingIcon,
                trailingIcon: widget.trailingIcon,
                onTapItem: widget.onTapItem,
              );
            },
            onItemLongPress: widget.conversationsConfiguration?.onItemLongPress,
          );
        });
  }
}
