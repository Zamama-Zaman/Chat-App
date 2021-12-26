import 'dart:io';

import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/Feature/domain/usecases/send_text_message_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommunicationController extends GetxController {
  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;

  RxBool isLoading = false.obs;
  bool loading = false;

  RxList<TextMessageEntity> messages = RxList<TextMessageEntity>();

  CommunicationController({
    required this.getMessagesUseCase,
    required this.sendTextMessageUseCase,
  });

  Future<void> sendTextMsg(
      {required String name,
      required String uid,
      required String message}) async {
    try {
      // showLoading();
      await sendTextMessageUseCase.call(
        TextMessageEntity(
          recipientId: "",
          senderId: uid,
          senderName: name,
          type: "TEXT",
          time: Timestamp.now(),
          message: message,
          receiverName: "",
        ),
      );
      // hideLoading();
    } on SocketException catch (_) {}
  }

  Future<void> getTextMessages() async {
    try {
      messages.bindStream(getMessagesUseCase.call());
    } on SocketException catch (_) {}
  }

  showLoading() {
    isLoading = true.obs;
  }

  hideLoading() {
    isLoading = false.obs;
  }
}
