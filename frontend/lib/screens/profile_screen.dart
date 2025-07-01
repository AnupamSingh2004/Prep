import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final result = await ApiService.getUserProfile();
      if (result['success']) {
        setState(() {
          userProfile = result['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = result['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load profile data';
        isLoading = false;
      });
    }
  }

  Future<void> _handleSignOut() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await ApiService.logout();
      if (mounted) {
        Navigator.of(context).pop();
        if (result['success']) {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Logout failed')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(errorMessage!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        errorMessage = null;
                      });
                      _loadUserProfile();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 28, 
                  backgroundColor: Colors.blue[100],
                  child: userProfile?['profile_image'] != null 
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.network(
                          userProfile!['profile_image'],
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.person, size: 30),
                        ),
                      )
                    : const Icon(Icons.person, size: 30)
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userProfile?['first_name'] ?? 'User'} ${userProfile?['last_name'] ?? ''}".trim(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userProfile?['email'] ?? 'email@example.com',
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (userProfile?['location'] != null)
                        Text("📍 ${userProfile!['location']}")
                      else if (userProfile?['city'] != null && userProfile?['country'] != null)
                        Text("📍 ${userProfile!['city']}, ${userProfile!['country']}")
                      else
                        const Text("📍 Location not set")
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.edit), onPressed: () {})
              ],
            ),
            const SizedBox(height: 24),

            const Text("Your Healthcare Journey", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: [
                statCard("₹${userProfile?['total_savings'] ?? '0'}", "Total Savings"),
                statCard("${userProfile?['medicines_searched'] ?? '0'}", "Medicines Searched"),
                statCard("${userProfile?['stores_visited'] ?? '0'}", "Stores Visited"),
                statCard("${userProfile?['schemes_applied'] ?? '0'}", "Schemes Applied"),
              ],
            ),

            const SizedBox(height: 20),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                quickAction(Icons.upload, "Upload\nPrescription"),
                quickAction(Icons.favorite_border, "Health\nCheck"),
              ],
            ),

            const SizedBox(height: 20),

            // Account Section
            sectionTile(Icons.medical_services_outlined, "My Prescriptions"),
            sectionTile(Icons.note_add_outlined, "Health Records"),
            sectionTile(Icons.calendar_today_outlined, "Appointment History"),
            sectionTile(Icons.notifications_outlined, "Notifications"),
            sectionTile(Icons.lock_outline, "Privacy & Security"),
            sectionTile(Icons.support_agent, "Help & Support"),
            sectionTile(Icons.settings, "Settings"),

            const SizedBox(height: 20),

            // Health Tip
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.yellow[100],
              child: const Text("💡 Health Tip of the Day\nAlways ask your pharmacist for generic alternatives to save up to 90% on your medicine costs!"),
            ),

            const SizedBox(height: 20),

            // Emergency
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.red[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("🚨 Emergency Helpline\n108 (National Ambulance)")),
                  ElevatedButton(
                    onPressed: () {
                      // Add call functionality using url_launcher
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Call Now"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: _handleSignOut,
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }

  Widget statCard(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget quickAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(radius: 24, backgroundColor: Colors.grey[200], child: Icon(icon)),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  Widget sectionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
