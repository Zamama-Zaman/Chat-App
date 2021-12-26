import 'dart:async';
import 'package:bubble/bubble.dart';
import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/presentation/controllers/communication/communication_controller.dart';
import 'package:chat_app/Feature/presentation/pages/message_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String uid;
  final String userName;

  const ChatPage({Key? key, required this.uid, required this.userName})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final commuController = Get.find<CommunicationController>();
  @override
  void initState() {
    commuController.getTextMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<CommunicationController>(
      builder: (controller) {
        if (controller.messages.isNotEmpty) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/background_image_3.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    _headerWidget(),
                    _listMessagesWidget(commuController.messages),
                    _sendTextMessageWidget(),
                  ],
                ),
              ],
            ),
          );
        }
        if (controller.messages.isEmpty) {
          return _noMessageWidget();
        }
        return _loadingWidget();
      },
    );
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_image_3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              _headerWidget(),
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              )),
              _sendTextMessageWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noMessageWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_image_3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              _headerWidget(),
              Expanded(
                child: Center(
                  child: Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(.9),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Be The First One to Send Message...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _sendTextMessageWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          const Color(0xFF15B4AF),
          Colors.yellow.shade400,
          Colors.blue.shade300,
        ],
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 40,
                  height: 40,
                  child:
                      Image.asset("assets/images/chat_icon_1_transparent.png")),
              const SizedBox(
                width: 20.0,
              ),
              const Text(
                "Group Chat",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            widget.userName,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listMessagesWidget(List<TextMessageEntity> messages) {
    Timer(
        const Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (_, index) {
            return messages[index].senderId == widget.uid
                ? MessageLayout(
                    type: messages[index].type!,
                    senderId: messages[index].senderId,
                    text: messages[index].message,
                    time: DateFormat('hh:mm a')
                        .format(messages[index].time!.toDate()),
                    color: const Color(0xFF15B4AF),
                    align: TextAlign.left,
                    nip: BubbleNip.rightTop,
                    boxAlignment: CrossAxisAlignment.end,
                    boxMainAxisAlignment: MainAxisAlignment.end,
                    uid: widget.uid,
                  )
                : MessageLayout(
                    uid: widget.uid,
                    type: messages[index].type!,
                    senderName: messages[index].senderName,
                    text: messages[index].message,
                    time: DateFormat('hh:mm a')
                        .format(messages[index].time!.toDate()),
                    color: Colors.yellow,
                    align: TextAlign.left,
                    nip: BubbleNip.leftTop,
                    boxAlignment: CrossAxisAlignment.start,
                    boxMainAxisAlignment: MainAxisAlignment.start,
                  );
          },
        ),
      ),
    );
  }

  Widget _sendTextMessageWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            border: Border.all(color: Colors.black.withOpacity(.4), width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _emojiWidget(),
                const SizedBox(
                  width: 8,
                ),
                _textFieldWidget(),
              ],
            ),
            Row(
              children: [
                _micWidget(),
                const SizedBox(
                  width: 8,
                ),
                _sendMessageButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _emojiWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: const Icon(
        Icons.emoji_emotions,
        color: Colors.white,
      ),
    );
  }

  _micWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: const Icon(
        Icons.mic,
        color: Colors.white,
      ),
    );
  }

  _textFieldWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
        ),
        child: Scrollbar(
          child: TextField(
            controller: _messageController,
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Write Message..."),
          ),
        ),
      ),
    );
  }

  Widget _sendMessageButton() {
    return InkWell(
      onTap: () {
        if (_messageController.text.isNotEmpty) {
          _sendTextMessage();
          _messageController.clear();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  void _sendTextMessage() {
    commuController.sendTextMsg(
      name: widget.userName,
      uid: widget.uid,
      message: _messageController.text.toString(),
    );
  }
}
