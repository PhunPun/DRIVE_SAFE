import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Bước 1: Đăng nhập bằng Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Bước 2: Lấy thông tin xác thực
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Bước 3: Tạo Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Bước 4: Đăng nhập vào Firebase
      return await _auth.signInWithCredential(credential);
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