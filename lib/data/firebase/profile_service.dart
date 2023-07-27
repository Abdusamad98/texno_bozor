import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

class ProfileService {
  Future<UniversalData> updateUserEmail({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      return UniversalData(data: "Updated!");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
