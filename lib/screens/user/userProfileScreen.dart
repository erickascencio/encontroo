import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:encontroo/components/userMainLayout.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return UserMainLayout(
      activeTab: 2, // Aba ativa como 'Perfil'
      title: 'Conta',
      customAppBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Stack(
          children: [
            // Ícone Premium à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  print('Premium clicked!');
                  context.go('/userSubscription');
                  // Navegação ou lógica para premium
                },
                child: FaIcon(
                  FontAwesomeIcons.crown, // Ícone de coroa
                  color: Colors.amber,
                  size: 24.sp,
                ),
              ),
            ),
            // Título centralizado
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
            // Ícone de configurações à direita
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem de perfil
            CircleAvatar(
              radius: 70.r,
              backgroundImage: const NetworkImage(
                  'https://via.placeholder.com/150'), // Imagem genérica
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/userEditProfile');
                print('Editar Perfil');
              },
              icon: Icon(Icons.edit, size: 16.sp),
              label: Text(
                'Editar Perfil',
                style: TextStyle(fontSize: 14.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9B3FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                minimumSize: Size(160.w, 36.h),
              ),
            ),
            SizedBox(height: 20.h),
            // Informações gerais
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
            _buildInfoField('Nome', 'João da Silva'),
            _buildInfoField('E-mail', 'joao.silva@email.com'),
            _buildInfoField('Endereço', 'Rua das Flores, 123, Cidade - Estado'),
            // Campo de descrição
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descrição',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Aqui vai a descrição do usuário. Adicione uma breve biografia ou informações relevantes.',
                style: TextStyle(
                  color: const Color(0xFF6B09B5),
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
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
