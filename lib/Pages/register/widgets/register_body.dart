import 'package:cloud_firestore/cloud_firestore.dart';
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
class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _googleAuth = AuthService();
  
  bool _isRegisterLoading = false;
  bool _isGoogleLoading = false;
  bool _showError = false;
  String _errorMessage = '';
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  Future<void> _register() async {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = 'Vui lòng điền đầy đủ thông tin';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _showError = true;
        _errorMessage = 'Mật khẩu không trùng khớp';
      });
      return;
    }

    setState(() {
      _isRegisterLoading = true;
      _showError = false;
    });

    try {
      // Đăng ký tài khoản Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        // Ghi thông tin người dùng vào Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'displayName': _nameController.text.trim(),
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          context.goNamed(RouterName.login);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng ký thành công! Vui lòng đăng nhập')),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showError = true;
        _errorMessage = e.message ?? 'Lỗi không xác định';
      });
    } catch (e) {
      setState(() {
        _showError = true;
        _errorMessage = 'Đăng ký thất bại: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() => _isRegisterLoading = false);
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
        _errorMessage = 'Lỗi đăng nhập Google: ${e.toString()}';
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
        children: [
          SvgPicture.asset(
            'assets/images/DRIVESAFE.svg',
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 10),
          Text(
            'Tạo tài khoản mới',
            style: AppTextStyles.title(isDarkMode),
          ),
          const SizedBox(height: 5),
          Text(
            'Điền thông tin bên dưới để tạo tài khoản',
            style: AppTextStyles.miniText(isDarkMode),
          ),
          if (_showError)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _errorMessage,
                style: AppTextStyles.warningText(),
              ),
            ),

          const SizedBox(height: 5),
          _buildTextField(context, hintText: 'Họ và tên', controller: _nameController),
          _buildTextField(context, hintText: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress,),
          _buildTextField(context, hintText: 'Mật khẩu', obscureText: true,  controller: _passwordController),
          _buildTextField(context, hintText: 'Nhập lại mật khẩu', obscureText: true, controller: _confirmPasswordController),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isRegisterLoading ? null : _register,
            style: ButtonStyles.buttonOne(isDarkMode),
            
            child: Text(
              'Đăng ký',
              style: AppTextStyles.textButton(isDarkMode),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            height: 2,
            width: 340,
            color: isDarkMode ? MyColor.darkCard : MyColor.button,
          ),
          const SizedBox(height: 5,),

          ElevatedButton(
            onPressed: _isGoogleLoading ? null : _signInWithGoogle,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? MyColor.darkCard : MyColor.white,
              minimumSize: const Size(300, 40),
            ),
            child: Text(
              'Đăng ký bằng Google',
              style: AppTextStyles.google(isDarkMode),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đã có tài khoản?',
                style: AppTextStyles.miniText(isDarkMode),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  context.goNamed(RouterName.login);
                },
                child: Text(
                  'Đăng nhập',
                  style: AppTextStyles.resetPassText(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hintText,
    bool obscureText = false,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 49, vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.hintText(isDarkMode),
          filled: true,
          fillColor: isDarkMode ? MyColor.darkCard : MyColor.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(33),
            borderSide: BorderSide(
              color: isDarkMode ? MyColor.darkText : MyColor.blued,
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