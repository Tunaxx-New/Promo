import 'api_field_type.dart';

class ApiField {
  final String key;
  final String label;
  final ApiFieldType type;
  final bool required;
  final String? initialValue;
  final bool enabled;
  final int maxLines;
  final bool haveTitle;
  final String? hint;

  const ApiField({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.initialValue,
    this.enabled = true,
    this.maxLines = 1,
    this.haveTitle = false,
    this.hint,
  });

  const ApiField.text({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool enabled = true,
    int maxLines = 1,
    bool haveTitle = false,
    String? hint,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.text,
         initialValue: initialValue,
         required: required,
         enabled: enabled,
         maxLines: maxLines,
         haveTitle: haveTitle,
         hint: hint,
       );

  const ApiField.phone({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool enabled = true,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.phone,
         initialValue: initialValue,
         required: required,
         enabled: enabled,
         haveTitle: haveTitle,
       );

  const ApiField.password({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool enabled = true,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.password,
         initialValue: initialValue,
         required: required,
         enabled: enabled,
         haveTitle: haveTitle,
       );

  const ApiField.email({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool enabled = true,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.email,
         initialValue: initialValue,
         required: required,
         enabled: enabled,
         haveTitle: haveTitle,
       );

  const ApiField.code({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool enabled = true,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.code,
         initialValue: initialValue,
         required: required,
         enabled: enabled,
         haveTitle: haveTitle,
       );

  const ApiField.hidden({required String key, String? initialValue})
    : this(
        key: key,
        label: '',
        type: ApiFieldType.hidden,
        initialValue: initialValue,
        enabled: false,
      );

  const ApiField.number({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.number,
         initialValue: initialValue,
         required: required,
         haveTitle: haveTitle,
       );

  const ApiField.dateTime({
    required String key,
    required String label,
    String? initialValue,
    bool required = false,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.datetime,
         initialValue: initialValue,
         required: required,
         haveTitle: haveTitle,
       );

  const ApiField.checkbox({
    required String key,
    required String label,
    String? initialValue,
    bool haveTitle = false,
  }) : this(
         key: key,
         label: label,
         type: ApiFieldType.checkbox,
         initialValue: initialValue,
         required: false,
         haveTitle: haveTitle,
       );
}
