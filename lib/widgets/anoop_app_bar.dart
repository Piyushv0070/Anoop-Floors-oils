import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../search_page.dart';
import '../notifications_page.dart';

class AnoopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? titleTag;
  final String? subtitle;

  const AnoopAppBar({
    super.key,
    this.title,
    this.titleTag,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    bool canPop = Navigator.canPop(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.maybePop(context),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png'),
            ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  title ?? 'Anoop',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (titleTag != null) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    titleTag!,
                    style: GoogleFonts.poppins(fontSize: 10, color: AppColors.orangeAccent),
                  ),
                ),
              ],
            ],
          ),
          Text(
            subtitle ?? 'Deliver to: Indiranagar,...',
            style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textGrey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
          icon: const Icon(Icons.search, color: Colors.black),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsPage()),
            );
          },
          icon: const Icon(Icons.notifications_none, color: Colors.black),
        ),
        Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryGreen,
                foregroundImage: const NetworkImage('https://i.pravatar.cc/150?u=anoop'),
                onForegroundImageError: (exception, stackTrace) {},
                child: const Icon(Icons.person_outline, size: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
