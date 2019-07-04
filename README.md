# flutter_textfield
封装了一个简单的textfield：

- maxLength：支持设置最大输入长度 默认长度16
-  isInputPwd：输入密码（掩码） 默认false
- getVCode：获取验证码倒计时的输入框  countdown 倒计时秒数 默认60s
- autoFocus：是否自动获得焦点  eg:进入搜索页面 一进页面就调起键盘
- keyboardType: 键盘类型 eg:TextInputType.phone 只调取数字键盘
- placeHolder：eg: 请输入账号
- 输入内容后，支持一键删除
- 密码输入支持显示(隐藏)

效果图如下 一个简单的登录页面：

![image-20190704103303264](http://ww2.sinaimg.cn/large/006tNc79ly1g4nlple3gtj30kq0emdgw.jpg)



![image-20190704103334946](http://ww3.sinaimg.cn/large/006tNc79ly1g4nlq4eimsj30js0dy3zc.jpg)



![image-20190704103351785](http://ww4.sinaimg.cn/large/006tNc79ly1g4nlqgnqwpj30km0e8dh0.jpg)



![image-20190704103415107](http://ww3.sinaimg.cn/large/006tNc79ly1g4nlqtqeqhj30jw0di0ti.jpg)



![image-20190704103517287](http://ww4.sinaimg.cn/large/006tNc79ly1g4nlrwndrzj30kq0e80u0.jpg)

使用：

 MyTextField(

​            focusNode: _nodeName,

​            placeHolder: '请输入账号',

​            maxLength: 11,

​            keyboardType: TextInputType.phone,

​            controller: _nameController,

​          ),

备注：键盘弹起会报错

![image-20190704103119978](http://ww4.sinaimg.cn/large/006tNc79ly1g4nlns97x8j31il0u0nct.jpg)

简单暴力的解决方式：

![image-20190704103152023](http://ww3.sinaimg.cn/large/006tNc79ly1g4nlocvjoyj31bw0kk429.jpg)