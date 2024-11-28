import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/utils/validators.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final String? dateTime; // Agora inclui data e hora
  final String? description;
  final String? location;
  final String? price;
  final VoidCallback onSave;
  final VoidCallback onImageChange;

  const EventForm({
    Key? key,
    this.imageUrl,
    this.title,
    this.dateTime,
    this.description,
    this.location,
    this.price,
    required this.onSave,
    required this.onImageChange,
  }) : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController dateTimeController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    dateTimeController = TextEditingController(text: widget.dateTime);
    descriptionController = TextEditingController(text: widget.description);
    locationController = TextEditingController(text: widget.location);
    priceController = TextEditingController(text: widget.price);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateTimeController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do Evento
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? Image.network(
                        widget.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
              ),
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: ElevatedButton.icon(
                  onPressed: widget.onImageChange,
                  icon: const Icon(Icons.camera_alt, size: 16),
                  label: Text(
                    'Alterar Imagem',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B09B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Campos de Texto
          _buildTextField('Nome do Evento', titleController, 'Nome do Evento'),
          _buildDateTimePickerField(context), // Campo atualizado
          _buildDescriptionField(),
          _buildTextField('Local', locationController, 'Local'),
          _buildTextField('Valor do Ingresso', priceController, 'Valor do Ingresso'),
          SizedBox(height: 16.h),
          // Botão de Salvar
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSave();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B09B5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              icon: const Icon(Icons.save, color: Colors.white, size: 16),
              label: Text(
                'Salvar',
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String fieldName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: controller,
            validator: (value) => Validators.validateRequired(value, fieldName),
            decoration: InputDecoration(
              hintText: 'Digite $label',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimePickerField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data e Hora do Evento',
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: dateTimeController,
            validator: (value) => Validators.validateRequired(value, 'Data e Hora do Evento'),
            readOnly: true, // Impede digitação manual
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                locale: const Locale('pt', 'BR'),
              );

              if (pickedDate != null) {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  final dateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  String formattedDateTime =
                      DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

                  setState(() {
                    dateTimeController.text = formattedDateTime;
                  });
                }
              }
            },
            decoration: InputDecoration(
              hintText: 'Selecione a data e hora do evento',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
              suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF6B09B5)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descrição',
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: descriptionController,
            validator: (value) => Validators.validateRequired(value, 'Descrição'),
            maxLines: null,
            minLines: 4,
            decoration: InputDecoration(
              hintText: 'Digite a descrição do evento',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1000), // Limite de caracteres
            ],
          ),
        ],
      ),
    );
  }
}
