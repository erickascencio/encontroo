import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/components/userMainLayout.dart';
import 'package:go_router/go_router.dart';

class UserEventDetailScreen extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final String organizer;
  final String date;
  final String location;
  final String description;
  final String price;

  const UserEventDetailScreen({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.organizer,
    required this.date,
    required this.location,
    required this.description,
    required this.price,
  });

  void _showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                "Presença Confirmada",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o popup
                context.go('/userEvents'); // Redirecionar para a página de eventos
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7825),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return UserMainLayout(
      activeTab: 0, // Define a aba ativa no footer
      title: 'Eventos', // Título padrão
      customAppBar: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                'Detalhes do Evento',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Espaço branco com título, organizador e menu
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: imageUrls.isNotEmpty
                                        ? NetworkImage(imageUrls[0])
                                        : null,
                                    radius: 20.r,
                                    backgroundColor: Colors.grey[200],
                                    child: imageUrls.isEmpty
                                        ? const Icon(Icons.image,
                                            color: Colors.grey)
                                        : null,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        organizer,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  print('Menu clicado');
                                },
                                icon: const Icon(Icons.more_vert),
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ),
                        // Carrossel de imagens
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15.r)),
                          child: SizedBox(
                            height: 180.h,
                            child: imageUrls.isNotEmpty
                                ? PageView.builder(
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        imageUrls[index],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image,
                                                size: 50, color: Colors.grey),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image,
                                        size: 50, color: Colors.grey),
                                  ),
                          ),
                        ),
                        // Conteúdo do card expandido
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Data e local
                              Text(
                                '$date • $location',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              // Descrição
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Preço
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Preço:',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    price,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF6B09B5),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              // Botão "Confirmar Presença"
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      _showConfirmationPopup(context),
                                  icon: const Icon(Icons.event_available),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF7825),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 10.h),
                                  ),
                                  label: Text(
                                    'Confirmar Presença',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
