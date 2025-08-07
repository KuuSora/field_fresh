import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart' as models;
import 'login_screen.dart';

// Appwrite setup
Client client = Client()
  .setEndpoint('https://nyc.cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
  .setProject('6892ed1d003d8b9dfc27'); // Replace with your project ID

Databases databases = Databases(client);

const String databaseId = '6892ed30001d2e66eb97';
const String collectionId = '6892edcd0036f3eae39d';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> storeUserInDatabase() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showMessageDialog("Error", "All fields are required.");
      return;
    }

    if (password != confirmPassword) {
      showMessageDialog("Error", "Passwords do not match.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final _ = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          'name': name,
          'phone': phone,
          'password': password, // ⚠️ Consider hashing in real apps
        },
      );

      showMessageDialog("Success", "User data stored successfully!", success: true);
    } on AppwriteException catch (e) {
      showMessageDialog("Failed", e.message ?? "Unknown error occurred.");
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
                'SIGN UP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF175C2B),
                ),
              ),
              const SizedBox(height: 24),

              // Input fields
              customInput("Full Name", nameController),
              const SizedBox(height: 16),
              customInput("Phone Number", phoneController, inputType: TextInputType.phone),
              const SizedBox(height: 16),
              customInput("Password", passwordController, obscureText: true),
              const SizedBox(height: 16),
              customInput("Re-type Password", confirmPasswordController, obscureText: true),
              const SizedBox(height: 24),

              // Sign Up Button
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
                  onPressed: isLoading ? null : storeUserInDatabase,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Log In Link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? Click here to '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Log In.',
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

  Widget customInput(String label, TextEditingController controller,
      {bool obscureText = false, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF175C2B),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: inputType,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEAF1F8),
              hintText: '*Required',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
