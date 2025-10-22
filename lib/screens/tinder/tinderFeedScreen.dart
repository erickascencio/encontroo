import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/components/tinderCard.dart';
import 'package:encontroo/components/tinderMainLayout.dart';
import 'package:lottie/lottie.dart';

class TinderFeedScreen extends StatefulWidget {
  const TinderFeedScreen({Key? key}) : super(key: key);

  @override
  State<TinderFeedScreen> createState() => _TinderFeedScreenState();
}

class _TinderFeedScreenState extends State<TinderFeedScreen> {
  bool showMatchPopup = false; // Controlador para exibir o popup

  void _checkForMatch() {
    // Simula o match após o like
    setState(() {
      showMatchPopup = true;
    });

    // Fechar o popup após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showMatchPopup = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TinderMainLayout(
          activeTab: 0, // Aba ativa no rodapé
          // Título do cabeçalho com o ícone à esquerda
          customAppBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/encontroicon.png', // Ícone do aplicativo
                  height: 30.h, // Ajustando dinamicamente o tamanho com ScreenUtil
                  width: 30.w,
                ),
                SizedBox(width: 8.w), // Espaçamento entre o ícone e o título
                Text(
                  'Encontroo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp, // Ajustando dinamicamente o tamanho do texto
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              // Calcular dinamicamente o tamanho do card com base no espaço disponível
              final double availableHeight = constraints.maxHeight * 0.95;

              return Center(
                child: TinderCard(
                  height: availableHeight, // Altura dinâmica do card
                  imageUrls: ['assets/man.jpg', 'assets/googleicon.png'], // Lista de imagens
                  name: 'Alice',
                  age: '25',
                  description:
                      'Alice é uma entusiasta de viagens e adora fotografia. Passou o último ano explorando novos lugares e culturas.',
                  onLike: _checkForMatch, // Chamar a função de verificar match
                  onDislike: () {
                    print('Disliked!');
                  },
                  onSuperLike: () {
                    print('Super Liked!');
                  },
                  onRewind: () {
                    print('Rewind!');
                  },
                ),
              );
            },
          ),
        ),
        // Exibir o popup de match se showMatchPopup for true
        if (showMatchPopup)
          _buildMatchPopup(),
      ],
    );
  }

  Widget _buildMatchPopup() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.7), // Fundo semi-transparente
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animação de confete com Lottie
              Lottie.asset(
                'assets/hearth.json', // Adicione um arquivo Lottie de coração
                width: 300.w,
                height: 300.h,
                fit: BoxFit.cover,
              ),
              // Conteúdo do popup
              Positioned(
                bottom: 50.h, // Ajuste para posicionar o texto abaixo do coração
                child: Text(
                  'Deu Encontroo!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
