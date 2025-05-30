import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnswerOptionWidget extends StatelessWidget {
  final String optionKey;
  final String optionText;
  final bool isSelected;
  final bool isHighlighted;
  final bool isSmallScreen;
  final VoidCallback onTap;

  const AnswerOptionWidget({
    super.key,
    required this.optionKey,
    required this.optionText,
    required this.isSelected,
    required this.isHighlighted,
    required this.isSmallScreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black.withValues(alpha: 0.4)
              : Colors.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getBorderColor(),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: _getAccentColor().withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            _buildOptionCircle(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 14 : 15,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCircle() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getAccentColor().withValues(alpha: 0.2),
        border: Border.all(
          color: _getAccentColor(),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          optionKey,
          style: TextStyle(
            color: _getAccentColor(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    if (isSelected) {
      return Colors.yellow.withValues(alpha: 0.8);
    } else if (isHighlighted) {
      return Colors.purple.withValues(alpha: 0.6);
    } else {
      return Colors.white.withValues(alpha: 0.2);
    }
  }

  Color _getAccentColor() {
    if (isSelected) {
      return Colors.yellow;
    } else if (isHighlighted) {
      return Colors.purple;
    } else {
      return Colors.white.withValues(alpha: 0.5);
    }
  }
}