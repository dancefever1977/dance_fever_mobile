import 'dart:math';

import 'package:dance_fever/core/theme/app_colors.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_event.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  // ── Animation controllers ──
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final AnimationController _shimmerController;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance fade + slide
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeOutCubic,
          ),
        );
    _fadeController.forward();

    // Shimmer sweep on Google button
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Subtle pulsing glow behind title
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    context.read<AuthBloc>().add(
      AuthLoginWithGoogleRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Layer 1: Full-screen background image ──
          _buildBackground(),

          // ── Layer 2: Gradient overlay (bottom-up) ──
          _buildGradientOverlay(),

          // ── Layer 3: Vignette ──
          _buildVignette(),

          // ── Layer 4: Content ──
          _buildContent(context),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Background Image
  // ────────────────────────────────────────────────────────────────
  Widget _buildBackground() {
    return Positioned.fill(
      child: Transform.scale(
        scale: 1.05,
        child: Image.asset(
          'assets/images/breakdance_bg.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Gradient overlay — fades from transparent at top to solid at bottom
  // ────────────────────────────────────────────────────────────────
  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.4, 0.7, 1.0],
            colors: [
              AppColors.background.withValues(alpha: 0.0),
              AppColors.background.withValues(alpha: 0.3),
              AppColors.background.withValues(alpha: 0.75),
              AppColors.background,
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Vignette — radial inset shadow
  // ────────────────────────────────────────────────────────────────
  Widget _buildVignette() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Colors.transparent,
              AppColors.background.withValues(alpha: 0.85),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Main content — branding + auth buttons
  // ────────────────────────────────────────────────────────────────
  Widget _buildContent(BuildContext context) {
    return Positioned.fill(
      child: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // ── Hero branding at top ──
                  const SizedBox(height: 48),
                  _buildHeroBranding(),

                  const Spacer(),

                  // ── Auth buttons at bottom ──
                  _buildAuthSection(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Hero branding — "DANCE\nFEVER" title with electric text shadow
  // ────────────────────────────────────────────────────────────────
  Widget _buildHeroBranding() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Column(
          children: [
            // Electric glow behind text
            Text(
              'DANCE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                height: 1.05,
                letterSpacing: -2,
                color: AppColors.onSurface,
                shadows: [
                  Shadow(
                    color: AppColors.electricPurple.withValues(alpha: 0.8 * _pulseAnimation.value),
                    blurRadius: 20,
                  ),
                  Shadow(
                    color: AppColors.vibrantMagenta.withValues(alpha: 0.4 * _pulseAnimation.value),
                    blurRadius: 40,
                  ),
                ],
              ),
            ),
            Text(
              'FEVER',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                height: 1.05,
                letterSpacing: -2,
                color: AppColors.electricPurple,
                shadows: [
                  Shadow(
                    color: AppColors.electricPurple.withValues(alpha: 0.8 * _pulseAnimation.value),
                    blurRadius: 20,
                  ),
                  Shadow(
                    color: AppColors.vibrantMagenta.withValues(alpha: 0.4 * _pulseAnimation.value),
                    blurRadius: 40,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Auth section — Google button, Apple button, terms text
  // ────────────────────────────────────────────────────────────────
  Widget _buildAuthSection(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Google button with shimmer
              AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: isLoading ? null : _handleLogin,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.ghostWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.electricPurple.withValues(alpha: 0.0),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.electricPurple,
                              ),
                            )
                          : Stack(
                              children: [
                                // Shimmer sweep
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _ShimmerPainter(
                                      progress: _shimmerController.value,
                                      color: AppColors.electricPurple.withValues(alpha: 0.12),
                                    ),
                                  ),
                                ),
                                // Button content
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Google "G" logo
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CustomPaint(
                                          painter: _GoogleLogoPainter(),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'CONTINUE WITH GOOGLE',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.7,
                                          color: AppColors.surfaceContainerLowest,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Apple button
              _buildAppleButton(),
              const SizedBox(height: 20),

              // Terms & Privacy
              // _buildTermsText(),
            ],
          ),
        );
      },
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Google sign-in button — white with shimmer effect
  // ────────────────────────────────────────────────────────────────
  Widget _buildGoogleButton() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // TODO: Implement Google sign-in
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.ghostWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.electricPurple.withValues(alpha: 0.0),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Shimmer sweep
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ShimmerPainter(
                      progress: _shimmerController.value,
                      color: AppColors.electricPurple.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                // Button content
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google "G" logo
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CustomPaint(
                          painter: _GoogleLogoPainter(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'CONTINUE WITH GOOGLE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                          color: AppColors.surfaceContainerLowest,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Apple sign-in button — dark surface with outline
  // ────────────────────────────────────────────────────────────────
  Widget _buildAppleButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement Apple sign-in
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.outlineVariant,
            width: 1,
          ),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Apple logo
              Icon(
                Icons.apple,
                color: AppColors.onSurface,
                size: 22,
              ),
              SizedBox(width: 12),
              Text(
                'CONTINUE WITH APPLE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────
  // Terms & Privacy footer
  // ────────────────────────────────────────────────────────────────
  Widget _buildTermsText() {
    return Column(
      children: [
        const Text(
          'BY CONTINUING, YOU AGREE TO THE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Open Terms
              },
              child: Text(
                'TERMS OF SERVICE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: AppColors.vibrantMagenta,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.vibrantMagenta.withValues(alpha: 0.3),
                ),
              ),
            ),
            const Text(
              '  &  ',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: Open Privacy Policy
              },
              child: Text(
                'PRIVACY POLICY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: AppColors.vibrantMagenta,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.vibrantMagenta.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// Custom Painters
// ══════════════════════════════════════════════════════════════════

/// Paints a diagonal shimmer sweep across the Google button.
class _ShimmerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ShimmerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerWidth = size.width * 0.5;
    final start = -shimmerWidth + (size.width + shimmerWidth * 2) * progress;

    final paint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.transparent,
              color,
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(
            Rect.fromLTWH(start, 0, shimmerWidth, size.height),
          );

    canvas.save();
    canvas.rotate(pi / 8); // ~22.5° tilt
    canvas.drawRect(
      Rect.fromLTWH(start - size.width, -size.height, size.width * 3, size.height * 3),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) => progress != oldDelegate.progress;
}

/// Paints the 4-color Google "G" logo.
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;
    final double r = w * 0.45;

    // Blue arc (right side)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -pi / 4,
      -3 * pi / 4,
      false,
      bluePaint,
    );

    // Green arc (bottom-right)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      pi / 2 + pi / 12,
      -pi / 2 - pi / 12,
      false,
      greenPaint,
    );

    // Yellow arc (bottom-left)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      pi / 2 + pi / 12,
      pi / 2,
      false,
      yellowPaint,
    );

    // Red arc (top-left)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -pi + pi / 12,
      pi / 2,
      false,
      redPaint,
    );

    // Horizontal bar
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(cx, cy - w * 0.09, r + w * 0.05, w * 0.18),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
