import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromEventCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final int interestedCount;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  const PromEventCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.interestedCount,
    required this.onOpen,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 140.h, // Ajuste proporcional
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8.r), // Ajuste leve no arredondamento
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagem do Evento com fallback
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                    child: imageUrl != null && imageUrl!.startsWith('assets')
                        ? Image.asset(
                            imageUrl!,
                            height: 60.h, // Ajuste proporcional
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : imageUrl != null && imageUrl!.isNotEmpty
                            ? Image.network(
                                imageUrl!,
                                height: 70.h, // Ajuste proporcional
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _fallbackImage();
                                },
                              )
                            : _fallbackImage(),
                  ),
                  // Botão de três pontinhos
                  Positioned(
                    top: 0.4.h,
                    right: 0.4.w,
                    child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'remove') onRemove();
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'remove',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 12.sp),
                              SizedBox(width: 6.w),
                              const Text('Remover evento'),
                            ],
                          ),
                        ),
                      ],
                      icon: Icon(
                        Icons.more_vert,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Título do Evento
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6B09B5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                    // Número de Interessados
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.link, size: 13, color: Color(0xFF6B09B5)),
                        SizedBox(width: 4.w),
                        Text(
                          '$interestedCount Interessados',
                          style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.h),
                    // Botão de Abrir
                    SizedBox(
                      width: 70.w,
                      child: ElevatedButton(
                        onPressed: onOpen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B09B5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          padding: EdgeInsets.zero,
                          minimumSize: Size(double.infinity, 25.h),
                        ),
                        child: Text(
                          'Abrir',
                          style: TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      height: 50.h, // Ajuste proporcional
      width: double.infinity,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 16.sp,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
