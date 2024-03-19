import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static addData(String code, String data) {
    FirebaseFirestore.instance
        .collection("data")
        .add({"code": code, "txt": data})
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'))
        .catchError((onError) => {print('Error in operation')});
  }

  static fetchData(String code) async {
    var retTxt = '';
    await FirebaseFirestore.instance
        .collection("data")
        .where("code", isEqualTo: code)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          retTxt = docSnapshot.data()['txt'];
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return retTxt;
  }
}
