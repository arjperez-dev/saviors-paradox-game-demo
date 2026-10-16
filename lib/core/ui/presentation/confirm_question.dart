import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/ui/presentation/button_content.dart';
import 'package:saviors_paradox/core/ui/presentation/button_shape.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_answer.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_texts.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_look.dart';
import 'package:saviors_paradox/core/ui/presentation/frame_style.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_frame.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_lettering.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/label_placement.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

/// The question before spending or losing something: a framed box with the
/// question, a note, and two answers, the focus on the one the screen
/// gives, the safe one when it opens (06-ui/ui.md §3;
/// 06-ui/pause-menu/pause-menu.md §3, `quit`; the 06-ui sandbox's
/// `ttConfirm`). The screen places it and draws the wash behind it.
final class ConfirmQuestion extends StatelessWidget {
  const ConfirmQuestion({
    required this.texts,
    required this.focused,
    required this.onAnswer,
    required this.seed,
    super.key,
  });

  final ConfirmTexts texts;
  final ConfirmAnswer focused;
  final ValueChanged<ConfirmAnswer> onAnswer;
  final Seed seed;

  // pause-menu.md §3: box 800 × 290; buttons (640, 572) and (980, 572),
  // 300 × 64, from the box at (560, 380); ttConfirm: the question at
  // y 452, the note at y 506.
  static const UiVec2 size = UiVec2(Vec2(800, 290));
  static const ButtonShape answerShape = ButtonShape(
    height: 64,
    width: 300,
    placement: LabelPlacement.centre,
  );
  static const double askY = 72;
  static const double noteY = 126;
  static const double answersTop = 192;
  static const double yesLeft = 80;
  static const double noLeft = 420;

  @override
  Widget build(BuildContext context) => InkFrame(
    size: size,
    style: FrameStyle(seed: seed, look: FrameLook.question, focused: true),
    child: Stack(
      children: [
        _Line(text: texts.ask, y: askY, role: InkLettering.question),
        _Line(text: texts.note, y: noteY, role: InkLettering.questionNote),
        _Answer(question: this, answer: ConfirmAnswer.yes),
        _Answer(question: this, answer: ConfirmAnswer.no),
      ],
    ),
  );
}

/// One line of the question, centred across the box on [y].
final class _Line extends StatelessWidget {
  const _Line({required this.text, required this.y, required this.role});

  final String text;
  final double y;
  final InkLettering role;

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    return Positioned(
      left: 0,
      right: 0,
      top: theme.pixels(y - role.size),
      height: theme.pixels(2 * role.size),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          softWrap: false,
          style: theme.lettering(role),
        ),
      ),
    );
  }
}

/// One answer's button, at its place in the box; its seed the box's + 10
/// for yes, + 20 for no (the sandbox's `ttConfirm`).
final class _Answer extends StatelessWidget {
  const _Answer({required this.question, required this.answer});

  final ConfirmQuestion question;
  final ConfirmAnswer answer;

  @override
  Widget build(BuildContext context) {
    final theme = InkTheme.of(context);
    return Positioned(
      left: theme.pixels(_left),
      top: theme.pixels(ConfirmQuestion.answersTop),
      child: MenuButton(
        content: ButtonContent(label: _label),
        shape: ConfirmQuestion.answerShape,
        state: ButtonState(seed: _seed, focused: question.focused == answer),
        onPressed: () => question.onAnswer(answer),
      ),
    );
  }

  double get _left => switch (answer) {
    ConfirmAnswer.yes => ConfirmQuestion.yesLeft,
    ConfirmAnswer.no => ConfirmQuestion.noLeft,
  };

  String get _label => switch (answer) {
    ConfirmAnswer.yes => question.texts.yes,
    ConfirmAnswer.no => question.texts.no,
  };

  Seed get _seed => Seed(
    question.seed.value +
        switch (answer) {
          ConfirmAnswer.yes => 10,
          ConfirmAnswer.no => 20,
        },
  );
}
