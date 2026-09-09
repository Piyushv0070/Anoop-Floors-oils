import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../profile_page.dart';
import '../order_history_page.dart';
import '../saved_recipes_page.dart';
import '../subscriptions_page.dart';
import '../manage_addresses_page.dart';
import '../payment_methods_page.dart';
import '../help_support_page.dart';
import '../about_anoop_page.dart';
import '../login_page.dart';

class AnoopDrawer extends StatelessWidget {
  const AnoopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildMenuItem(
                    context,
                    Icons.person_outline,
                    'My Profile',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.history,
                    'Order History',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryPage()));
                    },
                    badge: _buildBadge('1 Active', const Color(0xFFFEF3C7), const Color(0xFF92400E)),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.favorite_border,
                    'Saved Recipes',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedRecipesPage()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.layers_outlined,
                    'Subscriptions',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionsPage()));
                    },
                    badge: _buildBadge('FRESH RUN', const Color(0xFFD1FAE5), const Color(0xFF065F46), isPill: false),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.location_on_outlined,
                    'Manage Addresses',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageAddressesPage()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.payment,
                    'Payment Methods',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsPage()));
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(height: 1),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.help_outline,
                    'Help & Support',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportPage()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.info_outline,
                    'About Anoop',
                    () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAnoopPage()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.logout,
                    'Logout',
                    () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=anoop'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                  color: Colors.black12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, color: Colors.amber, size: 8),
                    const SizedBox(width: 6),
                    Text(
                      'Chakki Club',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Anoop Customer',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            'customer@anoopmultigrains.com',
            style: GoogleFonts.poppins(
              color: const Color(0xFF6EE7B7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF065F46),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF10B981), width: 0.5),
                ),
                child: Text(
                  'Pantry Gold',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '8 Fresh Orders',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6EE7B7),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? textColor,
    Widget? badge,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primaryGreen, size: 22),
      title: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black87,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            badge,
          ],
        ],
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor, {bool isPill = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(isPill ? 12 : 4),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset('assets/logo.png', height: 40),
          ),
          const SizedBox(height: 12),
          Text(
            'ANOOP MULTIGRAINS & OILS',
            style: GoogleFonts.playfairDisplay(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Version 1.0.0',
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
