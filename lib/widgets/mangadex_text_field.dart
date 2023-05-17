// Dart imports:
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';

class MangadexReactiveFormField<T> extends StatelessWidget {
  final String? formControlName;
  final FormControl<T>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ControlValueAccessor<T, String>? valueAccessor;
  final ShowErrorsFunction<T>? showErrors;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final bool obscureText;
  final String obscuringCharacter;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final MouseCursor? mouseCursor;
  final DragStartBehavior dragStartBehavior;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final String? restorationId;
  final ScrollController? scrollController;
  final TextSelectionControls? selectionControls;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final TextEditingController? controller;
  final Clip clipBehavior;
  final bool enableIMEPersonalizedLearning;
  final bool scribbleEnabled;
  final ReactiveFormFieldCallback<T>? onTap;
  final ReactiveFormFieldCallback<T>? onEditingComplete;
  final ReactiveFormFieldCallback<T>? onSubmitted;
  final ReactiveFormFieldCallback<T>? onChanged;

  const MangadexReactiveFormField({
    super.key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.valueAccessor,
    this.showErrors,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.maxLengthEnforcement,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.mouseCursor,
    this.onAppPrivateCommand,
    this.restorationId,
    this.scrollController,
    this.selectionControls,
    this.controller,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.expands = false,
    this.cursorWidth = 2.0,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.clipBehavior = Clip.hardEdge,
    this.enableIMEPersonalizedLearning = true,
    this.scribbleEnabled = true,
    this.decoration = const InputDecoration(),
    this.obscuringCharacter = '•',
  });

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context)! as FormGroup;
    final control = formControl ?? form.controls[formControlName]! as FormControl<T>;
    String? errorText;

    if (control.hasErrors) {
      final errorKey = control.errors.keys.first;

      if (validationMessages != null && validationMessages!.containsKey(errorKey)) {
        errorText = validationMessages![errorKey]!(errorKey);
      } else {
        final formConfig = ReactiveFormConfig.of(context);
        final messageFunction = formConfig?.validationMessages[errorKey];
        if (messageFunction != null) {
          errorText = messageFunction(errorKey);
        }

        errorText = errorKey;
      }
    }
    decoration.applyDefaults(context.theme.inputDecorationTheme);

    return DividerTheme(
      data: context.theme.dividerTheme.copyWith(
        space: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (decoration.label != null) ...{
            decoration.label!,
            const Divider(),
          },
          if (decoration.labelText != null) ...{
            Text(decoration.labelText!, style: decoration.labelStyle ?? context.theme.inputDecorationTheme.labelStyle),
            const Divider(),
          },
          ReactiveTextField(
            formControlName: formControlName,
            formControl: formControl,
            validationMessages: validationMessages,
            valueAccessor: valueAccessor,
            showErrors: showErrors,
            focusNode: focusNode,
            decoration: decoration.copyWith(
                labelText: decoration.labelText != null ? '' : null,
                label: decoration.label != null ? const SizedBox() : null,
                errorStyle: const TextStyle(fontSize: 0)),
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            style: style,
            strutStyle: strutStyle,
            textDirection: textDirection,
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            autofocus: autofocus,
            readOnly: readOnly,
            showCursor: showCursor,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            autocorrect: autocorrect,
            smartDashesType: smartDashesType,
            smartQuotesType: smartQuotesType,
            enableSuggestions: enableSuggestions,
            maxLengthEnforcement: maxLengthEnforcement,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            cursorWidth: cursorWidth,
            cursorHeight: cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            buildCounter: buildCounter,
            scrollPhysics: scrollPhysics,
            autofillHints: autofillHints,
            mouseCursor: mouseCursor,
            dragStartBehavior: dragStartBehavior,
            onAppPrivateCommand: onAppPrivateCommand,
            restorationId: restorationId,
            scrollController: scrollController,
            selectionControls: selectionControls,
            selectionHeightStyle: selectionHeightStyle,
            selectionWidthStyle: selectionWidthStyle,
            controller: controller,
            clipBehavior: clipBehavior,
            enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            scribbleEnabled: scribbleEnabled,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
          ),
          StreamBuilder(
            stream: control.touchChanges,
            builder: (context, _) {
              if (_showErrors(control)) {
                return Text(errorText!, style: decoration.errorStyle ?? context.theme.inputDecorationTheme.errorStyle);
              }

              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  bool _showErrors(FormControl<T> control) {
    if (showErrors != null) {
      return showErrors!(control);
    }

    return control.invalid && control.touched;
  }
}
