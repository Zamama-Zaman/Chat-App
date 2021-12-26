import 'package:chat_app/Feature/data/data_source/firebase_remote_datasource.dart';
import 'package:chat_app/Feature/data/models/text_message_model.dart';
import 'package:chat_app/Feature/data/models/user_model.dart';
import 'package:chat_app/Feature/domain/entities/text_message_entity.dart';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String channelId = "8ghYhb9YN58qQeSBy2MG";
  FirebaseRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUserId() async => auth.currentUser!.uid;

  @override
  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl) async {
    CollectionReference userCollection = firestore.collection('users');
    userCollection.doc(auth.currentUser!.uid).get().then((user) {
      if (!user.exists) {
        final newUser = UserModel(
          name: name,
          email: email,
          uid: auth.currentUser!.uid,
          profileUrl: profileUrl,
        ).toDocument();
        userCollection.doc(auth.currentUser!.uid).set(newUser);
        return;
      } else {
        return;
      }
    });
  }

  @override
  Stream<List<TextMessageModel>> getMessages() {
    CollectionReference globalChatChannelCollection =
        firestore.collection('globalChatChannel');
    return globalChatChannelCollection
        .doc(channelId)
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TextMessageModel.fromSnapshot(docSnapshot))
            .toList());
  }

  @override
  Future<UserEntity> getUsers(String uid) async {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(uid).get();
    return UserModel.fromSnapshot(userSnapshot);
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessage) async {
    CollectionReference globalChatChannelCollection =
        firestore.collection('globalChatChannel');
    final newMessage = TextMessageModel(
      message: textMessage.message,
      recipientId: textMessage.recipientId,
      time: textMessage.time,
      receiverName: textMessage.receiverName,
      senderId: textMessage.senderId,
      senderName: textMessage.senderName,
      type: textMessage.type,
    );
    globalChatChannelCollection
        .doc(channelId)
        .collection("messages")
        .add(newMessage.toDocument());
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
