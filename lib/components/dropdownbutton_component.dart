import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:provider/provider.dart';

class DropdownButtonComponent extends StatefulWidget {
  final AnnouncementsModel announcementsModel;
  final bool isForm;
  final List<AnnouncementsModel>? announcementsList;
  const DropdownButtonComponent({
    required this.announcementsModel,
    this.isForm = true,
    this.announcementsList,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonComponent> createState() =>
      _DropdownButtonStateComponent();
}

class _DropdownButtonStateComponent extends State<DropdownButtonComponent> {
  String? _selectedState;
  String? _selecteTypeAnnouncement;

  @override
  Widget build(BuildContext context) {
    AnnouncementsProvider announcementsProvider =
        Provider.of(context, listen: true);

    if (widget.isForm) {
      announcementsProvider.states
          .removeWhere((element) => element == 'Estado');
      announcementsProvider.typesOfAnnouncements
          .removeWhere((element) => element == 'Tipo de anúncio');

      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<dynamic>(
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
              items: announcementsProvider.states
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
            child: DropdownButtonFormField<dynamic>(
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
              items: announcementsProvider.typesOfAnnouncements
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
            DropdownButton<dynamic>(
              iconEnabledColor: Theme.of(context).colorScheme.primary,
              items: announcementsProvider.states
                  .map(
                    (estados) => DropdownMenuItem<dynamic>(
                      value: estados,
                      child: Text(
                        estados.toString(),
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
              onChanged: (stateSelected) {
                announcementsProvider.filterStates(stateSelected);
                setState(() {
                  _selectedState = stateSelected;
                });
                widget.announcementsModel.state = stateSelected;
              },
            ),
            const SizedBox(width: 20),
            DropdownButton<dynamic>(
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
              items: announcementsProvider.typesOfAnnouncements
                  .map(
                    (selectedAnnouncement) => DropdownMenuItem(
                      value: selectedAnnouncement,
                      child: Text(
                        selectedAnnouncement.toString(),
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
