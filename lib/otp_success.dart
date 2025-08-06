import 'package:flutter/material.dart';
import 'shop_dashboard.dart';

class OTPSuccessDialog extends StatelessWidget {
  const OTPSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(32),
      child: Container(
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
            const Icon(Icons.check_circle_outline, color: Color(0xFF175C2B), size: 48),
            const SizedBox(height: 16),
            const Text(
              'OTP verification successful!',
              style: TextStyle(
                color: Color(0xFF175C2B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF175C2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close success popup
                  Navigator.of(context).pop(); // Close OTP popup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopDashboard()),
                  );
                },
                child: const Text('PROCEED',style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', 
                    ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}