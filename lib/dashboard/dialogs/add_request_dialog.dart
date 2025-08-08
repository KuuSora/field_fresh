import 'dart:io';
import 'package:flutter/material.dart';

class AddRequestDialog extends StatefulWidget {
  final void Function(Map<String, dynamic>) onRequestAdded;
  const AddRequestDialog({super.key, required this.onRequestAdded});

  @override
  State<AddRequestDialog> createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
  List<Map<String, dynamic>> products = [
    {'name': '', 'quantity': '', 'unit': 'kg', 'progress': 0.0},
  ];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController descriptionController = TextEditingController();
  File? imageFile;

  void _showUnitSelector(int index) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEAF1F8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _unitRadio('bundle', index),
              _unitRadio('pcs', index),
              _unitRadio('kg', index),
            ],
          ),
        ),
      ),
    );
    if (selected != null) {
      setState(() {
        products[index]['unit'] = selected;
      });
    }
  }

  Widget _unitRadio(String value, int index) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: products[index]['unit'],
          onChanged: (val) {
            Navigator.of(context).pop(val);
          },
        ),
        Text(value),
      ],
    );
  }

  void _addProductField() {
    setState(() {
      products.add({'name': '', 'quantity': '', 'unit': 'kg', 'progress': 0.0});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFEAF1F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'NEW REQUEST',
                style: TextStyle(
                  color: Color(0xFF175C2B),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ...products.asMap().entries.map((entry) {
                int idx = entry.key;
                var prod = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Product',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              products[idx]['name'] = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Qty',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              products[idx]['quantity'] = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showUnitSelector(idx),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFFEAF1F8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            prod['unit'],
                            style: const TextStyle(
                              color: Color(0xFF175C2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF2D2D2D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add another product', style: TextStyle(fontSize: 13)),
                  onPressed: _addProductField,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) setState(() => selectedTime = time);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedTime != null
                              ? selectedTime!.format(context)
                              : '12:34 PM',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) setState(() => selectedDate = date);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedDate != null
                              ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                              : 'August 25, 2025',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.calendar_today, color: Color(0xFF175C2B)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Attachments', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      // onTap: _pickImage, // TODO: Add image picker logic if needed
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: imageFile == null
                            ? const Icon(Icons.image, color: Color(0xFF175C2B))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(imageFile!, fit: BoxFit.cover),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF175C2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    widget.onRequestAdded({
                      'products': products,
                      'date': selectedDate != null
                          ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                          : 'August 25, 2025',
                      'time': selectedTime != null
                          ? selectedTime!.format(context)
                          : '12:34 PM',
                      'description': descriptionController.text,
                      'image': imageFile,
                    });
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}