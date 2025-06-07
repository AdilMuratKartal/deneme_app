import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  /// 🔹 Yeni bir kullanıcı ekler veya var olanı günceller.
  ///
  /// [uid]          : String, doküman ID’si olarak kullanılacak.
  /// [email]        : String, kullanıcının e-posta adresi.
  /// [name]         : String, kullanıcının adı.
  /// [phone]        : String, kullanıcının telefon numarası.
  /// [role]         : String, örneğin 'patient', 'doctor', vs.
  /// [createdAt]    : DateTime, belge oluşturulma zamanı (serverTimestamp default).
  Future<void> addUser({
    required String uid,
    required String email,
    required String name,
    required String phone,
    required String role,
    DateTime? createdAt,
  }) async {
    final docRef = _usersRef.doc(uid);
    await docRef.set({
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      // Eğer fonksiyona createdAt verilmemişse, server timestamp kullan:
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt)
          : FieldValue.serverTimestamp(),
    });
  }

  /// 🔹 Belirtilen [uid]’ye sahip kullanıcı belgesini siler.
  Future<void> deleteUser(String uid) async {
    await _usersRef.doc(uid).delete();
  }

  /// 🔹 Tüm kullanıcıları (Map<String, dynamic> biçiminde) sıralı olarak okuyan bir Stream döner.
  ///
  /// Burada sıralamayı 'createdAt' alanına göre yapıyoruz. Eğer 'createdAt' olmayan belgeler varsa,
  /// sıralamada başta/sonda gözükeceklerini unutmayın.
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _usersRef
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((querySnap) => querySnap.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'uid': data['uid'] as String? ?? doc.id,
                'email': data['email'] as String? ?? '',
                'name': data['name'] as String? ?? '',
                'phone': data['phone'] as String? ?? '',
                'role': data['role'] as String? ?? '',
                'createdAt': data['createdAt'] as Timestamp?,
              };
            }).toList());
  }
}
