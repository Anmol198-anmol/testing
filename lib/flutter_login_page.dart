import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectLoginPage extends StatefulWidget {
  const ConnectLoginPage({Key? key}) : super(key: key);

  @override
  State<ConnectLoginPage> createState() => _ConnectLoginPageState();
}

class _ConnectLoginPageState extends State<ConnectLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Main Content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 512),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildLoginForm(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F2F5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Logo/Icon
              Container(
                width: 16,
                height: 16,
                child: CustomPaint(
                  painter: ConnectLogoPainter(),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Connect',
                style: TextStyle(
                  color: Color(0xFF111418),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.015,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Handle sign up
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0F2F5),
              foregroundColor: const Color(0xFF111418),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(84, 40),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.015,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        // Title
        const Text(
          'Sign in to Connect',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111418),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        
        // Email/Username Field
        _buildInputField(
          label: 'Email or username',
          placeholder: 'Email or username',
          controller: _emailController,
        ),
        const SizedBox(height: 12),
        
        // Password Field
        _buildInputField(
          label: 'Password',
          placeholder: 'Password',
          controller: _passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 12),
        
        // Remember Me Checkbox
        _buildRememberMeCheckbox(),
        const SizedBox(height: 12),
        
        // Sign In Button
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              // Handle sign in
 _handleSignIn();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C77F2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.015,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Forgot Password Link
        TextButton(
          onPressed: () {
            // Handle forgot password
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              color: Color(0xFF60748A),
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> _signInWithApi(String email, String password) async {
    final url = Uri.parse('http://10.1.0.241:5000/auth/login');
    try {
      final response = await http.post(
        url,
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        // Handle successful login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else {
        // Handle login error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF111418),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 56,
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(
              color: Color(0xFF111418),
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFF60748A),
                fontSize: 16,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDBE0E6),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDBE0E6),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDBE0E6),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Remember me',
              style: TextStyle(
                color: Color(0xFF111418),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 28,
            height: 28,
            child: Checkbox(
              value: _rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              activeColor: const Color(0xFF0C77F2),
              checkColor: Colors.white,
              side: const BorderSide(
                color: Color(0xFFDBE0E6),
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSignIn() {
    // Implement sign in logic here
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    
 if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
 backgroundColor: Colors.red,),);
 return;
    }
    
    // Example: Navigate to next screen or show loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signing in...'),
        backgroundColor: Color(0xFF0C77F2),
      ),
    );
    
    _signInWithApi(email, password);
  }
}

// Custom painter for the Connect logo
class ConnectLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF111418)
      ..style = PaintingStyle.fill;

    // This creates a simplified version of the wavy logo from the SVG
    final path = Path();
    
    // Create a wavy pattern similar to the original SVG
    final width = size.width;
    final height = size.height;
    
    // First wave
    path.moveTo(width * 0.1, height * 0.8);
    path.quadraticBezierTo(width * 0.1, height * 0.2, width * 0.25, height * 0.5);
    path.quadraticBezierTo(width * 0.25, height * 0.8, width * 0.4, height * 0.2);
    
    // Second wave
    path.quadraticBezierTo(width * 0.4, height * 0.8, width * 0.55, height * 0.5);
    path.quadraticBezierTo(width * 0.55, height * 0.2, width * 0.7, height * 0.8);
    
    // Third wave
    path.quadraticBezierTo(width * 0.7, height * 0.2, width * 0.85, height * 0.5);
    path.quadraticBezierTo(width * 0.85, height * 0.8, width * 0.9, height * 0.2);
    
    // Close the path
    path.lineTo(width * 0.9, height);
    path.lineTo(width * 0.1, height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}