import 'package:flutter/material.dart';

enum FleetStatus {
  available('Available'),
  onDemand('On Demand'),
  certified('Certified');

  const FleetStatus(this.label);
  final String label;
}

class FleetTruck {
  final String id;
  final String name;
  final String payload;
  final String description;
  final FleetStatus status;
  final IconData icon;
  final bool isPopular;
  final String bookingTruckTypeValue;

  const FleetTruck({
    required this.id,
    required this.name,
    required this.payload,
    required this.description,
    required this.status,
    required this.icon,
    this.isPopular = false,
    required this.bookingTruckTypeValue,
  });
}
