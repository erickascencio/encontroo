import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // Para navegação

class PromoterFooter extends StatelessWidget {
  final int activeTab; // Índice da aba ativa
  final Function(int) onTabChanged; // Callback para mudar aba ativa

  const PromoterFooter({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h, // Altura reduzida (antes era maior)
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h), // Ajuste no espaçamento interno
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaçamento uniforme
          children: [
            FooterIconButton(
              icon: Icons.star,
              label: 'Meus Eventos',
              isActive: activeTab == 0,
              onTap: () {
                if (activeTab != 0) {
                  context.go('/promHome'); // Navegar para a Home
                }
                onTabChanged(0); // Atualizar aba ativa
              },
            ),
            FooterIconButton(
              icon: Icons.add_circle_outline,
              label: 'Adicionar Evento',
              isActive: activeTab == 1,
              onTap: () {
                if (activeTab != 1) {
                  context.go('/createEvent'); // Navegar para Adicionar Evento
                }
                onTabChanged(1); // Atualizar aba ativa
              },
            ),
            FooterIconButton(
              icon: Icons.person_outline,
              label: 'Perfil',
              isActive: activeTab == 2,
              onTap: () {
                if (activeTab != 2) {
                  context.go('/promProfile'); // Navegar para o Perfil
                }
                onTabChanged(2); // Atualizar aba ativa
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FooterIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FooterIconButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80.w, // Define uma largura fixa para uniformizar os botões
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20.sp, // Ícone levemente menor
              color: isActive ? const Color(0xFFFF7825) : const Color(0xFF6B09B5),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? const Color(0xFFFF7825) : const Color(0xFF6B09B5),
                fontSize: 10.sp, // Texto ligeiramente menor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
