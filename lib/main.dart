import 'package:flutter/material.dart';
import './text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _vcodeController = TextEditingController();
  //分别定义两个输入框的焦点 用于切换焦点
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodePwd = FocusNode();
  final FocusNode _nodeVCode = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _vcodeController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    print('name $name');
    String password = _passwordController.text;
    print('password $password');
    if (name.isEmpty || name.length < 11) {
      setState(() {
        _isClick = false;
      });
      return;
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    setState(() {
      _isClick = true;
    });
  }

  _login() {
    print('login action');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text('验证码登录'),
            onPressed: null,
          )
        ],
      ),
      // resizeToAvoidBottomPadding: false, //输入框抵住键盘
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '密码登录',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 16,
          ),
          MyTextField(
            focusNode: _nodeName,
            placeHolder: '请输入账号',
            maxLength: 11,
            keyboardType: TextInputType.phone,
            controller: _nameController,
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            focusNode: _nodePwd,
            placeHolder: '请输入密码',
            maxLength: 16,
            controller: _passwordController,
            isInputPwd: true,
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            focusNode: _nodeVCode,
            placeHolder: '请输入验证码',
            maxLength: 6,
            controller: _vcodeController,
            keyboardType: TextInputType.phone,
            getVCode: () {
              print('获取验证码');
            },
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 25),
            height: 44,
            color: Color(0xFF4688FA),
            child: FlatButton(
              disabledColor: Color(0xFF96BBFA),
              disabledTextColor: Color(0xFFD4E2FA),
              textColor: Colors.white,
              color: Color(0xFF4688FA),
              //必填参数，按下按钮时触发的回调，接收一个方法，传null表示按钮禁用，会显示禁用相关样式
              onPressed: _isClick ? _login : null,
              child: Text(
                '登录',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 16,
            alignment: Alignment.topRight,
            child: FlatButton(
              child: Text(
                '忘记密码',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF999999),
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                '还没账号？快去注册',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4688FA),
                ),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
