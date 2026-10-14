import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/registration.dart';
import '../theme/styles.dart';
import 'confirmation_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final Event event;
  const RegistrationScreen({super.key, required this.event});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _year;

  static const years = ['1st year', '2nd year', '3rd year', '4th year'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Labels sit ABOVE the fields (no floating labels), so nothing overlaps.
  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      );

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );

  InputDecoration _deco(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: brandMid),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: _border(const Color(0xFFD9D4E8)),
        enabledBorder: _border(const Color(0xFFD9D4E8)),
        focusedBorder: _border(brandMid, 2),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red, 2),
      );

 void _submit() {
  if (!_formKey.currentState!.validate()) return;

  // The event may have filled up while the form was open.
  if (widget.event.isFull) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sorry, this event is now full.')),
    );
    return;
  }

  FocusScope.of(context).unfocus();

  // The count goes up only after the form passed validation.
  widget.event.registered++;

  final registration = Registration(
    event: widget.event,
    name: _nameController.text.trim(),
    email: _emailController.text.trim(),
    year: _year!,
  );

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => ConfirmationScreen(registration: registration),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(32)),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(gradient: brandGradient),
              padding: EdgeInsets.fromLTRB(
                  8, MediaQuery.of(context).padding.top + 8, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Register for',
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 2),
                        Text(event.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.schedule,
                                size: 16, color: Colors.white70),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(event.date,
                                  style:
                                      const TextStyle(color: Colors.white70)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 18),

                    _label('Full name'),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: _deco('Enter your full name', Icons.person),
                      // TODO 1: null or only spaces -> error message.
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null; // null means valid
                      },
                    ),
                    const SizedBox(height: 18),

                    _label('Email address'),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: _deco('name@example.com', Icons.email),
                      // TODO 2: empty -> one message, wrong format -> another.
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Pattern: text, then @, then text, then a dot,
                        // then text. No spaces allowed anywhere.
                        final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                        if (!pattern.hasMatch(email)) {
                          return 'Enter a valid email, e.g. name@example.com';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    _label('Year of study'),
                    DropdownButtonFormField<String>(
                      initialValue: _year,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(14),
                      decoration: _deco('Select your year', Icons.school),
                      items: years
                          .map((y) =>
                              DropdownMenuItem(value: y, child: Text(y)))
                          .toList(),
                      onChanged: (v) => setState(() => _year = v),
                      validator: (v) =>
                          v == null ? 'Please select your year of study' : null,
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.how_to_reg),
                        label: const Text('Submit registration'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}