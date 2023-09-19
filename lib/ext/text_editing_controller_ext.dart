import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  void setText(String newText) {
    text = newText;
    selection = TextSelection.collapsed(offset: newText.length);
  }

  ///删除最后一个字符
  void deleteLastChar() {
    final String content = text;
    if (content.isNotEmpty) {
      text = content.substring(0, content.length - 1);
      selection = TextSelection.collapsed(offset: text.length);
    }
  }

  ///删除光标最后一个字符
  void deleteSelectionLastChar() {
    final String content = text;
    if (content.isNotEmpty) {
      final int selectionPosition = selection.baseOffset;
      if (selectionPosition == text.length) {
        deleteLastChar();
        return;
      }
      if (selectionPosition > 0 && selectionPosition <= text.length - 1) {
        final firstText = content.substring(0, selectionPosition - 1);
        final lastText = content.substring(selectionPosition, text.length);
        text = firstText + lastText;
        selection = TextSelection.collapsed(offset: selectionPosition - 1);
      }
    }
  }

  ///添加回车字符
  void addEnter() {
    text = '$text\n';
    selection = TextSelection.collapsed(offset: text.length);
  }

  ///光标后回车
  void addSelectionEnter({bool mustAdd = false}) {
    final String content = text;
    if (content.isNotEmpty || mustAdd) {
      final int selectionPosition = selection.baseOffset;
      if (selectionPosition == text.length) {
        addEnter();
        return;
      }
      if (selectionPosition >= 0 && selectionPosition <= text.length - 1) {
        final firstText = content.substring(0, selectionPosition);
        final lastText = content.substring(selectionPosition, text.length);
        text = '$firstText\n$lastText';
        selection = TextSelection.collapsed(offset: selectionPosition + 1);
      }
    }
  }

  void insertText(String text) {
    final TextEditingValue value = this.value;
    final int start = value.selection.baseOffset;
    int end = value.selection.extentOffset;
    if (value.selection.isValid && value.text.isNotEmpty) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }
      this.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
    } else {
      newValue(text);
    }
  }

  newValue(String text){
    value = TextEditingValue(
        text: text,
        selection:
        TextSelection.fromPosition(TextPosition(offset: text.length)));
  }

  removeLastText(){
    final TextEditingValue value = this.value;
    final int start = value.selection.baseOffset;
    int end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end-1);
        }
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.substring(end, value.text.length-1);
        end = start;
      }

      this.value = value.copyWith(
          text: newText,
          selection: TextSelection.fromPosition(TextPosition(offset: start - 1)));
    } else {
      newValue(text);
    }
  }


}
