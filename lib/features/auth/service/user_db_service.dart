import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

//My imports
import 'package:authentication_template/core/data_constants.dart';
import 'package:authentication_template/features/auth/model/device.dart';
import 'package:authentication_template/features/auth/model/user.dart';

DatabaseService<UserModel> userDBS = DatabaseService<UserModel>(
    AppDBConstants.usersCollection,
    toMap: (user) => user.toMap(),
    fromDS: (id, data) => UserModel.fromDS(id, data));

UserDeviceDBService userDeviceDBS = UserDeviceDBService("devices");

class UserDeviceDBService extends DatabaseService<Device> {
  String collection;
  UserDeviceDBService(this.collection)
      : super(collection,
            fromDS: (id, data) => Device.fromDS(id, data),
            toMap: (device) => device.toMap());

  Stream<List<Device>> getAllModels() {
    return FirebaseFirestore.instance
        .collectionGroup(collection)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }
}
