import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({this.buttonLables,
    this.buttonValues,
    this.radioButtonValue,
    this.buttonWidth,
    this.buttonColor,
    this.selectedColor,
    this.buttonHeight = 35,
    this.horizontal = false,
    this.enableShape = false,
    this.elevation = 10,
    this.customShape,
    this.fontSize = 15,
    this.lineSpace=5,
    this.buttonSpace,
    this.buttonBorderColor = const Color(0xFF2594B22B),
    this.textColor = Colors.black,
    this.selectedTextColor = Colors.white
  })
      : assert(buttonLables.length == buttonValues.length),
        assert(buttonColor != null),
        assert(selectedColor != null);

  final bool horizontal;
  final double fontSize;
  final List buttonValues;
  final double buttonSpace;
  final double buttonHeight;

  final double lineSpace;
  final List<String> buttonLables;

  final Function(dynamic) radioButtonValue;

  final Color selectedColor;
  final Color buttonBorderColor;
  final Color buttonColor;
  final Color textColor;
  final Color selectedTextColor;
  final ShapeBorder customShape;
  final bool enableShape;
  final double elevation;
  final double buttonWidth;

  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int currentSelected = 0;
  String currentSelectedLabel;

  @override
  void initState() {
    super.initState();
    currentSelectedLabel = widget.buttonLables[0];
  }

  List<Widget> buildButtonsColumn() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Card(
        color: currentSelectedLabel == widget.buttonLables[index]
            ? widget.selectedColor
            : widget.buttonColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape == null
            ? RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        )
            : widget.customShape
            : null,
        child: Container(
          height: widget.buttonHeight,
          width: widget.buttonWidth ?? null,
          constraints: BoxConstraints(maxWidth: 200),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape == null
                ? OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                  widget.buttonBorderColor /*.withOpacity(0.1)*/,
                  width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
                : widget.customShape
                : OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.buttonBorderColor /*.withOpacity(0.1)*/,
                  width: 1),
              borderRadius: BorderRadius.zero,
            ),
            onPressed: () {
              widget.radioButtonValue(widget.buttonValues[index]);
              setState(() {
                currentSelected = index;
                currentSelectedLabel = widget.buttonLables[index];
              });
            },
            child: Text(
              widget.buttonLables[index],
              style: TextStyle(
                color: currentSelectedLabel == widget.buttonLables[index]
                    ? widget.selectedTextColor
                    : widget.textColor,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  List<Widget> buildButtonsRow() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Card(
        color: currentSelectedLabel == widget.buttonLables[index]
            ? widget.selectedColor
            : widget.buttonColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape == null
            ? RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        )
            : widget.customShape
            : null,
        child: Container(
          height: widget.buttonHeight,
          width: widget.buttonWidth ?? null,
          constraints: BoxConstraints(maxWidth: 200),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape == null
                ? OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.buttonBorderColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
                : widget.customShape
                : OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.buttonBorderColor, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            onPressed: () {
              widget.radioButtonValue(widget.buttonValues[index]);
              setState(() {
                currentSelected = index;
                currentSelectedLabel = widget.buttonLables[index];
              });
            },
            child: Text(
              widget.buttonLables[index],
              style: TextStyle(
                color: currentSelectedLabel == widget.buttonLables[index]
                    ? widget.selectedTextColor
                    : widget.textColor,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return widget.horizontal
        ? Wrap(
      spacing: widget.buttonSpace, // gap between adjacent chips
      runSpacing: widget.lineSpace,
      children: buildButtonsColumn(),
    )
        : Wrap(
      direction: Axis.vertical,
      spacing: widget.buttonSpace, // gap between adjacent chips
      runSpacing: widget.lineSpace,
      children: buildButtonsRow(),
    );
  }
}