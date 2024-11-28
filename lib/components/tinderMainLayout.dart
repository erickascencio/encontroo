import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TinderMainLayout extends StatelessWidget {
  final int? activeTab; // Aba ativa no footer (opcional)
  final String? title; // Título da tela (agora opcional)
  final Widget body; // Corpo da tela
  final Widget? customAppBar; // AppBar personalizado (opcional)
  final bool hideFooter; // Ocultar o rodapé dinamicamente

  const TinderMainLayout({
    Key? key,
    this.activeTab, // Caso seja nulo, o layout não terá footer
    this.title, // Título agora opcional
    required this.body,
    this.customAppBar,
    this.hideFooter = false, // Por padrão, o rodapé não é oculto
  }) : super(key: key);

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
                // AppBar personalizado ou título padrão
                if (customAppBar != null)
                  customAppBar!
                else if (title != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Center(
                      child: Text(
                        title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Corpo dinâmico
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
      // Footer fixo apenas se `activeTab` não for nulo e `hideFooter` for falso
      bottomNavigationBar: (activeTab != null && !hideFooter)
          ? BottomNavigationBar(
              currentIndex: activeTab!,
              onTap: (index) {
                // Navegação baseada no índice da aba
                switch (index) {
                  case 0:
                    context.go('/tinderFeed'); // Navega para "Feed"
                    break;
                  case 1:
                    context.go('/matchs'); // Navega para "Meus Matches"
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.people, color: Color(0xFFFF7825)),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: Color(0xFFFF7825)),
                  label: 'Encontroos',
                ),
              ],
              selectedItemColor: const Color(0xFF6B09B5),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
            )
          : null,
    );
  }
}

