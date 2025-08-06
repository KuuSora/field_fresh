import 'dart:ui';
import 'package:flutter/material.dart';
import 'otp_success.dart';

class OTPVerificationDialog extends StatefulWidget {
  const OTPVerificationDialog({super.key});

  @override
  State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
}

class _OTPVerificationDialogState extends State<OTPVerificationDialog> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());
  String? _errorText;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _checkOTP() {
    final enteredOTP = _controllers.map((c) => c.text).join();
    if (_controllers.every((c) => c.text.isNotEmpty)) {
      if (enteredOTP == '1111') {
        setState(() {
          _errorText = null;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const OTPSuccessDialog(),
        );
      } else {
        setState(() {
          _errorText = 'OTP code is incorrect. Please check the code.';
        });
      }
    } else {
      setState(() {
        _errorText = 'Please fill all OTP boxes.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          // Centered window
          Center(
            child: Container(
              width: 340,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Back arrow
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Title
                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF175C2B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Error message
                  if (_errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _errorText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  // Subtitle
                  const Text(
                    'Please enter OTP code.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // OTP boxes with auto-focus
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Color(0xFFEAF1F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                            }
                            if (value.isEmpty && index > 0) {
                              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF175C2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _checkOTP,
                      child: const Text(
                        'VERIFY',
                      style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', 
                    ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Resend OTP button
                  TextButton(
                    onPressed: () {
                      // TODO: Implement resend OTP logic
                    },
                    child: const Text(
                      'RESEND OTP CODE',
                      style: TextStyle(
                        color: Color(0xFF175C2B),
                        fontWeight: FontWeight.bold,
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
}