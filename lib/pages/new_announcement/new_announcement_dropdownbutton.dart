import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';

class NewAnnouncementDropdownButton extends StatefulWidget {
  final AnnouncementsModel newAnnouncementModel;
  const NewAnnouncementDropdownButton({
    required this.newAnnouncementModel,
    Key? key,
  }) : super(key: key);

  @override
  State<NewAnnouncementDropdownButton> createState() =>
      _NewAnnouncementDropdownButtonState();
}

class _NewAnnouncementDropdownButtonState
    extends State<NewAnnouncementDropdownButton> {
  String? _selectedState;
  String? _selecteTypeAnnouncement;
  final List<String> _typesOfAnnouncements = [
    'Automóvel',
    'Imóvel',
    'Eletrônico',
    'Celular',
    'Bicicleta',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedState,
            hint: const Text('Estado'),
            validator: (value) {
              if (value == null) {
                return 'Selecione um estado!';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedState = value!;
              });
              widget.newAnnouncementModel.state = value;
            },
            items: Estados.listaEstadosSigla
                .map(
                  (estados) => DropdownMenuItem(
                    value: estados,
                    child: Text(estados),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selecteTypeAnnouncement,
            validator: (value) {
              if (value == null) {
                return 'Selecione um tipo!';
              }
              return null;
            },
            hint: const Text('Tipo de anúncio'),
            onChanged: (value) {
              setState(() {
                _selecteTypeAnnouncement = value!;
              });
              widget.newAnnouncementModel.type = value;
            },
            items: _typesOfAnnouncements
                .map(
                  (selectedAnnouncement) => DropdownMenuItem(
                    value: selectedAnnouncement,
                    child: Text(selectedAnnouncement),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
