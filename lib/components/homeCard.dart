import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  final List<String> imageUrls; // Lista de URLs das imagens
  final String title;
  final String organizer;
  final String date;
  final String location;
  final String description;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.organizer,
    required this.date,
    required this.location,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      color: Colors.white.withOpacity(0.7), // Ajuste na opacidade do card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Espaço branco acima da imagem
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageUrls.isNotEmpty
                          ? NetworkImage(imageUrls[0])
                          : null, // Fallback para imagem vazia
                      radius: 20.r,
                      backgroundColor: Colors.grey[200],
                      child: imageUrls.isEmpty
                          ? const Icon(Icons.image, color: Colors.grey)
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
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
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50, color: Colors.grey),
                            );
                          },
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),
          ),
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
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8.h),
                // Botão "Veja Mais"
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B09B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r), // Botão mais arredondado
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Veja Mais',
                      style: TextStyle(
                        fontSize: 12.sp,
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
    );
  }
}
