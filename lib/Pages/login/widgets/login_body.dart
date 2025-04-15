import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';
import 'package:drive_safe/apps/router/router_name.dart';
import 'package:drive_safe/service/api_service.dart';
import 'package:drive_safe/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _googleAuth = AuthService();
  bool _isLoginLoading = false;
  bool _isGoogleLoading = false;
  bool _showError = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _login() async {
    setState(() {
      _isLoginLoading = true;
      _showError = false;
    });

    try {
      // Lấy thông tin email và mật khẩu từ các trường nhập liệu
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Kiểm tra xem email và mật khẩu có rỗng hay không
      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _showError = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
        );
        return;
      }

      // Thực hiện đăng nhập với Firebase Authentication
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kiểm tra xem người dùng đã đăng nhập thành công chưa
      if (userCredential.user != null) {
        if (mounted) {
          context.goNamed(RouterName.home); // Chuyển đến màn hình chính
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công!')),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý lỗi khi đăng nhập
      setState(() {
        _showError = true;
      });
      debugPrint('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: ${e.message ?? 'Lỗi không xác định'}')),
      );
    } catch (e) {
      // Xử lý các lỗi khác
      setState(() {
        _showError = true;
      });
      debugPrint('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoginLoading = false);
      }
    }
  }


  Future<void> _signInWithGoogle() async {
    await _googleAuth.signOutFromGoogle();
    setState(() => _isGoogleLoading = true);
    
    try {
      final userCredential = await _googleAuth.signInWithGoogle();
      if (userCredential != null && mounted) {
        context.goNamed(RouterName.home); // Chuyển đến màn hình chính
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập Google thành công!')),
        );
      }
    } catch (e) {
      setState(() {
        _showError = true;
      debugPrint('Login google error: $e');
      });
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/DRIVESAFE.svg',
          ),
          const SizedBox(height: 30),

          Text(
            'Nhập email và mật khẩu để đăng nhập',
            style: AppTextStyles.miniText(isDarkMode),
          ),
          const SizedBox(height: 5),

          _buildTextField(context, hintText: 'Email', controller: _emailController),
          const SizedBox(height: 10),

          _buildTextField(context, hintText: 'Mật khẩu', obscureText: true, controller: _passwordController),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (_showError) Text('Email hoặc mật khẩu không đúng!', style: AppTextStyles.warningText()),
              const Spacer(),
              Text(
                'Quên mật khẩu?',
                style: AppTextStyles.resetPassText(),
              ),
            ],
          ),
          const SizedBox(height: 5),

          ElevatedButton(
            onPressed: _isLoginLoading ? null : _login,
            style: ButtonStyles.buttonOne(isDarkMode),
            child: Text(
              'ĐĂNG NHẬP',
              style: AppTextStyles.textButton(isDarkMode),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 1,
            width: 340,
            color: isDarkMode ? MyColor.blued : MyColor.blueDark,
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: _isGoogleLoading ? null : _signInWithGoogle,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? MyColor.darkCard : MyColor.white,
              minimumSize: const Size(300, 40),
            ),
            child: Text(
              'Đăng nhập bằng Google',
              style: AppTextStyles.google(isDarkMode),
            ),
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản?',
                style: AppTextStyles.menuItem(isDarkMode),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  context.goNamed(RouterName.register);
                },
                child: Text(
                  'Đăng kí',
                  style: AppTextStyles.menuItem(isDarkMode).copyWith(color: Colors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {
    required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 49),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.hintText(isDarkMode),
          filled: true,
          fillColor: isDarkMode ? MyColor.darkCard : MyColor.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.grey,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.grey,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
