import 'package:isar/isar.dart';
import 'package:ncrypt/models/message.dart';
import 'package:ncrypt/models/user.dart';

class LocalDBService{

  late Future<Isar> db;

  LocalDBService(){
    db = openDB();
  }

  // Future<void> saveMessage(Message message, User? user) async {
  //   final isar = await db;
  //   isar.writeTxnSync(() => isar.messages.putSync(message));
  //   if(user!=null){
  //     final existingUser = await isar.users.filter().uidEqualTo(message.sender).findFirst();
  //     if(existingUser == null){
  //       print("Found a new user");
  //       final newUser = user.copyWith(lastInteracted: message.sentAt);
  //       isar.writeTxnSync(() => isar.users.putSync(newUser));
  //     } else {
  //       print("Found same user");
  //       existingUser.lastInteracted = message.sentAt;
  //       isar.writeTxnSync(() => isar.users.putSync(existingUser));
  //     }
  //   }
  // }

  Future<void> handleIncomingMessage(Message message, User user) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.messages.putSync(message));
    final existingUser = await isar.users.filter().uidEqualTo(message.sender).findFirst();
    if(existingUser == null){
      print("Found a new user");
      final newUser = user.copyWith(lastInteracted: message.sentAt);
      isar.writeTxnSync(() => isar.users.putSync(newUser));
    } else {
      print("Found same user");
      existingUser.lastInteracted = message.sentAt;
      isar.writeTxnSync(() => isar.users.putSync(existingUser));
    }
  }

  Future<void> handleOutgoingMessage(Message message, User receiver) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.messages.putSync(message));
    final existingUser = await isar.users.filter().uidEqualTo(receiver.uid).findFirst();
    if(existingUser == null){
      print("Found a new user");
      final newUser = receiver.copyWith(lastInteracted: message.sentAt);
      isar.writeTxnSync(() => isar.users.putSync(newUser));
    } else {
      print("Found same user");
      existingUser.lastInteracted = message.sentAt;
      isar.writeTxnSync(() => isar.users.putSync(existingUser));
    }
  }

  Future<void> saveUser(User user) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.users.putSync(user));
  }

  Stream<List<Message>> listenToMessagesFromUser(User user) async* {
    final isar = await db;
    yield* isar.messages.filter().senderEqualTo(user.uid).or().receiverEqualTo(user.uid).sortBySentAtDesc().watch(fireImmediately: true);
  }

  Stream<List<User>> listenToUsers() async *{
    final isar = await db;
    yield* isar.users.where().watch(fireImmediately: true);
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserSchema, MessageSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}