import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'login_page.dart';
import 'package:first_app/screens/Home/Widgets/scheme_card.dart';
import 'package:first_app/screens/Home/Widgets/recent_search.dart';
import 'package:first_app/screens/Home/Widgets/savings_card.dart';
import 'package:first_app/screens/Home/Widgets/stats_card.dart';


class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Stores'),
          BottomNavigationBarItem(icon: Icon(Icons.policy), label: 'Schemes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Top Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22C1C3), Color(0xFF3CA1AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user.fullName}!',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Find affordable generic medicines and save up to 90% on healthcare costs',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '🔒 Trusted by 1M+ families',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ✅ Search + Scan Section
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter medicine name (e.g., Crocin, Augr)',
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.search), onPressed: () {}),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.document_scanner),
                              label: const Text('Scan Prescription'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.upload_file),
                              label: const Text('Upload Image'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ✅ Feature Cards
              Row(
                children: [
                  Expanded(
                    child: SchemeCard(
                      title: 'Find Stores',
                      subtitle: 'Nearby Jan Aushadhi',
                      icon: Icons.store,
                      color: Colors.green.shade100,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SchemeCard(
                      title: 'Govt Schemes',
                      subtitle: 'PMBJP & More',
                      icon: Icons.account_balance,
                      color: Colors.blue.shade100,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ✅ Recent Searches
              const RecentSearches(),
              // 1. Top Savings Section
              const SizedBox(height: 24),
              const Text("Today's Top Savings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const SavingsCard(
                title: 'Paracetamol 500mg',
                subtitle: 'Generic vs Branded',
                savings: 'Save 89%',
                color: Colors.green,
              ),
              const SavingsCard(
                title: 'Omeprazole 20mg',
                subtitle: 'Generic vs Branded',
                savings: 'Save 85%',
                color: Colors.blue,
              ),

// 2. Recent Searches (improved)
              const SizedBox(height: 24),
              const Text("Recent Searches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Paracetamol 500mg'),
                  subtitle: const Text('2 hours ago'),
                ),
              ),

// 3. Feature Stats
              const SizedBox(height: 24),
              Row(
                children: const [
                  StatsCard(title: '9K+', subtitle: 'Stores'),
                  SizedBox(width: 12),
                  StatsCard(title: '90%', subtitle: 'Savings'),
                  SizedBox(width: 12),
                  StatsCard(title: '24/7', subtitle: 'Support'),
                ],
              ),

// 4. AI Health Assistant Banner
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  // TODO: Route to AI chatbot screen
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B42F6), Color(0xFFB01EFF)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Text('AI Health Assistant',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Get instant medical guidance',
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
