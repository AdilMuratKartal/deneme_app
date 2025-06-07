// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage({super.key});

  @override
  State<AppointmentBookingPage> createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  DateTime selectedDate = DateTime.now();

  // Örnek doktor listesi
  final List<Doctor> doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Sarah Johnson',
      specialty: 'General Dentist',
      imageUrl: 'assets/doctor1.jpg',
      appointments: {
        '9': AppointmentStatus.available,
        '10': AppointmentStatus.booked,
        '11': AppointmentStatus.available,
        '12': AppointmentStatus.myBooking,
        '13': AppointmentStatus.available,
        '14': AppointmentStatus.booked,
        '15': AppointmentStatus.available,
        '16': AppointmentStatus.available,
        '17': AppointmentStatus.booked,
      },
    ),
    Doctor(
      id: '2',
      name: 'Dr. Michael Chen',
      specialty: 'Orthodontist',
      imageUrl: 'assets/doctor2.jpg',
      appointments: {
        '9': AppointmentStatus.booked,
        '10': AppointmentStatus.available,
        '11': AppointmentStatus.myBooking,
        '12': AppointmentStatus.available,
        '13': AppointmentStatus.booked,
        '14': AppointmentStatus.available,
        '15': AppointmentStatus.booked,
        '16': AppointmentStatus.available,
        '17': AppointmentStatus.available,
      },
    ),
    Doctor(
      id: '3',
      name: 'Dr. Emily Davis',
      specialty: 'Oral Surgeon',
      imageUrl: 'assets/doctor3.jpg',
      appointments: {
        '9': AppointmentStatus.available,
        '10': AppointmentStatus.available,
        '11': AppointmentStatus.booked,
        '12': AppointmentStatus.booked,
        '13': AppointmentStatus.available,
        '14': AppointmentStatus.myBooking,
        '15': AppointmentStatus.available,
        '16': AppointmentStatus.booked,
        '17': AppointmentStatus.available,
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Book Appointment',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4A90E2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Tarih seçici (yatay kaydırmalı)
          Container(
            height: 100,
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
                    itemCount: 30, // 30 gün göster
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected = date.day == selectedDate.day &&
                          date.month == selectedDate.month &&
                          date.year == selectedDate.year;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        child: Container(
                          width: 60,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF4A90E2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
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
                                      : Color(0xFF2D3748),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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

          // Doktor listesi
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
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
                  child: Column(
                    children: [
                      // Doktor bilgileri
                      Row(
                        children: [
                          // Doktor resmi
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A90E2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF4A90E2),
                              size: 40,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: TextStyle(
                                    color: Color(0xFF2D3748),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  doctor.specialty,
                                  style: TextStyle(
                                    color: Color(0xFF718096),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '4.8 (125 reviews)',
                                      style: TextStyle(
                                        color: Color(0xFF718096),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Randevu saatleri
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Times',
                            style: TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: doctor.appointments.entries.map((entry) {
                              final hour = entry.key;
                              final status = entry.value;

                              return GestureDetector(
                                onTap: status == AppointmentStatus.available
                                    ? () => _bookAppointment(doctor, hour)
                                    : status == AppointmentStatus.myBooking
                                        ? () => _cancelAppointment(doctor, hour)
                                        : null,
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _getStatusBorderColor(status),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${hour}:00',
                                          style: TextStyle(
                                            color: _getStatusTextColor(status),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (status ==
                                            AppointmentStatus.myBooking)
                                          Icon(
                                            Icons.close,
                                            size: 12,
                                            color: Colors.green,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Legend (açıklama)
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegendItem('Available', Colors.white, Color(0xFFE2E8F0)),
            _buildLegendItem('Booked', Colors.red[100]!, Colors.red),
            _buildLegendItem('My Booking', Colors.green[100]!, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color bgColor, Color? borderColor) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor ?? bgColor),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF718096),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.available:
        return Colors.white;
      case AppointmentStatus.booked:
        return Colors.red[100]!;
      case AppointmentStatus.myBooking:
        return Colors.green[100]!;
    }
  }

  Color _getStatusBorderColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.available:
        return Color(0xFFE2E8F0);
      case AppointmentStatus.booked:
        return Colors.red;
      case AppointmentStatus.myBooking:
        return Colors.green;
    }
  }

  Color _getStatusTextColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.available:
        return Color(0xFF2D3748);
      case AppointmentStatus.booked:
        return Colors.red;
      case AppointmentStatus.myBooking:
        return Colors.green;
    }
  }

  void _bookAppointment(Doctor doctor, String hour) {
    final TextEditingController complaintController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Book Appointment',
            style: TextStyle(
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Doctor: ${doctor.name}'),
                SizedBox(height: 8),
                Text(
                    'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                SizedBox(height: 8),
                Text('Time: ${hour}:00'),
                SizedBox(height: 8),
                Text('Specialty: ${doctor.specialty}'),
                SizedBox(height: 16),
                Text(
                  'Complaint / Reason for Visit:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: complaintController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        'Please describe your dental concern or reason for visit...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF4A90E2)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF7FAFC),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF718096)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (complaintController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please describe your complaint'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                setState(() {
                  // Randevuyu al
                  doctor.appointments[hour] = AppointmentStatus.myBooking;
                });
                Navigator.pop(context);

                // Doktora bildirim gönder (simülasyon)
                _sendNotificationToDoctor(
                    doctor, hour, complaintController.text.trim());

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Appointment booked successfully! Doctor has been notified.'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A90E2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Book Now'),
            ),
          ],
        );
      },
    );
  }

  void _cancelAppointment(Doctor doctor, String hour) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Cancel Appointment',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to cancel this appointment?'),
              SizedBox(height: 12),
              Text('Doctor: ${doctor.name}'),
              SizedBox(height: 4),
              Text(
                  'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              SizedBox(height: 4),
              Text('Time: ${hour}:00'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Keep Appointment',
                style: TextStyle(color: Color(0xFF718096)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Randevuyu iptal et
                  doctor.appointments[hour] = AppointmentStatus.available;
                });
                Navigator.pop(context);

                // Doktora iptal bildirimi gönder
                _sendCancellationNotificationToDoctor(doctor, hour);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Appointment cancelled successfully! Doctor has been notified.'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Cancel Appointment'),
            ),
          ],
        );
      },
    );
  }

  void _sendCancellationNotificationToDoctor(Doctor doctor, String hour) {
    // Doktora iptal bildirimi gönderme simülasyonu
    print(
        'Cancellation notification sent to ${doctor.name}: Appointment at ${hour}:00 has been cancelled');
  }

  void _sendNotificationToDoctor(Doctor doctor, String hour, String complaint) {
    // Burada doktora bildirim gönderme işlemi simüle ediliyor
    // Gerçek uygulamada push notification veya database kaydı yapılacak
    print(
        'Notification sent to ${doctor.name}: New appointment at ${hour}:00 - ${complaint}');
  }
}

// Model sınıfları
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final Map<String, AppointmentStatus> appointments;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.appointments,
  });
}

enum AppointmentStatus {
  available, // Boş - Beyaz
  booked, // Dolu - Kırmızı
  myBooking, // Benim randevum - Yeşil
}
