import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

// Make sure you have '/signup', '/forgot_password', and '/home' routes configured in your MaterialApp.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String error = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message ?? 'Login failed.';
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF517ECF), Color(0xFF19254A)],
                center: Alignment.topLeft,
                radius: 1.25,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 68, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(
      'assets/gitnote_logo.png',
      height: 46,
      width: 46,
    ),
    const SizedBox(width: 10),
    const Text(
      'GitNote',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    ),
  ],
),

                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade900.withOpacity(0.17),
                            blurRadius: 38,
                            offset: const Offset(0, 18),
                          ),
                        ],
                        gradient: const RadialGradient(
                          colors: [Color(0xDD2E518F), Color(0xFF19254A)],
                          center: Alignment.topLeft,
                          radius: 1.15,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 36, 30, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                Row(
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      child: const Text(
                                        ' Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 21),
                                _customInputField(
                                  label: 'Username / E-mail',
                                  controller: emailController,
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(height: 15),
                                _customInputField(
                                  label: 'Password',
                                  controller: passwordController,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 6),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/forgot_password');
                                    },
                                    child: const Text(
                                      'Forget password',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2E69DF),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                      ),
                                      onPressed: loading ? null : login,
                                      child: loading
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.1,
                                              ),
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                if (error.isNotEmpty) ...[
                                  const SizedBox(height: 11),
                                  Center(
                                    child: Text(
                                      error,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.65),
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white60, fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}
