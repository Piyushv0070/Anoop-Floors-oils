import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Order Dispatched",
        "message": "Your fresh batch #409 is on its way!",
        "time": "2 mins ago",
        "icon": Icons.shopping_bag,
        "isUnread": true,
      },
      {
        "title": "Milling Alert",
        "message": "Stone-grinding starts tomorrow for your custom mix.",
        "time": "1 hour ago",
        "icon": Icons.precision_manufacturing,
        "isUnread": true,
      },
      {
        "title": "Weekly Deal",
        "message": "10% off on all Wood Pressed Oils.",
        "time": "5 hours ago",
        "icon": Icons.local_offer,
        "isUnread": false,
      },
      {
        "title": "Feedback Requested",
        "message": "How was your experience with the last order?",
        "time": "1 day ago",
        "icon": Icons.rate_review,
        "isUnread": false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[200],
          height: 1,
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            color: notification['isUnread'] ? Colors.white : Colors.transparent,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.orangeLight.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  notification['icon'],
                  color: AppColors.orangeAccent,
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      notification['title'],
                      style: GoogleFonts.poppins(
                        fontWeight: notification['isUnread']
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (notification['isUnread'])
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    notification['message'],
                    style: GoogleFonts.poppins(
                      color: AppColors.textGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification['time'],
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
