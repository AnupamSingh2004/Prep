import 'package:flutter/material.dart';
import '../models/user_model.dart';

class HomePageWrapper extends StatelessWidget {
  final User user;

  const HomePageWrapper({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return your existing HomePage but without the bottom navigation
    return _HomePageWithoutBottomNav(user: user);
  }
}

class _HomePageWithoutBottomNav extends StatefulWidget {
  final User user;

  const _HomePageWithoutBottomNav({required this.user});

  @override
  State<_HomePageWithoutBottomNav> createState() => _HomePageWithoutBottomNavState();
}

class _HomePageWithoutBottomNavState extends State<_HomePageWithoutBottomNav> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE), // Light medical background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0F9FF), // Very light blue
              Color(0xFFF8FFFE), // Light mint
              Color(0xFFECFDF5), // Light green
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false, // Don't apply safe area to bottom
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0), // Removed bottom padding as layout handles it
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section at Top Right
                _buildTopProfileSection(),
                
                const SizedBox(height: 30),

                // Welcome Section
                _buildWelcomeSection(),

                const SizedBox(height: 40),

                // User Info Card
                _buildUserInfoCard(),

                const Spacer(),

                // Footer
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _showProfileMenu(context),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1), // Light green medical
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFF10B981), // Medical green
              child: Text(
                widget.user.firstName.isNotEmpty 
                    ? widget.user.firstName[0].toUpperCase()
                    : widget.user.email[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: TextStyle(
            color: const Color(0xFF6B7280), // Dark gray
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.user.fullName.isNotEmpty
              ? widget.user.fullName
              : widget.user.email.split('@').first,
          style: const TextStyle(
            color: Color(0xFF111827), // Dark text
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1), // Light green
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color(0xFF10B981).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.user.emailVerified
                    ? Icons.verified_rounded
                    : Icons.pending_rounded,
                color: const Color(0xFF10B981), // Medical green
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                widget.user.emailVerified ? 'Verified Account' : 'Pending Verification',
                style: const TextStyle(
                  color: Color(0xFF059669), // Darker green
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Information',
            style: TextStyle(
              color: Color(0xFF111827), // Dark text
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.email_rounded, 'Email', widget.user.email),
          const SizedBox(height: 16),
          _buildInfoRow(
            widget.user.isGoogleUser ? Icons.g_mobiledata_rounded : Icons.person_rounded,
            'Account Type',
            widget.user.isGoogleUser ? 'Google Account' : 'Regular Account',
          ),
          if (widget.user.fullName.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(Icons.badge_rounded, 'Full Name', widget.user.fullName),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1), // Light medical green
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF10B981), // Medical green
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF6B7280), // Gray text
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF111827), // Dark text
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Text(
        'MediCare © 2024',
        style: TextStyle(
          color: const Color(0xFF6B7280), // Gray text
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF10B981), // Medical green
                      child: Text(
                        widget.user.firstName.isNotEmpty 
                            ? widget.user.firstName[0].toUpperCase()
                            : widget.user.email[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.fullName.isNotEmpty
                                ? widget.user.fullName
                                : widget.user.email.split('@').first,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Menu Items
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildMenuTile(
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      subtitle: 'Manage your preferences',
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Settings coming soon!')),
                        );
                      },
                    ),
                    _buildMenuTile(
                      icon: Icons.help_rounded,
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Help & Support coming soon!')),
                        );
                      },
                    ),
                    const Divider(height: 32),
                    _buildMenuTile(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      subtitle: 'Sign out of your account',
                      textColor: Colors.red[600],
                      onTap: () async {
                        Navigator.pop(context);
                        // Handle logout - you can implement this based on your auth system
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logout functionality needs to be implemented')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[50],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (textColor ?? const Color(0xFF10B981)).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: textColor ?? const Color(0xFF10B981),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.black87,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            letterSpacing: 0.3,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
