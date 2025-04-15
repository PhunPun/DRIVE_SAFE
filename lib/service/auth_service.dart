import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      // Nếu user không null, lưu thông tin vào Firestore
      if (user != null) {
        final userDoc = _firestore.collection('users').doc(user.uid);

        // Kiểm tra nếu user chưa tồn tại thì mới thêm
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'displayName': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return userCredential;
    } catch (e) {
      print("Lỗi đăng nhập Google: $e");
      return null;
    }
  }
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut(); // <- Đăng xuất khỏi Google
  }
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}