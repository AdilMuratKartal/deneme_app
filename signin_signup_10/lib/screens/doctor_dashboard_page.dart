// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DoctorDashboardPage extends StatefulWidget {
  const DoctorDashboardPage({super.key});

  @override
  State<DoctorDashboardPage> createState() => _DoctorDashboardPageState();
}

class _DoctorDashboardPageState extends State<DoctorDashboardPage> {
  DateTime selectedDate = DateTime.now();
  int notificationCount = 3;

  List<PatientAppointment> appointments = [
    PatientAppointment(
      id: '1',
      patientName: 'Ahmet Yılmaz',
      identityNumber: '12345678901',
      birthDate: DateTime(1985, 5, 15),
      phone: '+90 532 123 45 67',
      complaint: 'Diş ağrısı ve hassasiyet problemi',
      appointmentTime: DateTime.now().add(Duration(hours: 1)),
      status: AppointmentStatusType.upcoming,
    ),
    PatientAppointment(
      id: '2',
      patientName: 'Fatma Kaya',
      identityNumber: '98765432109',
      birthDate: DateTime(1990, 8, 22),
      phone: '+90 533 987 65 43',
      complaint: 'Rutin kontrol ve diş temizliği',
      appointmentTime: DateTime.now().add(Duration(hours: 3)),
      status: AppointmentStatusType.upcoming,
    ),
    PatientAppointment(
      id: '3',
      patientName: 'Mehmet Demir',
      identityNumber: '11223344556',
      birthDate: DateTime(1978, 12, 3),
      phone: '+90 534 111 22 33',
      complaint: 'Dolgu kontrolü',
      appointmentTime: DateTime.now().subtract(Duration(hours: 2)),
      status: AppointmentStatusType.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final todayAppointments = appointments.where((appointment) {
      return appointment.appointmentTime.day == selectedDate.day &&
          appointment.appointmentTime.month == selectedDate.month &&
          appointment.appointmentTime.year == selectedDate.year;
    }).toList();

    todayAppointments
        .sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));

    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Doctor Dashboard',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: Color(0xFF2ECC71)),
                onPressed: () => _showNotifications(),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Color(0xFF2ECC71)),
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pop(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: Color(0xFF718096)),
                    SizedBox(width: 12),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Sign Out', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Tarih seçici
          Container(
            height: 120,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      color: Color(0xFF2D3748),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      final date = DateTime.now()
                          .subtract(Duration(days: 7))
                          .add(Duration(days: index));
                      final isSelected = date.day == selectedDate.day &&
                          date.month == selectedDate.month &&
                          date.year == selectedDate.year;
                      final isToday = date.day == DateTime.now().day &&
                          date.month == DateTime.now().month &&
                          date.year == DateTime.now().year;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        child: Container(
                          width: 70,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF2ECC71)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xFF2ECC71)
                                  : isToday
                                      ? Color(0xFF4A90E2)
                                      : Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun'
                                ][date.weekday - 1],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : isToday
                                          ? Color(0xFF4A90E2)
                                          : Color(0xFF718096),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : isToday
                                          ? Color(0xFF4A90E2)
                                          : Color(0xFF2D3748),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isToday)
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Color(0xFF4A90E2),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Hasta sayısı özeti
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Total',
                  '${todayAppointments.length}',
                  Color(0xFF4A90E2),
                  Icons.people,
                ),
                _buildSummaryItem(
                  'Upcoming',
                  '${todayAppointments.where((a) => a.status == AppointmentStatusType.upcoming).length}',
                  Color(0xFF2ECC71),
                  Icons.schedule,
                ),
                _buildSummaryItem(
                  'Completed',
                  '${todayAppointments.where((a) => a.status == AppointmentStatusType.completed).length}',
                  Color(0xFF718096),
                  Icons.check_circle,
                ),
              ],
            ),
          ),

          // Hasta listesi
          Expanded(
            child: todayAppointments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: Color(0xFF718096),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No appointments for this date',
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: todayAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = todayAppointments[index];
                      return _buildPatientCard(appointment);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      String title, String count, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF718096),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientCard(PatientAppointment appointment) {
    final age = DateTime.now().year - appointment.birthDate.year;
    final timeString =
        '${appointment.appointmentTime.hour.toString().padLeft(2, '0')}:${appointment.appointmentTime.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border(
          left: BorderSide(
            color: _getStatusColor(appointment.status),
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor(appointment.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.person,
                  color: _getStatusColor(appointment.status),
                  size: 28,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          appointment.patientName,
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(appointment.status)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusText(appointment.status),
                            style: TextStyle(
                              color: _getStatusColor(appointment.status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 16, color: Color(0xFF718096)),
                        SizedBox(width: 4),
                        Text(
                          timeString,
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.cake, size: 16, color: Color(0xFF718096)),
                        SizedBox(width: 4),
                        Text(
                          '$age years old',
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _buildInfoRow('ID Number', appointment.identityNumber),
          _buildInfoRow('Phone', appointment.phone),
          _buildInfoRow('Birth Date',
              '${appointment.birthDate.day}/${appointment.birthDate.month}/${appointment.birthDate.year}'),
          if (appointment.complaint.isNotEmpty) ...[
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complaint:',
                    style: TextStyle(
                      color: Color(0xFF2D3748),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    appointment.complaint,
                    style: TextStyle(
                      color: Color(0xFF718096),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label + ':',
              style: TextStyle(
                color: Color(0xFF718096),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AppointmentStatusType status) {
    switch (status) {
      case AppointmentStatusType.upcoming:
        return Color(0xFF2ECC71);
      case AppointmentStatusType.completed:
        return Color(0xFF718096);
      case AppointmentStatusType.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(AppointmentStatusType status) {
    switch (status) {
      case AppointmentStatusType.upcoming:
        return 'Upcoming';
      case AppointmentStatusType.completed:
        return 'Completed';
      case AppointmentStatusType.cancelled:
        return 'Cancelled';
    }
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF2ECC71).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Color(0xFF2ECC71).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF2ECC71).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.calendar_today,
                            color: Color(0xFF2ECC71), size: 20),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Appointment',
                              style: TextStyle(
                                color: Color(0xFF2D3748),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ahmet Yılmaz booked appointment',
                              style: TextStyle(
                                color: Color(0xFF718096),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '5 min ago',
                              style: TextStyle(
                                color: Color(0xFF718096),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notificationCount = 0;
                });
                Navigator.pop(context);
              },
              child: Text('Mark All Read'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2ECC71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class PatientAppointment {
  final String id;
  final String patientName;
  final String identityNumber;
  final DateTime birthDate;
  final String phone;
  final String complaint;
  final DateTime appointmentTime;
  final AppointmentStatusType status;

  PatientAppointment({
    required this.id,
    required this.patientName,
    required this.identityNumber,
    required this.birthDate,
    required this.phone,
    required this.complaint,
    required this.appointmentTime,
    required this.status,
  });
}

enum AppointmentStatusType {
  upcoming,
  completed,
  cancelled,
}
