import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo gradiente fixo
          Container(
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
          ),
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho com botão de voltar
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.go('/userProfile');
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Assinaturas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Cartão VIP
                        _buildPlanCard(
                          context,
                          title: 'Plano VIP',
                          description: [
                            '- 45 Encontroos possíveis (+125% comparado ao padrão)',
                            '- 4 Superlikes por dia',
                            '- Participação em até 4 eventos',
                            '- 10 Rewinds por dia',
                            '- 10 Likes diários (+100% comparado ao padrão)',
                          ],
                          color: const Color(0xFF6B09B5),
                          icon: Icons.star,
                          price: 'R\$ 29,90/mês',
                          onSubscribe: () {
                            print('Assinatura VIP selecionada');
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Cartão All Access
                        _buildPlanCard(
                          context,
                          title: 'Plano All Access',
                          description: [
                            '- 80 Encontroos possíveis (+300% comparado ao padrão)',
                            '- 10 Superlikes por dia',
                            '- Participação em até 7 eventos',
                            '- 20 Rewinds por dia',
                            '- 25 Likes diários (+400% comparado ao padrão)',
                          ],
                          color: const Color(0xFFFF7825),
                          icon: Icons.diamond,
                          price: 'R\$ 49,90/mês',
                          onSubscribe: () {
                            print('Assinatura All Access selecionada');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required List<String> description,
    required Color color,
    required IconData icon,
    required String price,
    required VoidCallback onSubscribe,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.white,
                child: Icon(icon, color: color, size: 20.sp),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          for (var item in description)
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: onSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                ),
                child: Text(
                  'Assinar',
                  style: TextStyle(
                    color: color,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}