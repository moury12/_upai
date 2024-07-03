import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';

class FirebaseAPIs{
 static UserInfoModel  me =UserInfoModel();
  static final box = Hive.box("userInfo");
 static Map<String, dynamic> user = box.get('user');

  static FirebaseFirestore mDB =FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatList()
  {
   return FirebaseAPIs.mDB.collection("chat_list").snapshots();
  }

  // #save userDetails in hive for auto log in and firebase purpose like userEXist or not etc.
  // make a object name user where userINfo will be loaded from hive
  // (static User get user => auth.currentUser!;)//same system but with hive.
  // // for checking if user exists or not?
  static Future<bool> userExists() async {
  return (await mDB.collection('users').doc(user['user_id']).get()).exists;

  }

  static Future<void> createUser(Map<String,dynamic> userIfo) async {


  // final time = DateTime.now().millisecondsSinceEpoch.toString();
  //
  // final chatUser = ChatUser(
  // id: user.uid,
  // name: user.displayName.toString(),
  // email: user.email.toString(),
  // about: "Hey, I'm using We Chat!",
  // image: user.photoURL.toString(),
  // createdAt: time,
  // isOnline: false,
  // lastActive: time,
  // pushToken: '');

  return await mDB
      .collection('users')
      .doc(userIfo['user_id'])
      .set(userIfo);
  }










  //getSelfInfo it will be called when user enter the app

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await mDB.collection('users').doc(user["user_id"]).get().then((selectedUser) async {
      if (await userExists()) {
        me = UserInfoModel.fromJson(selectedUser.data()!);
        // await getFirebaseMessagingToken();
        //for setting user status to active
        FirebaseAPIs.updateActiveStatus(true);
       // log('My Data: ${user.data()}');
      } else {
        await createUser(user).then((value) => getSelfInfo());
      }
    });
  }
//
// /////////////////////////////
//   // for getting all users from firestore database
//   static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
//       List<String> userIds) {
//     log('\nUserIds: $userIds');
//
//     return firestore
//         .collection('users')
//         .where('id',
//         whereIn: userIds.isEmpty
//             ? ['']
//             : userIds) //because empty list throws an error
//     // .where('id', isNotEqualTo: user.uid)
//         .snapshots();
//   }
// ///////////////////////
//   this funtion could be call when user click on "chat now" button or after first message send.that will be better aproach
// //////////
//
//   // for adding an user to my user when first message is send
//   static Future<void> sendFirstMessage(
//       ChatUser chatUser, String msg, Type type) async {
//     await firestore
//         .collection('users')
//         .doc(chatUser.id)
//         .collection('my_users')
//         .doc(user.uid)
//         .set({}).then((value) => sendMessage(chatUser, msg, type));
//   }
//
//
// /////////
//
//
  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return mDB
        .collection('users')
        .doc(user['user_id'])
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return mDB
        .collection('users')
        .where('user_id',
        whereIn: userIds.isEmpty
            ? ['']
            : userIds) //because empty list throws an error
    // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }


// for adding an chat user for our conversation
  static Future<bool> addChatUser(String userId) async {
    final data = await mDB
        .collection('users')
        .where('user_id', isEqualTo: userId)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user['user_id']) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      mDB
          .collection('users')
          .doc(user['user_id'])
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }
// //////

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    mDB.collection('users').doc(user['user_id']).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
     // 'push_token': me.pushToken,
    });
  }

  //****************************************
  // useful for getting conversation id
  static String getConversationID(String id) => user['user_id'].hashCode <= id.hashCode
      ? '${user['user_id']}_$id'
      : '${id}_${user['user_id']}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserInfoModel user) {
    return mDB
        .collection('chats/${getConversationID(user.userId.toString())}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      UserInfoModel chatUser, String msg, Type type) async {
    await mDB
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user['user_id'])
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for sending message
  static Future<void> sendMessage(
      UserInfoModel chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.userId,
        msg: msg,
        read: '',
        type: type,
        fromId: user['user_id'],
        sent: time);

    final ref = mDB
        .collection('chats/${getConversationID(chatUser.userId.toString())}/messages/');
    await ref.doc(time).set(message.toJson());
        // .then((value) =>
        // sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    mDB
        .collection('chats/${getConversationID(message.fromId.toString())}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      UserInfoModel selectedUser) {
    return mDB
        .collection('chats/${getConversationID(selectedUser.userId.toString())}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

}