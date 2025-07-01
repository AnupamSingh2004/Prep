import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Row(
              children: [
                const CircleAvatar(radius: 28, child: Icon(Icons.person, size: 30)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Kamlesh Kumar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("kamlesh.kumar@email.com"),
                    Text("📍 New Delhi, India")
                  ],
                ),
                const Spacer(),
                IconButton(icon: const Icon(Icons.edit), onPressed: () {})
              ],
            ),
            const SizedBox(height: 24),

            // Healthcare Journey
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
                statCard("₹2,450", "Total Savings"),
                statCard("23", "Medicines Searched"),
                statCard("5", "Stores Visited"),
                statCard("2", "Schemes Applied"),
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
              onPressed: () {},
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
