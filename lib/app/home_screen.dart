import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/app/app_layout.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'campus';

  final List<Map<String, String>> logos = [
      {'path': 'assets/images/uq_logo.png', 'name': 'University of Adelaide'},
      {'path': 'assets/images/uq_logo.png', 'name': 'Australian National University'},
      {'path': 'assets/images/uq_logo.png', 'name': 'University of Melbourne'},
      {'path': 'assets/images/uq_logo.png', 'name': 'Monash University'},
      {'path': 'assets/images/uq_logo.png', 'name': 'UNSW Sydney'},
      {'path': 'assets/images/uq_logo.png', 'name': 'University of Queensland'},
      {'path': 'assets/images/uq_logo.png', 'name': 'University of Sydney'},
      {'path': 'assets/images/uq_logo.png', 'name': 'Queensland University of Technology'},
      {'path': 'assets/images/uq_logo.png', 'name': 'University of Tasmania'},
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gameBackground,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: gameBackground,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  _buildCampusGrid(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
              LucideIcons.settings,
              color: Colors.grey,
              size: 24,
          ),
          Column(
            children: [
              const Text(
                'Uniordle',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 2,
                width: 40,
                margin: const EdgeInsets.only(top: 4), color: Colors.blue
              ),
            ]
          ),
          Icon(
            LucideIcons.barChart3,
            color: Colors.grey,
            size: 24,
          ),
        ]
      ),
    );
  }

  Widget _buildHeroSection() {
    return const Column(
      children: [
        Text(
          'Campuses',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Select a University to begin.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCampusGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,  
      ),
      itemCount: logos.length,
      itemBuilder: (context, index) {
        final logo = logos[index];
        return GestureDetector(
          onTap: () => _showSettingsDialog(context, logo['name']!),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    logo['path']!, 
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  logo['name']!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildCampusCard(Map<String, String> logo) {
    return GestureDetector(
      onTap: () => _showSettingsDialog(context, logo['name']!),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2B),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // fade on image
              Expanded(
                flex: 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        logo['path'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        logo['name']!.split(' ').last,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle, 
                            size: 8, 
                            color: Colors.blue
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'NEW CODE',
                            style: TextStyle(
                              color: Colors.blue.withValues(alpha: 0.8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final List<Map<String, dynamic>> _tabs = [
      {'id': 'campus', 'label': 'CAMPUS', 'icon': LucideIcons.graduationCap},
      {'id': 'archive', 'label': 'ARCHIVE', 'icon': LucideIcons.library},
      {'id': 'profile', 'label': 'PROFILE', 'icon': LucideIcons.user},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E17).withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: Colors.white10, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tabs.map((tab) {
            final bool isActive = _activeTab == tab['id'];
            final Color color = isActive ? Colors.blue : Colors.grey;

            return GestureDetector(
              onTap: () => setState(() => _activeTab = tab['id']),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tab['icon'],
                    color: color,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tab['label'],
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      )
    );
  }

  void _showSettingsDialog(BuildContext context, String university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(university),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Text('Option 1'),
                Spacer(),
                Switch(value: false, onChanged: null),
              ],
            ),
            Row(
              children: const [
                Text('Option 2'),
                Spacer(),
                Switch(value: true, onChanged: null),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context, '/uniordle',
              );
            },
            child: const Text(
              'PLAY',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'dm-sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}