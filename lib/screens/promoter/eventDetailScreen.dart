import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/components/promFooter.dart';
import 'package:go_router/go_router.dart';

class EventDetailScreen extends StatelessWidget {
  final int activeTab;
  final String imageUrl;
  final String title;
  final int interestedCount;
  final String date;
  final String description;
  final String location;
  final String price;

  const EventDetailScreen({
    Key? key,
    required this.activeTab,
    required this.imageUrl,
    required this.title,
    required this.interestedCount,
    required this.date,
    required this.description,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cria o mapa do evento
    final Map<String, dynamic> event = {
      'imageUrl': imageUrl,
      'title': title,
      'interestedCount': interestedCount,
      'date': date,
      'description': description,
      'location': location,
      'price': price,
    };

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
                // Corpo do Card Expandido
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withOpacity(0.5), // Filtro branco 50%
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagem com Hero Animation
                          Hero(
                            tag: imageUrl,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                imageUrl,
                                height: 150.h, // Altura ajustada
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150.h, // Altura ajustada
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 50.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h), // Reduzido o espaçamento
                          // Título
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF6B09B5),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Navegar para editar evento
                                  context.push('/editEvent', extra: event);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20.sp,
                                  color: const Color(0xFF6B09B5),
                                ),
                              ),
                            ],
                          ),
                          // Interessados
                          Text(
                            '$interestedCount interessados',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 78, 77, 77),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // Data
                          Text(
                            'Data:',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6B09B5),
                            ),
                          ),
                          Text(
                            date,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                          SizedBox(height: 12.h),
                          // Descrição
                          Text(
                            'Descrição:',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6B09B5),
                            ),
                          ),
                          Text(
                            description,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                          SizedBox(height: 16.h),
                          // Local
                          Text(
                            'Local:',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6B09B5),
                            ),
                          ),
                          Text(
                            location,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                          SizedBox(height: 12.h),
                          // Preço
                          Text(
                            'Valor Ingresso:',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6B09B5),
                            ),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Rodapé com abas
                PromoterFooter(
                  activeTab: activeTab,
                  onTabChanged: (index) {
                    if (activeTab != index) {
                      switch (index) {
                        case 0:
                          context.go('/promHome');
                          break;
                        case 1:
                          context.go('/createEvent');
                          break;
                        case 2:
                          context.go('/promProfile');
                          break;
                      }
                    }
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
