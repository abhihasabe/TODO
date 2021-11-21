import 'package:flutter/material.dart';
import 'package:todoapptask/theme/colors.dart';

ButtonTheme raisedButton(
    { VoidCallback onClick,
      String text,
      Color textColor,
      Color color,
      Color splashColor,
      double borderRadius,
      double minWidth,
      double height,
      Color borderSideColor,
      TextStyle style,
      Widget leadingIcon,
      Widget trailingIcon}) {
  return ButtonTheme(
    minWidth: minWidth,
    height: height,
    child: RaisedButton(
        splashColor: Colors.grey.withOpacity(0.5) ?? buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            side: BorderSide(color: borderSideColor ?? color)),
        textColor: Colors.white,
        color: primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // This is must when you are using Row widget inside Raised Button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLeadingIcon(leadingIcon),
            Text(
              text ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
            ),
            _buildtrailingIcon(trailingIcon),
          ],
        ),
        onPressed: () {
          return onClick();
        }),
  );
}

Widget _buildLeadingIcon(Widget leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget _buildtrailingIcon(Widget trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}
