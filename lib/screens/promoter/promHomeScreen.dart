import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // Import do GoRouter
import 'package:encontroo/components/promFooter.dart';
import 'package:encontroo/components/promEventCard.dart';

class PromHomeScreen extends StatefulWidget {
  const PromHomeScreen({Key? key}) : super(key: key);

  @override
  _PromHomeScreenState createState() => _PromHomeScreenState();
}

class _PromHomeScreenState extends State<PromHomeScreen> {
  int activeTab = 0; // Aba ativa
  final List<Map<String, dynamic>> events = [
    {
      // Caminho local para o logo
      'imageUrl': 'assets/logoencontro.png',
      'title': 'Evento 1',
      'interestedCount': 78,
      'date': '28/12/2024',
      'description': 'Este é o evento 1. Aqui vai um',
      'location': 'Guarapuava, PR',
      'price': '75 R\$',
    },
    {
      // Caminho local para o ícone do Google
      'imageUrl': 'assets/googleicon.png',
      'title': 'Evento 2',
      'interestedCount': 120,
      'date': '15/01/2025',
      'description': 'Descrição para o evento 2. Inclua detalhes relevantes.',
      'location': 'Curitiba, PR',
      'price': '100 R\$',
    },
    {
      // Sem imagem para testar o fallback
      'imageUrl': null,
      'title': 'Evento 3',
      'interestedCount': 56,
      'date': '10/11/2024',
      'description': 'Descrição do evento 3. Local pequeno e aconchegante.',
      'location': 'Ponta Grossa, PR',
      'price': '50 R\$',
    },
  ];

  void onTabChanged(int index) {
    setState(() {
      activeTab = index;
    });
    print('Tab $index selecionada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente
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
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Center(
                    child: Text(
                      'Eventos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Barra de Pesquisa
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Container(
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Procurar Evento',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12.sp,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 10.h),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
                // Corpo
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: GridView.builder(
                      itemCount: events.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 cards por linha
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h,
                        childAspectRatio: 0.90, // Ajuste para diminuir o tamanho geral
                      ),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return PromEventCard(
                          imageUrl: event['imageUrl'],
                          title: event['title']!,
                          interestedCount: event['interestedCount']!,
                          onOpen: () {
                            // Navegar para a EventDetailScreen
                            context.push(
                              '/promEventDetail',
                              extra: {
                                'imageUrl': event['imageUrl'] ?? '',
                                'title': event['title'],
                                'interestedCount': event['interestedCount'],
                                'date': event['date'],
                                'description': event['description'],
                                'location': event['location'],
                                'price': event['price'],
                              },
                            );
                          },
                          onRemove: () => print('Removendo evento'),
                        );
                      },
                    ),
                  ),
                ),
                // Rodapé
                PromoterFooter(
                  activeTab: activeTab,
                  onTabChanged: (index) {
                    setState(() {
                      activeTab = index;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
