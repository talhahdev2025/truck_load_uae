import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/quick_inquiry_controller.dart';

class QuickInquiryForm extends ConsumerStatefulWidget {
  const QuickInquiryForm({super.key});

  @override
  ConsumerState<QuickInquiryForm> createState() => _QuickInquiryFormState();
}

class _QuickInquiryFormState extends ConsumerState<QuickInquiryForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _contactController;
  late final TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contactController = TextEditingController();
    _detailsController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(quickInquiryControllerProvider.notifier).submitInquiry(
            name: _nameController.text.trim(),
            contact: _contactController.text.trim(),
            details: _detailsController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inquiryState = ref.watch(quickInquiryControllerProvider);

    // Listen to success
    ref.listen<AsyncValue<bool>>(quickInquiryControllerProvider, (prev, next) {
      if (next.hasValue && next.value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.secondaryContainer,
            content: Text(
              'Inquiry transmitted to TruckLoad UAE corporate desk. An account officer will respond shortly.',
              style: TextStyle(color: AppColors.onSecondary, fontWeight: FontWeight.w600),
            ),
          ),
        );
        _nameController.clear();
        _contactController.clear();
        _detailsController.clear();
        ref.read(quickInquiryControllerProvider.notifier).reset();
      }
    });

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send a Message to Fleet Management',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Have tender inquiries, monthly corporate contract requirements, or specialized questions?',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 500;
                if (isWide) {
                  return Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Your Name',
                          hint: 'Khalid Bin Rashid',
                          controller: _nameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          label: 'Phone / Email',
                          hint: 'khalid@company.ae or +971 50...',
                          controller: _contactController,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildTextField(
                        label: 'Your Name',
                        hint: 'Khalid Bin Rashid',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 14),
                      _buildTextField(
                        label: 'Phone / Email',
                        hint: 'khalid@company.ae or +971 50...',
                        controller: _contactController,
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Inquiry Details',
              hint:
                  'Specify your recurring route requirements, weight, or custom schedule...',
              controller: _detailsController,
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: inquiryState.isLoading ? null : _handleSubmit,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerHigh,
                side: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.6),
                ),
                foregroundColor: AppColors.onSurface,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: inquiryState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: AppColors.onSurface),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
