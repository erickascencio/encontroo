import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:encontroo/components/promFooter.dart';

class PromProfileScreen extends StatefulWidget {
  const PromProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<PromProfileScreen> {
  int activeTab = 2; // Aba ativa inicialmente como 'Perfil'

  void onTabChanged(int index) {
    setState(() {
      activeTab = index;
    });

    if (index == 0) {
      context.go('/promHome'); // Vai para Meus Eventos
    } else if (index == 1) {
      context.go('/createEvent'); // Vai para Adicionar Evento
    } else if (index == 2) {
      // Permanece na página atual (Perfil)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6B09B5), // Roxo
                  Color(0xFFFF7825), // Laranja
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Cabeçalho
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          onPressed: () {
                            showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(1000, 80, 10, 0),
                              items: [
                                PopupMenuItem(
                                  value: 'faq',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.help_outline, size: 18),
                                      SizedBox(width: 8.w),
                                      const Text('FAQ'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'support',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.mail_outline, size: 18),
                                      SizedBox(width: 8.w),
                                      const Text('Suporte'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'logout',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.exit_to_app, size: 18),
                                      SizedBox(width: 8.w),
                                      const Text('Sair'),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Corpo
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Imagem de Perfil
                        CircleAvatar(
                          radius: 70.r, // Aumentado para 60
                          
                          backgroundColor: Colors.grey[200],
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton.icon(
                          onPressed: () {
                            print('Editar Perfil');
                            context.go('/promEditProfile');
                          },
                          icon: Icon(Icons.edit, size: 16.sp),
                          label: Text(
                            'Editar Perfil',
                            style: TextStyle(fontSize: 14.sp), // Texto maior
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9B3FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            minimumSize: Size(160.w, 36.h), // Botão mais largo
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Informações Gerais
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Informações Gerais',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Campos de informações
                        _buildInfoField('Nome', 'Nome da Empresa'),
                        _buildInfoField('CNPJ', '00.000.000/0001-00'),
                        _buildInfoField('E-mail', 'empresa@email.com'),
                        _buildInfoField('Endereço', 'Rua Exemplo, 123'),
                      ],
                    ),
                  ),
                ),
                // Rodapé
                PromoterFooter(
                  activeTab: activeTab,
                  onTabChanged: onTabChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: const Color(0xFF6B09B5),
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
