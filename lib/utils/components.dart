import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {
  final bool disabled;
  final String label;
  final VoidCallback onPressed;

  BorderedButton({
    this.label,
    this.onPressed,
    this.disabled = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = disabled ? kBorderColor : kPrimaryColor;
    return OutlineButton(
      borderSide: BorderSide(color: color, width: 2),
      child: Text(label),
      color: color,
      onPressed: disabled ? () {} : onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textColor: color,
    );
  }
}

class WidgetButton extends StatelessWidget {
  final Widget widget;
  final Function onPressed;
  final bool isPrimary;
  final double widthRatio;
  final Color color;

  WidgetButton({
    this.widget,
    this.onPressed,
    this.isPrimary = true,
    this.widthRatio = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final determinedColor = color != null ? color : kPrimaryColor;
    return Container(
      height: 50,
      width: widthRatio != null ? kCalculatedWidth(size) * widthRatio : null,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: determinedColor,
        ),
        child: widget,
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final Widget prefix;
  final String hintText;
  final String labelText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTap;
  final bool isTextObscured;
  final bool isReadOnly;
  final double width;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;

  const RoundedInputField({
    Key key,
    this.prefix,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.width,
    this.backgroundColor,
    this.isTextObscured = false,
    this.keyboardType = TextInputType.text,
    this.textEditingController,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    var color = backgroundColor ?? theme.scaffoldBackgroundColor;
    if (isReadOnly) {
      color = color.withAlpha(140);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: kSmallPadding),
      width: width != null ? width : kCalculatedWidth(size),
      decoration: kTextFieldBoxDecoration.copyWith(color: color),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        keyboardType: keyboardType,
        obscureText: isTextObscured,
        cursorColor: kPrimaryColor,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          prefix: prefix,
          hintText: hintText,
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPadding),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPadding),
            borderSide: BorderSide(
              color: kTranPrimaryColor,
            ),
          ),
          hintStyle: theme.textTheme.subtitle2.copyWith(
              fontSize: 14, color: kColorGrey, fontWeight: FontWeight.w500),
        ),
        style: theme.textTheme.subtitle2.copyWith(
            fontSize: 14,
            color: kPrimaryTextColor,
            fontWeight: FontWeight.w500),
        controller: textEditingController,
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 0);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
