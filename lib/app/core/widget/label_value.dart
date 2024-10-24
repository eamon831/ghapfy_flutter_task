import '/app/core/exporter.dart';

class LabelValue extends StatelessWidget {
  final String? label;
  final String? value;
  final String? dividerText;
  final double? labelFontSize;
  final double? valueFontSize;
  final int? labelFlex;
  final int? valueFlex;
  final TextAlign? valueTextAlign;
  final TextAlign? labelTextAlign;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final int? labelFontWeight;
  final int? valueFontWeight;
  final Color? labelColor;
  final Color? valueColor;
  final Color? borderColor;
  final double? borderWidth;

  final String? fontFamily;

  const LabelValue({
    required this.label,
    required this.value,
    super.key,
    this.dividerText,
    this.labelFontSize = 14,
    this.valueFontSize,
    this.labelFlex,
    this.valueFlex,
    this.labelFontWeight,
    this.valueFontWeight,
    this.labelColor,
    this.valueColor,
    this.labelTextAlign,
    this.valueTextAlign,
    this.margin,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.fontFamily,
  });

  LabelValue copyWith({
    String? label,
    String? value,
    String? dividerText,
    double? labelFontSize,
    double? valueFontSize,
    int? labelFlex,
    int? valueFlex,
    TextAlign? valueTextAlign,
    TextAlign? labelTextAlign,
    EdgeInsets? margin,
    EdgeInsets? padding,
    int? labelFontWeight,
    int? valueFontWeight,
    Color? labelColor,
    Color? valueColor,
    Color? borderColor,
    double? borderWidth,
    String? fontFamily,
  }) {
    return LabelValue(
      key: key,
      label: label ?? this.label,
      value: value ?? this.value,
      dividerText: dividerText ?? this.dividerText,
      labelFontSize: labelFontSize ?? this.labelFontSize,
      valueFontSize: valueFontSize ?? this.valueFontSize,
      labelFlex: labelFlex ?? this.labelFlex,
      valueFlex: valueFlex ?? this.valueFlex,
      labelFontWeight: labelFontWeight ?? this.labelFontWeight,
      valueFontWeight: valueFontWeight ?? this.valueFontWeight,
      labelColor: labelColor ?? this.labelColor,
      valueColor: valueColor ?? this.valueColor,
      labelTextAlign: labelTextAlign ?? this.labelTextAlign,
      valueTextAlign: valueTextAlign ?? this.valueTextAlign,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.only(right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: labelFlex ?? 1,
            child: Text(
              label ?? 'Empty Label',
              textAlign: labelTextAlign,
              style: TextStyle(
                fontSize: labelFontSize ?? 16,
                fontWeight: defaultFontWeight[labelFontWeight ?? 500],
                color: labelColor ?? Colors.black,
                fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              dividerText ?? ':',
              style: TextStyle(
                fontSize: valueFontSize ?? 16,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: valueFlex ?? 2,
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                value ?? 'Empty Value',
                textAlign: valueTextAlign,
                style: TextStyle(
                  fontSize: valueFontSize ?? 15,
                  fontWeight: defaultFontWeight[valueFontWeight ?? 500],
                  color: valueColor ?? Colors.black.withOpacity(0.6),
                  fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
