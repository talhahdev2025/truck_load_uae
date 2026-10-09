import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/breakpoints.dart';
import '../controllers/load_booking_controller.dart';
import 'booking_success_dialog.dart';

class LoadBookingForm extends ConsumerStatefulWidget {
  const LoadBookingForm({super.key});

  @override
  ConsumerState<LoadBookingForm> createState() => _LoadBookingFormState();
}

class _LoadBookingFormState extends ConsumerState<LoadBookingForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _pickupController;
  late final TextEditingController _dropoffController;
  late final TextEditingController _cargoController;
  late final TextEditingController _pickupTimeController;

  DateTime _selectedDateTime = DateTime.now().add(const Duration(hours: 2));

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _pickupController = TextEditingController();
    _dropoffController = TextEditingController();
    _cargoController = TextEditingController();
    _pickupTimeController = TextEditingController(
      text: DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    _cargoController.dispose();
    _pickupTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryContainer,
              onPrimary: AppColors.onPrimary,
              surface: AppColors.surfaceContainer,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primaryContainer,
                onPrimary: AppColors.onPrimary,
                surface: AppColors.surfaceContainer,
                onSurface: AppColors.onSurface,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null && mounted) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
          _pickupTimeController.text = DateFormat(
            'yyyy-MM-dd HH:mm',
          ).format(_selectedDateTime);
        });
      }
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final truckType = ref.read(selectedTruckTypeProvider);
      ref
          .read(loadBookingControllerProvider.notifier)
          .submitBooking(
            fullName: _nameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            pickupLocation: _pickupController.text.trim(),
            dropoffLocation: _dropoffController.text.trim(),
            truckType: truckType,
            preferredPickupTime: _selectedDateTime,
            cargoDescription: _cargoController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(loadBookingControllerProvider);
    final selectedTruckType = ref.watch(selectedTruckTypeProvider);
    final isDesktop = Breakpoints.isDesktop(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 896),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: EdgeInsets.all(isDesktop ? 40 : 20),
      child: Stack(
        children: [
          // The Main Form
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 2-Column Grid on Tablet/Desktop, 1-Column on Mobile
                if (isDesktop) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildNameField()),
                      const SizedBox(width: 20),
                      Expanded(child: _buildPhoneField()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildPickupField()),
                      const SizedBox(width: 20),
                      Expanded(child: _buildDropoffField()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTruckTypeField(selectedTruckType)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildPickupTimeField()),
                    ],
                  ),
                ] else ...[
                  _buildNameField(),
                  const SizedBox(height: 18),
                  _buildPhoneField(),
                  const SizedBox(height: 18),
                  _buildPickupField(),
                  const SizedBox(height: 18),
                  _buildDropoffField(),
                  const SizedBox(height: 18),
                  _buildTruckTypeField(selectedTruckType),
                  const SizedBox(height: 18),
                  _buildPickupTimeField(),
                ],
                const SizedBox(height: 20),

                // Cargo Specifications
                _buildCargoField(),
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  onPressed: bookingState.isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: bookingState.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.onPrimary,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send_rounded, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              'Submit Load Request',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 12),

                // Footnote
                Text(
                  'By submitting, your manifest is broadcasted directly to our senior fleet dispatch officer in JAFZA South.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Dynamic Success Overlay
          if (bookingState.value != null)
            Positioned.fill(
              child: BookingSuccessDialog(
                booking: bookingState.value!,
                onReset: () {
                  ref.read(loadBookingControllerProvider.notifier).reset();
                  _nameController.clear();
                  _phoneController.clear();
                  _pickupController.clear();
                  _dropoffController.clear();
                  _cargoController.clear();
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Full Name / Company Name *'),
        TextFormField(
          controller: _nameController,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(
            hintText: 'e.g. Al Futtaim Logistics / Tariq Mansoor',
            suffixIcon: Icon(
              Icons.badge_outlined,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter your name or company';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('WhatsApp / Phone Number (+971) *'),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(
            hintText: '+971 50 000 0000',
            suffixIcon: Icon(
              Icons.phone_outlined,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please provide a valid phone number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPickupField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Pickup Location (Zone / Free Zone) *'),
        TextFormField(
          controller: _pickupController,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(
            hintText: 'e.g. JAFZA South Gate 4, Al Quoz 3',
            suffixIcon: Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter pickup location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropoffField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Drop-off Destination *'),
        TextFormField(
          controller: _dropoffController,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(
            hintText: 'e.g. Mussafah ICAD 1, Sharjah Industrial 10',
            suffixIcon: Icon(
              Icons.pin_drop_outlined,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter drop-off destination';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTruckTypeField(String selectedTruckType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Select Truck Requirement *'),
        DropdownButtonFormField<String>(
          initialValue: selectedTruckType,
          isExpanded: true,
          dropdownColor: AppColors.surfaceContainerHigh,
          style: const TextStyle(color: AppColors.onSurface, fontSize: 14),
          icon: const Icon(
            Icons.expand_more,
            color: AppColors.onSurfaceVariant,
            size: 20,
          ),
          decoration: const InputDecoration(),
          items: const [
            DropdownMenuItem(value: '3-ton', child: Text('3-Ton Pickup')),
            DropdownMenuItem(value: '1-ton', child: Text('1-Ton Pickup')),
            DropdownMenuItem(value: '7-ton', child: Text('7-Ton Heavy Truck')),
            DropdownMenuItem(
              value: 'flatbed',
              child: Text('Flatbed Open Trailer'),
            ),
            DropdownMenuItem(
              value: 'chiller',
              child: Text('Chiller / Freezer Box'),
            ),
          ],
          onChanged: (val) {
            if (val != null) {
              ref.read(selectedTruckTypeProvider.notifier).state = val;
            }
          },
        ),
      ],
    );
  }

  Widget _buildPickupTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Preferred Pickup Time *'),
        InkWell(
          onTap: _pickDateTime,
          borderRadius: BorderRadius.circular(12),
          child: IgnorePointer(
            child: TextFormField(
              controller: _pickupTimeController,
              style: const TextStyle(color: AppColors.onSurface),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCargoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Cargo Description, Weight & Special Requirements'),
        TextFormField(
          controller: _cargoController,
          maxLines: 3,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(
            hintText:
                'Describe items, weight (e.g. 2,400 kg), number of standard pallets, gate pass availability (e.g. JAFZA DP World Pass needed)...',
          ),
        ),
      ],
    );
  }
}
