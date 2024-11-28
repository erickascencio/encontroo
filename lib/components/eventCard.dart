import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EventCard extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String date;
  final String location;
  final String description;
  final int interestedCount;
  final String price;
  final VoidCallback onTap;

  const EventCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.interestedCount,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded; // Alterna entre expandido e não expandido
          });
        },
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do evento
            if (widget.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                child: Image.asset(
                  widget.imageUrl!,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título do evento
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Data e localização
                  Text(
                    '${widget.date} • ${widget.location}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 8.h),
                  // Descrição (expansível)
                  Text(
                    widget.description,
                    maxLines: isExpanded ? null : 2, // Limita ou expande linhas
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  ),
                  if (isExpanded)
                    SizedBox(height: 16.h), // Espaço extra para botão
                  // Contador de interessados e preço
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.interestedCount} interessados',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      Text(
                        widget.price,
                        style: TextStyle(fontSize: 14.sp, color: Colors.orange),
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    SizedBox(height: 16.h),
                    // Botão "Ver Matches" (Reduzido em 40%)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navegar para a rota '/tinderFeed'
                          GoRouter.of(context).push('/tinderFeed');
                        },
                        icon: const Icon(Icons.people, size: 16),
                        label: Text(
                          'Ver Encontros',
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7825),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h), // Reduzido
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
