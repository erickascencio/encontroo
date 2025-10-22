import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TinderCard extends StatefulWidget {
  final double height;
  final List<String> imageUrls;
  final String name;
  final String age;
  final String description;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onSuperLike;
  final VoidCallback onRewind;

  const TinderCard({
    Key? key,
    required this.height,
    required this.imageUrls,
    required this.name,
    required this.age,
    required this.description,
    required this.onLike,
    required this.onDislike,
    required this.onSuperLike,
    required this.onRewind,
  }) : super(key: key);

  @override
  _TinderCardState createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  bool isExpanded = false;
  int currentImageIndex = 0;
  final double dragThreshold = 300.0; // Configuração de sensibilidade (em pixels)

  void _goToNextImage() {
    if (currentImageIndex < widget.imageUrls.length - 1) {
      setState(() {
        currentImageIndex++;
      });
    }
  }

  void _goToPreviousImage() {
    if (currentImageIndex > 0) {
      setState(() {
        currentImageIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      axis: Axis.horizontal,
      onDragEnd: (details) {
        // Verifica o deslocamento horizontal e decide a ação
        if (details.offset.dx > dragThreshold) {
          widget.onLike(); // Like
        } else if (details.offset.dx < -dragThreshold) {
          widget.onDislike(); // Dislike
        } else {
          // Caso o movimento não alcance o limite, o card volta para o lugar
          setState(() {});
        }
      },
      feedback: Material(
        color: Colors.transparent,
        child: _buildCard(),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Container(
      width: 0.9.sw,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white.withValues(alpha: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 9,
            child: Stack(
              children: [
                GestureDetector(
                  onTapUp: (details) {
                    final width = MediaQuery.of(context).size.width;
                    if (details.localPosition.dx < width / 2) {
                      _goToPreviousImage();
                    } else {
                      _goToNextImage();
                    }
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                    child: Image.asset(
                      widget.imageUrls[currentImageIndex],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Nome, idade e descrição sobrepostos
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.name}, ${widget.age}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: isExpanded ? 100.h : 40.h,
                            ),
                            child: SingleChildScrollView(
                              physics: isExpanded
                                  ? const BouncingScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white70,
                                ),
                                maxLines: isExpanded ? null : 2,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Botões
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
                color: Colors.black.withValues(alpha: 0.2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconButton(Icons.replay, Colors.yellow, widget.onRewind),
                    _buildIconButton(Icons.close, Colors.red, widget.onDislike),
                    _buildIconButton(Icons.star, Colors.blue, widget.onSuperLike),
                    _buildIconButton(Icons.favorite, Colors.green, widget.onLike),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, size: 28.sp, color: color),
      onPressed: onPressed,
    );
  }
}
