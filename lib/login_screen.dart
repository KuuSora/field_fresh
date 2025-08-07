import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'otp_verification_screen.dart';
import 'otp_success.dart';
import 'sign_up.dart';
import 'shop_dashboard.dart';
// Appwrite setup
Client client = Client()
  .setEndpoint('https://nyc.cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
  .setProject('6892ed1d003d8b9dfc27'); // Replace with your Appwrite project ID

Databases databases = Databases(client);

const String databaseId = '6892ed30001d2e66eb97';
const String collectionId = '6892edcd0036f3eae39d';

// Pseudocode for LoginScreen
enum LoginStep { login, otp, success }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStep _step = LoginStep.login;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void showMessageDialog(String title, String content, {bool success = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: TextStyle(color: success ? Colors.green : Colors.red)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (success) {
                // On success, navigate to OTP screen or dashboard
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => OTPVerificationWidget(
                    onSuccess: () {
                      // Move to the next step, e.g., show OTPSuccessWidget or navigate
                    },
                    onClose: () {
                      // Go back to the login form or previous step
                    },
                  ),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> loginUser() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      showMessageDialog("Error", "All fields are required.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final models.DocumentList result = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal("phone", phone),
          Query.equal("password", password), // ⚠️ Insecure in real-world
        ],
      );

      if (result.documents.isEmpty) {
        showMessageDialog("Login Failed", "Invalid credentials.");
      } else {
        // Instead of navigating, set the step to OTP
        setState(() {
          _step = LoginStep.otp;
        });
        // Optionally show a dialog or message if you want
      }
    } on AppwriteException catch (e) {
      showMessageDialog("Error", e.message ?? "Unknown error.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget popup;
    bool showPopup = false;

    switch (_step) {
      case LoginStep.otp:
        showPopup = true;
        popup = OTPVerificationWidget(
          onSuccess: () => setState(() => _step = LoginStep.success),
          onClose: () => setState(() => _step = LoginStep.login),
        );
        break;
      case LoginStep.success:
        showPopup = true;
        popup = OTPSuccessWidget(
          onProceed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ShopDashboard(userPhone: phoneController.text.trim()),
              ),
            );
          },
        );
        break;
      default:
        popup = const SizedBox.shrink();
    }

    return Scaffold(
      body: Stack(
        children: [
          // Your main login form
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.asset('assets/fieldfresh_logo.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF175C2B),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Phone Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEAF1F8),
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEAF1F8),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF175C2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: isLoading ? null : loginUser,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Forgot Password
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color(0xFF175C2B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign Up Link
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New user? Click here to ',
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up.',
                            style: TextStyle(
                              color: Color(0xFF175C2B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Popup overlay
          if (showPopup)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {}, // Prevent taps from passing through
                child: Stack(
                  children: [
                    // Blur and semi-transparent background
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    // Centered popup
                    Center(child: popup),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
