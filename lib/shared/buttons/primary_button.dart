import 'package:uniordle/shared/buttons/select_button_wrapper.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final IconData? icon;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool showShadow;
  final bool resizeLabel;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.surfaceVariant,
    this.isLoading = false,
    this.icon,
    this.height,
    this.width,
    this.borderRadius,
    this.showShadow = false,
    this.resizeLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveWidth = width ?? MediaQuery.of(context).size.width * 0.9;
    
    final double ratioHeight = effectiveWidth * (2 / 15);
    final double effectiveHeight = height ?? ratioHeight;
    
    final double effectiveRadius = borderRadius ?? effectiveHeight / 2;

    return SelectButtonWrapper(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: effectiveWidth,
        height: effectiveHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: context.r(20),
                    offset: Offset(0, context.r(10)),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading 
              ? _buildLoader(context, effectiveHeight) 
              : _buildContent(context, effectiveHeight),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context, double buttonHeight) {
    final double loaderSize = buttonHeight * 0.4;
    return SizedBox(
      height: loaderSize,
      width: loaderSize,
      child: const CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    );
  }

  Widget _buildContent(BuildContext context, double buttonHeight) {
    final double iconSize = buttonHeight * 0.45;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize, color: Colors.white),
          SizedBox(width: context.r(8)),
        ],
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.r(8)),
            child: resizeLabel
                ? context.autoText(
                    label.toUpperCase(),
                    style: AppFonts.labelLarge,
                    minSize: 12,
                    maxSize: 18,
                  )
                : Text(
                    label.toUpperCase(),
                    style: AppFonts.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
          ),
        ),
      ],
    );
  }
}