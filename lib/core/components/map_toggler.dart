import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapToggle extends StatelessWidget {
  final bool isShowBasarnas;
  final bool isShowPortPelabuhan;
  final bool isShowWpp;
  final VoidCallback onToggleBasarnas;
  final VoidCallback onTogglePortPelabuhan;
  final VoidCallback onToggleWpp;

  const MapToggle({
    Key? key,
    required this.isShowBasarnas,
    required this.isShowPortPelabuhan,
    required this.isShowWpp,
    required this.onToggleBasarnas,
    required this.onTogglePortPelabuhan,
    required this.onToggleWpp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            icon: FontAwesomeIcons.lifeRing,
            isActive: isShowBasarnas,
            onPressed: onToggleBasarnas,
            activeColor: Colors.blue.shade300,
          ),
          const SizedBox(height: 2),
          _buildToggleButton(
            icon: FontAwesomeIcons.towerObservation,
            isActive: isShowPortPelabuhan,
            onPressed: onTogglePortPelabuhan,
            activeColor: Colors.blue.shade300,
          ),
          const SizedBox(height: 2),
          _buildToggleButton(
            icon: FontAwesomeIcons.mapLocationDot,
            isActive: isShowWpp,
            onPressed: onToggleWpp,
            activeColor: Colors.blue.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    required Color activeColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 20,
          color: isActive ? activeColor : Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
