import 'dart:ui';

class AppColor {
  AppColor._(); //private contructor -> ngăn việc tạo class bên ngoài nghĩa là nó đã là singleton là không cho phép tạo instance nên là nó cũng không cho phép tạo bên ngoài luôn
  static const primaryColor = Color(0xff025FCA);

}