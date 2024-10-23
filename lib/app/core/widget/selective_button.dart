import '/app/core/exporter.dart';

class SelectiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool isSelected;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final double? elevation;
  final double? padding;
  final double? margin;
  final double? borderWidth;
  final Color? borderColor;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final double? iconPadding;
  final double? iconMargin;

  const SelectiveButton({
    required this.onPressed,
    super.key,
    this.text,
    this.isSelected = false,
    this.color = AppColors.buttonBgColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 4,
    this.elevation,
    this.padding = 6,
    this.margin,
    this.borderWidth,
    this.borderColor = Colors.black,
    this.icon,
    this.iconSize,
    this.iconColor = Colors.black,
    this.iconPadding = 10,
    this.iconMargin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        margin: EdgeInsets.all(margin ?? 0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: iconPadding ?? 0),
                child: Icon(
                  icon,
                  size: iconSize ?? 24,
                  color: iconColor,
                ),
              ),
            Text(
              text ?? '',
              style: TextStyle(
                color: isSelected ? textColor : Colors.black,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
