import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  String error = '';
  bool loading = false;

  Future<void> signUp() async {
    setState(() {
      error = '';
      loading = true;
    });

    if (passwordController.text != confirmController.text) {
      setState(() {
        error = "Passwords do not match!";
        loading = false;
      });
      return;
    }
    if (passwordController.text.length < 6) {
      setState(() {
        error = "Password must be at least 6 characters.";
        loading = false;
      });
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      // Optionally, save/displayname as username
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(usernameController.text.trim());

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message ?? 'Sign up failed.';
      });
    } finally {
      setState(() {
        loading = false;
      });
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
              padding: const EdgeInsets.fromLTRB(16, 56, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar with back arrow and logo/title
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 4),
                      // Logo & Appname
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              19,
                            ), // set radius to half the height/width for circular image
                            child: Image.asset(
                              'assets/gitnote_logo.png',
                              height: 38,
                              width: 38,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'GitNote',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              color: Colors.white,
                              letterSpacing: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: Container(
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade900.withOpacity(0.13),
                            blurRadius: 26,
                            offset: const Offset(0, 13),
                          ),
                        ],
                        gradient: const RadialGradient(
                          colors: [Color(0xFF2E518F), Color(0xFF19254A)],
                          center: Alignment.topLeft,
                          radius: 1.15,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 30, 28, 23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create Account',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 29,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        " Sign In",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _customInputField(
                                  label: 'Username',
                                  controller: usernameController,
                                  icon: Icons.person_outline,
                                  isPassword: false,
                                  showToggle: false,
                                ),
                                const SizedBox(height: 12),
                                _customInputField(
                                  label: 'Email',
                                  controller: emailController,
                                  icon: Icons.email_outlined,
                                  isPassword: false,
                                  showToggle: false,
                                ),
                                const SizedBox(height: 12),
                                _customInputField(
                                  label: 'Password',
                                  controller: passwordController,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  showToggle: true,
                                  isVisible: passwordVisible,
                                  toggleVisibility: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                                _customInputField(
                                  label: 'Confirm Password',
                                  controller: confirmController,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  showToggle: true,
                                  isVisible: confirmPasswordVisible,
                                  toggleVisibility: () {
                                    setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    });
                                  },
                                ),
                                const SizedBox(height: 24),
                                Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF2E69DF,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                        ),
                                      ),
                                      onPressed: loading ? null : signUp,
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
                                              'Sign up',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                if (error.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Center(
                                      child: Text(
                                        error,
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
    bool showToggle = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.67),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.13),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !(isVisible) : false,
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
          suffixIcon: showToggle
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white.withOpacity(0.78),
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
