import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // Certifique-se de que GoRouter está configurado

class PromLoginScreen extends StatelessWidget {
  PromLoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF7825), // Laranja
              Color(0xFF6B09B5), // Roxo
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 80.h,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/logoencontro.png',
                        height: 200.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 20.h),

                      // Campos de login
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            // Campo de email
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.2),
                                hintText: 'Digite seu email',
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.white),
                                  onPressed: () => emailController.clear(),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.h), // Espaço entre os campos

                            // Campo de senha
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black.withValues(alpha: 0.2),
                                hintText: 'Digite sua senha',
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.white),
                                  onPressed: () => passwordController.clear(),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Botão de Entrar
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF7825), // Laranja
                                Color(0xFF6B09B5), // Roxo
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Ação de login
                              context.go('/promHome');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              minimumSize: Size(double.infinity, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Camada de opacidade
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Botão de Login com Google
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Ação de login com Google
                          },
                          icon: Image.asset(
                            'assets/googleicon.png',
                            height: 20.h,
                          ),
                          label: Text(
                            'Login com Google',
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.4), // Fundo ainda mais transparente
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            minimumSize: Size(double.infinity, 40.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Link de criar conta
                      GestureDetector(
                        onTap: () {
                          // Navegar para a tela de cadastro
                          GoRouter.of(context).go('/register'); // Alterar para a rota desejada
                        },
                        child: Text(
                          'Crie Sua conta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 224, 109, 42), // Laranja claro
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
