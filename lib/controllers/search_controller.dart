import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/models/user.dart';

class Searchcnt extends GetxController {
  final Rx<List<User>> _searchedUser = Rx<List<User>>([]);
  List<User> get searchedUser => _searchedUser.value;

  searchUser(String typeuser) async {
    _searchedUser.bindStream(firestore
        .collection("users")
        .where("username", isGreaterThanOrEqualTo: typeuser)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<User> retval = [];
        for (var ele in query.docs) {
          retval.add(User.fromsnap(ele));
        }
        return retval;
      },
    ));
  }
}
