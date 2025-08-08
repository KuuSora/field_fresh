import 'package:flutter/material.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final _nameController = TextEditingController();
  final _stocksController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _discountController = TextEditingController();

  bool scheduleDiscount = false;
  bool exclusivePremium = false;
  String visibility = 'Published';
  DateTime? discountDate;
  DateTime? scheduledDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.red, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'ADD NEW PRODUCT',
                style: TextStyle(
                  color: Color(0xFF175C2B),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),
              // Product Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'Carrots',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              // Stocks and Price
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _stocksController,
                      decoration: const InputDecoration(
                        labelText: 'Stocks',
                        hintText: '123',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: 'Input Price',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Input',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                minLines: 1,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              // Product Images
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Images',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Main image
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/carrots.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Add image slots
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: const Icon(Icons.add_photo_alternate, color: Color(0xFF175C2B), size: 28),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Schedule a discount
              Row(
                children: [
                  Checkbox(
                    value: scheduleDiscount,
                    activeColor: const Color(0xFF175C2B),
                    onChanged: (val) => setState(() => scheduleDiscount = val ?? false),
                  ),
                  const Text(
                    'Schedule a discount',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              if (scheduleDiscount)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _discountController,
                        decoration: const InputDecoration(
                          labelText: 'Discount',
                          hintText: '% or amount',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => discountDate = picked);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text(
                                discountDate != null
                                    ? "${discountDate!.year}-${discountDate!.month.toString().padLeft(2, '0')}-${discountDate!.day.toString().padLeft(2, '0')}"
                                    : 'Aug 8, 2025',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              // Visibility
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Visibility',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Published',
                    groupValue: visibility,
                    activeColor: const Color(0xFF175C2B),
                    onChanged: (val) => setState(() => visibility = val!),
                  ),
                  const Text('Published'),
                  Radio<String>(
                    value: 'Hidden',
                    groupValue: visibility,
                    activeColor: const Color(0xFF175C2B),
                    onChanged: (val) => setState(() => visibility = val!),
                  ),
                  const Text('Hidden'),
                  Radio<String>(
                    value: 'Scheduled',
                    groupValue: visibility,
                    activeColor: const Color(0xFF175C2B),
                    onChanged: (val) => setState(() => visibility = val!),
                  ),
                  const Text('Scheduled'),
                  if (visibility == 'Scheduled')
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => scheduledDate = picked);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text(
                                scheduledDate != null
                                    ? "${scheduledDate!.year}-${scheduledDate!.month.toString().padLeft(2, '0')}-${scheduledDate!.day.toString().padLeft(2, '0')}"
                                    : 'Aug 11, 2025',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Exclusive for premium buyers
              Row(
                children: [
                  Checkbox(
                    value: exclusivePremium,
                    activeColor: const Color(0xFF175C2B),
                    onChanged: (val) => setState(() => exclusivePremium = val ?? false),
                  ),
                  const Text(
                    'Exclusive for premium buyers',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Publish Button
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175C2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.publish, color: Colors.white),
                  label: const Text(
                    'Publish',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  onPressed: () {
                    // Handle publish logic here
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}