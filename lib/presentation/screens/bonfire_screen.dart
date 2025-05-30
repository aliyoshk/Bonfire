import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class StrollBonfireScreen extends StatefulWidget {
  const StrollBonfireScreen({super.key});

  @override
  State<StrollBonfireScreen> createState() => _StrollBonfireScreenState();
}

class _StrollBonfireScreenState extends State<StrollBonfireScreen>
    with TickerProviderStateMixin {
  String? selectedOption;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _selectOption(String option) {
    HapticFeedback.lightImpact();
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 375;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lake_sunset.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: isSmallScreen ? 12 : 20,
                    ),
                    child: _buildHeader(),
                  ),
                ),

                const Spacer(),

                // Main Content
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildMainContent(isSmallScreen),
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),

                // Bottom Navigation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildBottomNavigation(),
                ),

                SizedBox(height: isSmallScreen ? 20 : 34),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '9:41',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            // Signal bars
            Row(
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 3,
                  height: 4 + (index * 2).toDouble(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              }),
            ),
            const SizedBox(width: 5),
            // WiFi icon
            const Icon(
              Icons.wifi,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 5),
            // Battery
            Container(
              width: 24,
              height: 12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 8,
                  margin: const EdgeInsets.only(left: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainContent(bool isSmallScreen) {
    return Column(
      children: [
        // Title and Stats
        Text(
          'Stroll Bonfire',
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 32 : 36,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.access_time,
              color: Colors.white70,
              size: 16,
            ),
            const SizedBox(width: 4),
            const Text(
              '22h 00m',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.person_outline,
              color: Colors.white70,
              size: 16,
            ),
            const SizedBox(width: 4),
            const Text(
              '103',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

        SizedBox(height: isSmallScreen ? 40 : 60),

        // User Profile and Question
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/images/angelina_profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Question Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Angelina, 28',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'What is your favorite time of the day?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    '"Mine is definitely the peace in the morning."',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: isSmallScreen ? 24 : 32),

        // Answer Options
        _buildAnswerOptions(isSmallScreen),

        SizedBox(height: isSmallScreen ? 20 : 24),

        // Action Prompt
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.yellow.withValues(alpha: 0.5), width: 1),
          ),
          child: Column(
            children: [
              const Text(
                'Pick your option.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'See who has a similar mind.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerOptions(bool isSmallScreen) {
    final options = [
      {'key': 'A', 'text': 'The peace in the early mornings', 'selected': true},
      {'key': 'B', 'text': 'The magical golden hours'},
      {'key': 'C', 'text': 'Wind-down time after dinners'},
      {'key': 'D', 'text': 'The serenity past midnight', 'highlighted': true},
    ];

    return Column(
      children: options.map((option) {
        final isSelected = selectedOption == option['key'] ||
            (selectedOption == null && (option['selected'] == true));
        final isHighlighted = option['highlighted'] == true;

        return GestureDetector(
          onTap: () => _selectOption(option['key'] as String),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.yellow.withValues(alpha: 0.8)
                    : isHighlighted
                    ? Colors.purple.withValues(alpha: 0.6)
                    : Colors.white.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.yellow.withValues(alpha: 0.2)
                        : isHighlighted
                        ? Colors.purple.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.1),
                    border: Border.all(
                      color: isSelected
                          ? Colors.yellow
                          : isHighlighted
                          ? Colors.purple
                          : Colors.white.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      option['key'] as String,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.yellow
                            : isHighlighted
                            ? Colors.purple
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    option['text'] as String,
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
      }).toList(),
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Action buttons
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 16,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right side - Profile and Next
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: const Icon(
                  Icons.mic_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}