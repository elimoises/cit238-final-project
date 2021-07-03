// Service that is responsible for all of the 
// Firestore functionalities
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  CollectionReference userRef = Firestore.instance.collection("users");

  CollectionReference itemRef = Firestore.instance.collection("products");

  CollectionReference favRef = Firestore.instance.collection("favorites");

  Future addUserData(email, firstName, lastName) async {
    try {
      return await userRef.document(uid).setData({
        'email': email,
        'firstName' : firstName,
        'lastName' : lastName
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future fetchUserData() async {
    try {
      return await userRef.document(uid).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future fetchProducts() async {
    try {
      return await itemRef.getDocuments();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future addToFavorites(String itemId) async {
    try {
      return await favRef.document().setData({
        'userId': uid,
        'itemId': itemId
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}