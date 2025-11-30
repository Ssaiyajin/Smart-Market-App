import 'package:flutter/material.dart';
import 'package:smarket_app/widgets/mandatory_label.dart';

class SelectField<T> extends StatefulWidget {
  final bool mandatory;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  T value;

  SelectField(
      {Key? key,
      required this.value,
      required this.labelText,
      this.mandatory = false,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T> extends State<SelectField> {
  get label {
    return widget.mandatory
        ? MandatoryLabel(labelText: widget.labelText)
        : Text(widget.labelText);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            errorStyle:
                const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            label: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: widget.value == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              itemHeight: null,
              isExpanded: true,
              value: widget.value,
              isDense: true,
              onChanged: widget.onChanged,
              items: widget.items as List<DropdownMenuItem<T>>,
            ),
          ),
        );
      },
    );
  }
}
