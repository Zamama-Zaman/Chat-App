import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  const TextMessageModel({
    String? recipientId,
    String? senderId,
    String? senderName,
    String? type = "TEXT",
    Timestamp? time,
    String? message,
    String? receiverName,
  }) : super(
          recipientId: recipientId,
          senderId: senderId,
          senderName: senderName,
          type: type,
          time: time,
          message: message,
          receiverName: receiverName,
        );

  factory TextMessageModel.fromJson(Map<String, dynamic> json) {
    return TextMessageModel(
      recipientId: json['recipientId'],
      message: json['message'],
      time: json['time'],
      receiverName: json['receiverName'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      type: json['type'],
    );
  }

  factory TextMessageModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TextMessageModel(
      time: documentSnapshot.get('time'),
      message: documentSnapshot.get('message'),
      receiverName: documentSnapshot.get('receiverName'),
      recipientId: documentSnapshot.get('recipientId'),
      senderId: documentSnapshot.get('senderId'),
      senderName: documentSnapshot.get('senderName'),
      type: documentSnapshot.get('type'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "recipientId": recipientId,
      "senderId": senderId,
      "senderName": senderName,
      "type": type,
      "time": time,
      "message": message,
      "receiverName": receiverName
    };
  }
}
