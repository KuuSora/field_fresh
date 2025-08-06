import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'sign_up.dart';
import 'otp_verification_screen.dart';

// Appwrite setup
Client client = Client()
  .setEndpoint('https://nyc.cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
  .setProject('6892f17b0031b2ada23a'); // Replace with your Appwrite project ID

Databases databases = Databases(client);

const String databaseId = '689347a20005460b2cd4';
const String collectionId = '68934809003656b8aa7b';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  builder: (_) => const OTPVerificationDialog(),
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
        showMessageDialog("Login Success", "Welcome back!", success: true);
      }
    } on AppwriteException catch (e) {
      showMessageDialog("Error", e.message ?? "Unknown error.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
    );
  }
}
