import 'package:flutter/material.dart';
import 'package:path/path.dart';

//string_ext名称有问题，不知道为啥 索引不出来 改为string1_ext
extension StringNullExt on String? {
  String get nullSafe => this ?? '';

  bool isNotEmpty() => this != null && this!.isNotEmpty;

  bool get isGIF => this?.endsWith('.gif') ?? false;
}

extension StringExt on String {
  //匹配中括号的内容
  static final RegExp _regex = RegExp(r'\[([^\[\]]*)\]');
  static final RegExp _characterRegex = RegExp(r'[a-zA-Z]');

  //计算文本占用宽高
  double paintWidthWithTextStyle(TextStyle style, {double? maxWidth}) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: this, style: style), maxLines: 1, textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: maxWidth ?? double.infinity);
    return textPainter.size.width;
  }

  double paintHeightWithTextStyle(TextStyle style, {required double maxWidth}) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: this, style: style), textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size.height;
  }

  //根据keyword创建富文本,这里实现忽略大小写
  RichText? formatRichTextWithWord(
    String keyWord,
    List<TextStyle> styles, {
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    if (keyWord.trim().isEmpty || isEmpty) {
      return null;
    }
    debugPrint('formatRichTextWithWord$styles');
    return formatColorRichText(styles, regex: RegExp(keyWord, caseSensitive: false));
  }

  //第一个颜色为文本的默认颜色,其它颜色为为格式化的富文本的颜色,匹配中括号内的东西,中括号内的作为富文本不同颜色的部分,
  // 正则匹配中括号的东西,传入的TextStyle列表,给对应中括号内容,设置不同颜色锋哥
  RichText formatColorRichText(List<TextStyle> styles,
      {TextAlign textAlign = TextAlign.left, TextOverflow overflow = TextOverflow.visible, RegExp? regex}) {
    var content = this;
    final spans = List<TextSpan>.empty(growable: true);
    final matchers = (regex ?? _regex).allMatches(this);
    //第二个开始才是真正需要格式化的颜色
    int count = 1;
    TextStyle? style;
    for (final Match m in matchers) {
      if (count < styles.length) {
        style = styles[count];
      }
      final regexText = m.group(0) ?? '';
      final index = content.indexOf(regexText);
      //匹配出来的普通文本
      spans.add(TextSpan(text: content.substring(0, index)));
      content = content.substring(index, content.length);
      //切割余下的文本,去掉中括号,留下文本内容
      spans.add(TextSpan(text: regex == null ? regexText.substring(1, regexText.length - 1) : regexText, style: style));
      content = content.substring(regexText.length, content.length);
      count++;
    }
    //剩余最后的内容
    spans.add(TextSpan(text: content));
    return RichText(
      textAlign: textAlign,
      overflow: overflow,
      text: TextSpan(
        text: '',
        style: styles.isNotEmpty ? styles[0] : null,
        children: spans,
      ),
    );
  }

  Size paintTextSize(TextStyle style, {double maxWidth = double.infinity}) {
    final textPainter =
        TextPainter(text: TextSpan(text: this, style: style), maxLines: 1, textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  Color toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
    return Colors.white;
  }

  String get suffix => lastIndexOf('.') != -1 ? substring(lastIndexOf('.'), length).replaceAll('.', '') : '';

  String get filename => basename(this);

  ///插入空白符号防止被text自动换行
  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }
}
