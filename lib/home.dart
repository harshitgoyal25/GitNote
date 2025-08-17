import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Main background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF151D38), Color(0xFF153164)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 46, 22, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar with Logout
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _glassIconButton(Icons.menu),
                            const SizedBox(width: 14),
                            Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                              child: const Center(
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _glassIconButton(Icons.notifications_outlined),
                            const SizedBox(width: 12),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // LOGOUT button
                            ElevatedButton.icon(
                              onPressed: () => _logout(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.15),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                              ),
                              icon: const Icon(Icons.logout, size: 19),
                              label: const Text("Logout"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Search Notes bar
                    _glassBar(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Search Notes",
                                hintStyle: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 18,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.75),
                            size: 25,
                          ),
                          const SizedBox(width: 14),
                        ],
                      ),
                      borderRadius: 24,
                      blur: 20,
                      opacity: 0.14,
                    ),
                    const SizedBox(height: 25),
                    // My Notes section
                    const Text(
                      "My Notes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _gradientRadialCard(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 19, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Find Notes search and New button
                            Row(
                              children: [
                                Expanded(
                                  child: _glassBar(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: "Find Your Notes",
                                              hintStyle: TextStyle(
                                                color: Colors.white70,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.white.withOpacity(0.75),
                                          size: 22,
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                    borderRadius: 17,
                                    blur: 16,
                                    opacity: 0.17,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _frostedRoundBtn('New'),
                              ],
                            ),
                            const SizedBox(height: 18),
                            // Notes list
                            ...List.generate(
                              4,
                              (i) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: i == 3 ? 0 : 12,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.88),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Text(
                                      "Notes ${i + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'See more',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      borderRadius: 24,
                    ),
                    const SizedBox(height: 27),
                    // Feed section
                    const Text(
                      "Feed",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _gradientRadialCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 11,
                        ),
                        child: Column(
                          children: [
                            _feedCard(
                              title: "Aaryan/Agile_notes",
                              desc:
                                  "loremlipsdscaxZxsrdctfvgy bhf sztcfvygbhunjsd a",
                            ),
                            const SizedBox(height: 12),
                            _feedCard(
                              title: "Harshit/CN_notes",
                              desc:
                                  "loremlipsdscaxZxsrdctfvgy bhf sztcfvygbhunjsd a",
                            ),
                          ],
                        ),
                      ),
                      borderRadius: 24,
                    ),
                    const SizedBox(height: 7),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'See more',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        "Thank You",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.73),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Frosted glassy topbar icon button
  static Widget _glassIconButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.13),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 21),
    );
  }

  // Glass effect search/input bar (for outside and inside cards)
  static Widget _glassBar({
    required Widget child,
    double borderRadius = 22,
    double blur = 16,
    double opacity = 0.14,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: child,
        ),
      ),
    );
  }

  // Radial blue gradient card for My Notes and Feed, less shiny
  static Widget _gradientRadialCard({
    required Widget child,
    double borderRadius = 24,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const RadialGradient(
          center: Alignment(-.86, -0.7), // bright focus top left
          radius: 1.1,
          colors: [
            Color(0x334C97CA), // low alpha = less shiny
            Color(0xCC2770B4), // muted core blue, some transparency
            Color(0xFF2547A2),
            Color(0xFF19254A),
          ],
          stops: [0.0, 0.35, 0.72, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF22397C).withOpacity(0.10),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.03)),
            child: child,
          ),
        ),
      ),
    );
  }

  // Frosted white "New" button in My Notes
  static Widget _frostedRoundBtn(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.14),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Feed card style
  static Widget _feedCard({required String title, required String desc}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white.withOpacity(0.10), width: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 11,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.83),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.white.withOpacity(0.84),
                size: 23,
              ),
              const SizedBox(height: 2),
              const Text(
                "6.2k",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
