import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/extensions/open_url.dart';
import 'package:promo/shared/formatters/kazakhstsan_phone_formatter.dart';
import 'package:promo/shared/formatters/max_line_formatter.dart';
import 'package:promo/shared/theme/build_prefix_icon.dart';
import 'package:promo/shared/widgets/api_form/api_client.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/api_field_type.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/loading/loading_overlay.dart';

class ApiForm extends StatefulWidget {
  final String title;
  final String submitTitle;
  final String? termsOfUseUrl;
  final String? privacyPolicyUrl;

  final String route;
  final HttpMethod method;

  final List<ApiField> fields;

  final Widget? header;
  final Widget? footer;

  final ValueChanged<Map<String, dynamic>>? onSuccess;
  final ValueChanged<Object>? onError;

  final ApiClient apiClient;

  const ApiForm({
    super.key,
    required this.title,
    required this.submitTitle,
    this.termsOfUseUrl,
    this.privacyPolicyUrl,
    required this.route,
    required this.method,
    required this.fields,
    this.header,
    this.footer,
    this.onSuccess,
    this.onError,
    required this.apiClient,
  });

  @override
  State<ApiForm> createState() => _ApiFormState();
}

class _ApiFormState extends State<ApiForm> {
  bool _loading = false;

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    for (final field in widget.fields) {
      _controllers[field.key] = TextEditingController(
        text: field.type == ApiFieldType.phone
            ? '+7'
            : (field.initialValue ?? ''),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);

    try {
      final body = <String, dynamic>{};

      for (final field in widget.fields) {
        var value = _controllers[field.key]!.text;

        switch (field.type) {
          case ApiFieldType.phone:
            body[field.key] = value.replaceAll(RegExp(r'\D'), '');
            break;

          case ApiFieldType.checkbox:
            body[field.key] = value.toLowerCase() == 'true';
            break;

          case ApiFieldType.number:
            final text = value.trim();
            body[field.key] = text.isEmpty ? null : num.parse(text);
            break;

          case ApiFieldType.datetime:
            body[field.key] = value.trim().isEmpty
                ? null
                : DateTime.parse(value).toUtc().toIso8601String();
            break;

          default:
            body[field.key] = value.trim().isEmpty ? '' : value;
            break;
        }
      }
      
      final json = await widget.apiClient.request(
        route: widget.route,
        method: widget.method,
        body: body,
      );

      widget.onSuccess?.call(json);
    } catch (e) {
      ErrorHandler.show(context, e);
      widget.onError?.call(e);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Widget _buildField(ApiField field) {
    if (field.type == ApiFieldType.hidden) {
      return const SizedBox.shrink();
    }

    Widget child;

    switch (field.type) {
      case ApiFieldType.checkbox:
        child = SwitchListTile(
          title: field.haveTitle ? null : Text(field.label),
          value: _controllers[field.key]!.text == 'true',
          onChanged: field.enabled
              ? (value) {
                  setState(() {
                    _controllers[field.key]!.text = value.toString();
                  });
                }
              : null,
        );
        break;

      case ApiFieldType.datetime:
        child = TextField(
          controller: _controllers[field.key],
          enabled: field.enabled,
          readOnly: true,
          decoration: InputDecoration(
            hintText: field.haveTitle ? null : field.label,
            filled: true,
            prefixIcon: buildPrefixIcon(Icons.calendar_month),
          ),
          onTap: () async {
            final current =
                DateTime.tryParse(_controllers[field.key]!.text) ??
                DateTime.now();

            final date = await showDatePicker(
              context: context,
              initialDate: current,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (date == null) return;

            final result = DateTime(
              date.year,
              date.month,
              date.day,
              current.hour,
              current.minute,
              current.second,
              current.millisecond,
              current.microsecond,
            );

            setState(() {
              _controllers[field.key]!.text = result.toIso8601String();
            });
          },
        );
        break;

      default:
        child = TextField(
          controller: _controllers[field.key],
          enabled: field.enabled,
          maxLines: field.maxLines,
          obscureText: field.type == ApiFieldType.password,
          keyboardType: field.maxLines > 1
              ? TextInputType.multiline
              : switch (field.type) {
                  ApiFieldType.phone => TextInputType.phone,
                  ApiFieldType.number => TextInputType.number,
                  ApiFieldType.email => TextInputType.emailAddress,
                  _ => TextInputType.text,
                },
          textInputAction: field.maxLines > 1
              ? TextInputAction.newline
              : TextInputAction.done,
          inputFormatters: switch (field.type) {
            ApiFieldType.phone => [KazakhstanPhoneFormatter()],
            _ => [MaxLinesFormatter(field.maxLines)],
          },
          decoration: InputDecoration(
            hintText: field.haveTitle ? null : field.label,
            filled: true,
            prefixIcon: buildPrefixIcon(switch (field.type) {
              ApiFieldType.phone => Icons.phone_in_talk,
              ApiFieldType.password => Icons.lock,
              ApiFieldType.email => Icons.email,
              ApiFieldType.code => Icons.numbers,
              ApiFieldType.number => Icons.pin,
              _ => Icons.text_fields,
            }),
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (field.haveTitle) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: field.label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        if (field.required)
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (field.hint != null) ...[
                    const SizedBox(width: 6),
                    Tooltip(
                      message: field.hint!,
                      child: Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LoadingOverlay(
        loading: _loading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...widget.fields.map(_buildField),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.submitTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    if (widget.termsOfUseUrl != null ||
                        widget.privacyPolicyUrl != null)
                      Text(
                        context.l10n.authorizationAgreementPrefix(
                          widget.submitTitle,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                    if (widget.termsOfUseUrl != null ||
                        widget.privacyPolicyUrl != null)
                      Text(" "),
                    if (widget.termsOfUseUrl != null)
                      GestureDetector(
                        onTap: () => openUrl(widget.termsOfUseUrl),
                        child: Text(
                          context.l10n.termOfUse,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),

                    if (widget.termsOfUseUrl != null &&
                        widget.privacyPolicyUrl != null)
                      Text(
                        ' ${context.l10n.and} ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                    if (widget.privacyPolicyUrl != null)
                      GestureDetector(
                        onTap: () => openUrl(widget.privacyPolicyUrl),
                        child: Text(
                          context.l10n.privacyPolicy,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),

                    if (widget.termsOfUseUrl != null ||
                        widget.privacyPolicyUrl != null)
                      Text('.', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
