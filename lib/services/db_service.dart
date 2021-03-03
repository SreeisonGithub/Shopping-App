import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:funcart/models/productModel.dart';
import 'package:funcart/services/authentication_service.dart';

class DbService {
  Map<String, dynamic> localdata = {'name': 'sreejith', 'price': '89 dollars'};

  String user = AuthenticationService().getCurrentFirebaseUser().email;

  addItem(Map<String, dynamic> data) {
    CollectionReference collectionRefrence =
        FirebaseFirestore.instance.collection('sree');
    collectionRefrence
        .doc('product1')
        .set(data, SetOptions(merge: true))
        .then((_) {
      print("success!");
    });
  }

  Future<List<Products>> fetchData() async {
    List<Products> fetched = [];
    CollectionReference collectionRefrence =
        FirebaseFirestore.instance.collection(user);

    final value = await collectionRefrence.doc().get();
    print(value.data().toString());
    value.data().forEach((key, value) {
      print(value.data());
      Products product = Products.fromJson(value.data());
      fetched.add(product);
    });

    return fetched;
  }

  Future<List<Products>> fetchFromFireStore() async {
    List<Products> fetched = [];
    CollectionReference collectionRefrence =
        FirebaseFirestore.instance.collection(user);
    await collectionRefrence.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('Kawai');
        print(doc.data());
        Products product = Products.fromJson(doc.data());
        fetched.add(product);
      });
    });
    return fetched;
  }

  Future<List<Products>> fetchList() async {
    final list = await DbService().fetchFromFireStore();
    //_orderId.sink.add(list);
    return list;
  }

  

  updataData(var data) async {
    CollectionReference collectionRefrence =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await collectionRefrence.get();
    querySnapshot.docs[0].reference.update(data);
  }

  deleteItem(var data) async {
    CollectionReference collectionRefrence =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await collectionRefrence.get();
    querySnapshot.docs[0].reference.delete();
  }

  addUser(Map<String, dynamic> order, String productName) {
    CollectionReference users = FirebaseFirestore.instance.collection(user);
    users.doc(productName).set(order);
  }

  Future<bool> checkUserExists() async {
    //retrieve the documents in the firestore
    //check if the user has a document with his firebase.uid
    //if document exists addItem else create a user and set data
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("users/$user").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  dbDecision(Map<String, dynamic> product, String name) async {
    bool userExists = await DbService().checkUserExists();
    if (userExists) {
      addItem(product);
    }
    else {
    addUser(product, name);}
  }
}
