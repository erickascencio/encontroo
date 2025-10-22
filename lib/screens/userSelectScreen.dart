import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserSelectScreen extends StatelessWidget {
  const UserSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo aumentada em 10%
                Image.asset(
                  'assets/logoencontro.png',
                  height: 275.h, // Aumento de 10% no tamanho da logo
                ),
                SizedBox(height: 30.h), // Espaçamento proporcional

                // Botão para Usuário (levemente maior)
                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  width: 190.w, // Largura ajustada
                  height: 40.h, // Altura ajustada
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(color: Colors.white, width: 1.w),
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/userLogin');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.white, size: 18.sp), // Ícone ajustado
                        SizedBox(width: 8.w),
                        Text(
                          'Usuário',
                          style: TextStyle(fontSize: 15.sp, color: Colors.white), // Texto ajustado
                        ),
                      ],
                    ),
                  ),
                ),

                // Botão para Divulgador (levemente maior)
                Container(
                  width: 190.w, // Largura ajustada
                  height: 40.h, // Altura ajustada
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(color: Colors.white, width: 1.w),
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/promLogin');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.campaign, color: Colors.white, size: 18.sp), // Ícone ajustado
                        SizedBox(width: 8.w),
                        Text(
                          'Divulgador',
                          style: TextStyle(fontSize: 15.sp, color: Colors.white), // Texto ajustado
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
