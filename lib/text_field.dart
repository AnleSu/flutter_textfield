import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Utils {
  static String getImagePath(String name,{String format:"png"}) {
    return "assets/images/$name.$format";
  }
}

///自定义输入框 支持设置最长输入长度 支持获取验证码 密码掩码输入 支持设置键盘类型 支持placeholder
class MyTextField extends StatefulWidget {
  const MyTextField({
    Key key,
    @required this.controller,
    this.maxLength: 16,
    this.autoFocus: false,
    this.keyboardType: TextInputType.text,
    this.focusNode,
    this.placeHolder,
    this.isInputPwd: false,
    this.getVCode,
    this.countdown: 60,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus; //是否自动获得焦点 比如进入搜索页面 一进页面就调起键盘
  final TextInputType keyboardType;
  final FocusNode focusNode; //焦点
  final String placeHolder;
  final bool isInputPwd;
  final Function getVCode;

  /// 倒计时的秒数，默认60秒。
  final int countdown;
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowDelete = true; //是否显示删除
  bool _isShowPwd = false;
  bool _isAvailableGetVCode = true; //是否可以获取验证码，默认为`false`
  String _verifyStr = '获取验证码';

  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
    _seconds = widget.countdown;
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds--;
      _isAvailableGetVCode = false;
      _verifyStr = '已发送(${_seconds}s)';
      if (_seconds == 0) {
        _verifyStr = '重新获取';
        _isAvailableGetVCode = true;
        _seconds = widget.countdown;
        _cancelTimer();
      }
      setState(() {});
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          autofocus: widget.autoFocus,
          keyboardType: widget.keyboardType,
          obscureText: widget.isInputPwd ? !_isShowPwd : false,
          // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
          inputFormatters: (widget.keyboardType == TextInputType.number ||
                  widget.keyboardType == TextInputType.phone)
              ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
              : [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 14.0),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            counterText: '',
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 0.8,
            )),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 0.8,
            )),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /**
             * 控制child是否显示
             *
                当offstage为true，控件隐藏； 当offstage为false，显示；
                当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。

                const Offstage({ Key key, this.offstage = true, Widget child })
            */
            Offstage(
                offstage: _isShowDelete,
                child: Container(
                  // margin: EdgeInsets.only(right: 16),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Image.asset(
                      Utils.getImagePath('login/icon_delete'),
                      width: 18.0,
                      height: 18.0,
                    ),
                    onTap: () {
                      setState(() {
                        widget.controller.text = "";
                      });
                    },
                  ),
                )),
            Offstage(
              offstage: !widget.isInputPwd,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: InkWell(
                  child: Image.asset(
                    _isShowPwd
                        ? Utils.getImagePath('login/icon_display')
                        : Utils.getImagePath('login/icon_hide'),
                    width: 18.0,
                    height: 18.0,
                  ),
                  onTap: () {
                    setState(() {
                      _isShowPwd = !_isShowPwd;
                    });
                  },
                ),
              ),
            ),
            Offstage(
                offstage: widget.getVCode == null,
                child: Container(
                    width: 100,
                    height: 24,
                    decoration: new BoxDecoration(
                        border: new Border.all(
                            color: _isAvailableGetVCode
                                ? Color(0xFF689EFD)
                                : Color(0xFFCCCCCC),
                            width: 0.5)),
                    child: FlatButton(
                      disabledColor: Color(0xFFCCCCCC),
                      onPressed: _seconds == widget.countdown ? () {
                        _startTimer();
                        widget.getVCode();
                      } : null,
                      child: Text(
                        '$_verifyStr',
                        maxLines: 1,
                        style: TextStyle(
                          
                          fontSize: 12,
                          color: _isAvailableGetVCode
                              ? Color(0xFF689EFD)
                              : Color(0xFFFFFFFF),
                        ),
                      ),
                    )))
          ],
        )
      ],
    );
  }
}
