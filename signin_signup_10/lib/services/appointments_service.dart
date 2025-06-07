// lib/services/appointments_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsService {
  final CollectionReference _appointmentsRef =
      FirebaseFirestore.instance.collection('appointments');

  /// 🔹 Randevu Ekleme
  Future<void> addAppointment({
    required String appointmentId,
    required DateTime appointmentTime,
    required String doctorId,
    required String patientId,
    required String notes,
    String status = 'pending',
  }) async {
    final docRef = _appointmentsRef.doc(appointmentId);
    await docRef.set({
      'appointmentId': appointmentId,
      'appointmentTime': Timestamp.fromDate(appointmentTime),
      'doctorId': doctorId,
      'patientId': patientId,
      'notes': notes,
      'status': status,
    });
  }

  /// 🔹 Randevu Silme
  Future<void> deleteAppointment(String appointmentId) async {
    await _appointmentsRef.doc(appointmentId).delete();
  }

  /// 🔹 Randevuları Listeleme (Tüm randevular)
  Stream<List<Map<String, dynamic>>> getAppointmentsStream() {
    return _appointmentsRef
        .orderBy('appointmentTime')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'appointmentId': data['appointmentId'] as String? ?? doc.id,
                'appointmentTime': data['appointmentTime'] as Timestamp,
                'doctorId': data['doctorId'] as String? ?? '',
                'patientId': data['patientId'] as String? ?? '',
                'notes': data['notes'] as String? ?? '',
                'status': data['status'] as String? ?? 'pending',
              };
            }).toList());
  }

  /// 🔹 Doktora Ait Randevuları Listeleme
  Stream<List<Map<String, dynamic>>> getAppointmentsForDoctor(String doctorId) {
    return _appointmentsRef
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('appointmentTime')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'appointmentId': data['appointmentId'] as String? ?? doc.id,
                'appointmentTime': data['appointmentTime'] as Timestamp,
                'doctorId': data['doctorId'] as String? ?? '',
                'patientId': data['patientId'] as String? ?? '',
                'notes': data['notes'] as String? ?? '',
                'status': data['status'] as String? ?? 'pending',
              };
            }).toList());
  }

  /// 🔹 Hastaya Ait Randevuları Listeleme
  Stream<List<Map<String, dynamic>>> getAppointmentsForPatient(
      String patientId) {
    return _appointmentsRef
        .where('patientId', isEqualTo: patientId)
        .orderBy('appointmentTime')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'appointmentId': data['appointmentId'] as String? ?? doc.id,
                'appointmentTime': data['appointmentTime'] as Timestamp,
                'doctorId': data['doctorId'] as String? ?? '',
                'patientId': data['patientId'] as String? ?? '',
                'notes': data['notes'] as String? ?? '',
                'status': data['status'] as String? ?? 'pending',
              };
            }).toList());
  }

  /// 🔹 Randevu Durumunu Güncelleme (Ör: pending → confirmed / rejected)
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String newStatus, // "confirmed" veya "rejected"
  }) async {
    await _appointmentsRef.doc(appointmentId).update({
      'status': newStatus,
    });
  }
}
