import 'package:flutter/material.dart';
import '../../domain/entities/fleet_truck.dart';

abstract final class MockFleetData {
  static const List<FleetTruck> trucks = [
    FleetTruck(
      id: '1-ton',
      name: '1-Ton Pickup',
      payload: 'Payload: Up to 1,000 kg',
      description:
          'For smaller commercial deliveries, rapid inner-city errands, and express courier packages.',
      status: FleetStatus.available,
      icon: Icons.local_shipping_outlined,
      bookingTruckTypeValue: '1-ton',
    ),
    FleetTruck(
      id: '3-ton',
      name: '3-Ton Pickup',
      payload: 'Payload: Up to 3,500 kg',
      description:
          'The UAE industrial workhorse. Ideal for general cargo, heavy machinery components, cartons, and pallet freight.',
      status: FleetStatus.available,
      icon: Icons.rv_hookup,
      isPopular: true,
      bookingTruckTypeValue: '3-ton',
    ),
    FleetTruck(
      id: '7-ton',
      name: '7-Ton Truck',
      payload: 'Payload: Up to 7,000 kg',
      description:
          'For heavier industrial consignments, bulk palletized warehouse replenishment, and construction building material.',
      status: FleetStatus.onDemand,
      icon: Icons.fire_truck_outlined,
      bookingTruckTypeValue: '7-ton',
    ),
    FleetTruck(
      id: 'flatbed',
      name: 'Flatbed Trailer',
      payload: 'Payload: Open Deck Spec',
      description:
          'Tailored for crane-loaded machinery, structural steel rebar, oversized equipment, and pipe logistics.',
      status: FleetStatus.available,
      icon: Icons.grid_view_rounded,
      bookingTruckTypeValue: 'flatbed',
    ),
    FleetTruck(
      id: 'chiller',
      name: 'Chiller Box',
      payload: '+2°C down to -18°C',
      description:
          'Refrigerated container for perishables, pharmaceuticals, sensitive biochemicals, and cold-chain groceries.',
      status: FleetStatus.certified,
      icon: Icons.ac_unit,
      bookingTruckTypeValue: 'chiller',
    ),
  ];
}
