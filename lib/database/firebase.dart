import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOperations {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      var existingUser = await _auth.fetchSignInMethodsForEmail(email);
      if (existingUser.isNotEmpty) {
        print("Hata: Bu e-posta zaten kullanımda.");
        return null;
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Firestore'a kullanıcı bilgilerini kaydet
      try {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          // İsteğe bağlı diğer kullanıcı bilgileri buraya eklenebilir
        });
        print('Firestore\'a veri başarıyla kaydedildi.');
      } catch (e) {
        print('Firestore\'a veri kaydederken hata oluştu: $e');
      }

      return userCredential;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  // Firestore ile iletişim işlevleri buraya eklenebilir
}
