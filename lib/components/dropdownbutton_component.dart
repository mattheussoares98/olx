import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';

class DropdownButtonComponent extends StatefulWidget {
  final AnnouncementsModel announcementsModel;
  final bool isForm;
  const DropdownButtonComponent({
    required this.announcementsModel,
    this.isForm = true,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonComponent> createState() =>
      _DropdownButtonStateComponent();
}

class _DropdownButtonStateComponent extends State<DropdownButtonComponent> {
  String? _selectedState;
  String? _selecteTypeAnnouncement;
  final List<String> _typesOfAnnouncements = [
    //o ideal é deixar essa lista salva no banco de dados, pois se precisar adicionar algum tipo fica mais fácil. Não vai precisar gerar uma nova versão
    'Tipo de anúncio',
    'Automóvel',
    'Imóvel',
    'Eletrônico',
    'Celular',
    'Bicicleta',
    'Outros',
  ];

  List<String> states = [];
  getStates() {
    states.clear();
    states.add('Estado');
    for (var state in Estados.listaEstadosSigla) {
      states.add(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    getStates();

    if (widget.isForm) {
      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedState,
              hint: Text(
                'Estado',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
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
                widget.announcementsModel.state = value;
              },
              items: states
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
              hint: Text(
                'Tipo de anúncio',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selecteTypeAnnouncement = value!;
                });
                widget.announcementsModel.type = value;
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
          )
        ],
      );
    } else {
      return DropdownButtonHideUnderline(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton<String>(
              iconEnabledColor: Theme.of(context).colorScheme.primary,
              items: states
                  .map(
                    (estados) => DropdownMenuItem<String>(
                      value: estados,
                      child: Text(
                        estados,
                        style: estados == 'Estado'
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                      ),
                    ),
                  )
                  .toList(),
              value: _selectedState,
              hint: Text(
                'Estado',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
                widget.announcementsModel.state = value;
              },
            ),
            const SizedBox(width: 20),
            DropdownButton<String>(
              iconEnabledColor: Theme.of(context).colorScheme.primary,
              value: _selecteTypeAnnouncement,
              hint: Text(
                'Tipo de anúncio',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selecteTypeAnnouncement = value!;
                });
                widget.announcementsModel.type = value;
              },
              items: _typesOfAnnouncements
                  .map(
                    (selectedAnnouncement) => DropdownMenuItem(
                      value: selectedAnnouncement,
                      child: Text(
                        selectedAnnouncement,
                        style: selectedAnnouncement == 'Tipo de anúncio'
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }
  }
}
