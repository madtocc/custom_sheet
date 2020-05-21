import 'package:flutter/material.dart';

class CustomSheet {
  BuildContext _context;
  Color _sheetColor;
  Color _secondColor;
  Color _textColor;
  Color _subTextColor;
  double _secondColorPercent;
  bool _active = false;

  CustomSheet(
    {BuildContext context,
    Color sheetColor,
    Color secondColor,
    Color textColor,
    Color subTextColor,
    double secondColorPercent}){
      if(context==null){
        this._sheetColor = sheetColor;
        this._secondColor = secondColor;
        this._textColor = textColor;
        this._subTextColor = subTextColor;
        this._secondColorPercent = secondColorPercent??0.1;
      }
      else{
        this._context = context;
        this._secondColorPercent = secondColorPercent??0.1;
        this._sheetColor = sheetColor ?? Theme.of(context).accentColor;
        this._secondColor = secondColor ??
            _getSecondColor(sheetColor);
        this._textColor = textColor ??
            _getTxtColor(sheetColor);
        this._subTextColor = subTextColor ??
            _getTxtColor(secondColor);
      }
    }

    set context(BuildContext context) => _context ??= context;
    set sheetColor(Color color) => _sheetColor = color;
    set secondColor(Color color) => _secondColor = color;
    set textColor(Color color) => _textColor = color;
    set subTextColor(Color color) => _subTextColor = color;


    void setColors({BuildContext context,Color sheetColor, Color secondColor, Color textColor, Color subTextColor}){
      _sheetColor=sheetColor;
      _secondColor=secondColor;
      _textColor=textColor;
      _subTextColor=subTextColor;
      _fillColors(context);
    }
    
    void clearColors({BuildContext context}){
      _sheetColor=null;
      _secondColor=null;
      _textColor=null;
      _subTextColor=null;
      _fillColors(context);
    }
    void _fillColors(BuildContext context){
      if(context!=null && _context==null)
        _context = context;
      if(_context!=null){
        _sheetColor = _sheetColor ?? Theme.of(_context).accentColor;
        _secondColor = _secondColor ?? _getSecondColor(_sheetColor);
        _textColor = _textColor ?? _getTxtColor(_sheetColor);
        _subTextColor = _subTextColor ?? _getTxtColor(_secondColor);
        }
    }
    

  Color _getTxtColor(Color color) =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  Color _getSecondColor(Color color) {
    assert(_secondColorPercent >= 0 && _secondColorPercent < 0.5);
    HSVColor hsv = HSVColor.fromColor(color);
    double val = hsv.value > 0.5 ? hsv.value - _secondColorPercent : hsv.value + _secondColorPercent;
    return hsv.withValue(val).toColor();
  }

  Future<bool> dismiss({int milliseconds = 300}) async {
    if (_active) {
      _active = false;
      return Future.delayed(Duration(milliseconds: milliseconds), () {
        Navigator.of(_context).pop();
        return true;
      });
    } else
      return false;
  }

  void showLoading(
      {BuildContext context,String loadingMsg, bool isDismissible, bool block, bool enableDrag,Color progressColor}) {
    showBS(
        context: context,
        body: _loading(loadingMsg ?? "Loading ...", _textColor,progressColor: progressColor),
        isDismissible: isDismissible ?? false,
        enableDrag: enableDrag ?? false,
        blockBackButton: block ?? true);
  }

  Future<void> showTitleBody(
      {BuildContext context,
      String title,
      String body,
      bool isDismissible = true,
      bool blockBackButton = false,
      bool enableDrag = true,
      bool bodySecondColorEnabled = false}) {
    return showTitleBodyButtons<void, void>(
        context: context,
        title: title,
        body: body,
        isDismissible: isDismissible,
        blockBackButton: blockBackButton,
        enableDrag: enableDrag,
        bodySecondColorEnabled: bodySecondColorEnabled);
  }

  Future<T2> showTitleBodyButtons<T1, T2>(
      {BuildContext context,
      String title,
      String body,
      bool isDismissible = true,
      bool blockBackButton = false,
      List<T1> options,
      bool enableDrag = true,
      bool bodySecondColorEnabled = false,
      double buttonHeight}) {
    return showBS<T1, T2>(
        context: context,
        top: _modalTitle(title, _textColor),
        body: _modalBody(body, _subTextColor,
            bodySecondColorEnabled ? _secondColor : _sheetColor),
        isDismissible: isDismissible,
        blockBackButton: blockBackButton,
        options: options,
        enableDrag: enableDrag,
        buttonHeight: buttonHeight ?? 65);
  }

  Future<T2> showBS<T1, T2>(
      {BuildContext context,
      Widget top,
      Widget body,
      List<T1> options,
      bool isDismissible = true,
      bool blockBackButton = false,
      bool enableDrag = true,
      double buttonHeight = 65}) {
        if(_context == null && context != null){
          _context=context;
          _fillColors(_context);
        }
    _active = true;
    return showModalBottomSheet(
      enableDrag: enableDrag,
      context: _context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => (isDismissible || !blockBackButton),
          child: Container(
            color: _sheetColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                top == null ? Container() : top,
                body == null ? Container() : body,
                options == null
                    ? Container()
                    : Container(
                        color: _secondColor,
                        child: Column(
                            children: options is List<OptionButton>
                                ? List<OptionButton>.from(options)
                                    .map((opt) => _OptionButton(
                                        opt, _sheetColor, _subTextColor,
                                        buttonHeight: buttonHeight))
                                    .toList()
                                : options.map((widget) => widget).toList()))
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _modalTitle(String title, Color color) {
  return title == null
      ? Container()
      : Container(
          width: double.infinity,
          padding: EdgeInsets.all(30.0),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18.0, color: color),
            textAlign: TextAlign.center,
          ),
        );
}

Widget _modalBody(String body, Color color, Color bodyColor) {
  return body == null
      ? Container()
      : Container(
          width: double.infinity,
          color: bodyColor,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Text(body,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 15.0, color: color),
              textAlign: TextAlign.start));
}

Widget _loading(String msg, Color textcolor,{Color progressColor}) {
  return Container(
      margin: EdgeInsets.only(top: 20, bottom: 50, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Text(msg,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  color: textcolor),
              textAlign: TextAlign.start),
          SizedBox(height: 30),
          CircularProgressIndicator(
              // backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor??textcolor))
        ],
      ));
}

class OptionButton {
  VoidCallback onTap;
  String text;
  OptionButton(this.text, this.onTap);
}

class _OptionButton extends StatelessWidget {
  final OptionButton optionButton;
  final Color color;
  final Color textColor;
  final double buttonHeight;

  _OptionButton(this.optionButton, this.color, this.textColor,
      {this.buttonHeight});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: color,
          onTap: optionButton.onTap,
          child: SizedBox(
              height: buttonHeight - 1,
              width: double.infinity,
              child: Center(
                child: Text(
                  this.optionButton.text,
                  style: TextStyle(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ))),
    );
  }
}
