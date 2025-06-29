import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/navigation_service.dart';

class ModernBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const ModernBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  State<ModernBottomNavBar> createState() => _ModernBottomNavBarState();
}

class _ModernBottomNavBarState extends State<ModernBottomNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _iconAnimations;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _iconAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ),
          ),
        )
        .toList();

    _scaleAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(
            begin: 1.0,
            end: 1.1,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ),
          ),
        )
        .toList();

    // Start animation for current item
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(ModernBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      // Reset previous animation
      if (oldWidget.currentIndex < _animationControllers.length) {
        _animationControllers[oldWidget.currentIndex].reverse();
      }
      // Start new animation
      if (widget.currentIndex < _animationControllers.length) {
        _animationControllers[widget.currentIndex].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF2E7D8A),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D8A).withOpacity(0.3),
            offset: const Offset(0, 10),
            blurRadius: 30,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.currentIndex;

            return Expanded(
              child: _buildNavItem(item, index, isSelected),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavItem item, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap(index);
      },
      child: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background highlight
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 60 : 0,
              height: isSelected ? 60 : 0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(isSelected ? 0.2 : 0),
                borderRadius: BorderRadius.circular(30),
                border: isSelected 
                    ? Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      )
                    : null,
              ),
            ),
            
            // Icon and label
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with scale animation
                AnimatedBuilder(
                  animation: _scaleAnimations[index],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isSelected ? _scaleAnimations[index].value : 1.0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          isSelected && item.activeIcon != null 
                              ? item.activeIcon! 
                              : item.icon,
                          color: isSelected 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.6),
                          size: isSelected ? 26 : 22,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 4),
                
                // Label with fade animation
                AnimatedBuilder(
                  animation: _iconAnimations[index],
                  builder: (context, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isSelected ? 1.0 : 0.6,
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSelected ? 12 : 10,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    );
                  },
                ),
                
                // Active indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(top: 2),
                  width: isSelected ? 6 : 0,
                  height: isSelected ? 6 : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
