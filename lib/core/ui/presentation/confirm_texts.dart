/// What a question says, already translated by the screen: the question,
/// the note under it, and its two answers (06-ui/pause-menu/pause-menu.md
/// §3, `quit`).
final class ConfirmTexts {
  const ConfirmTexts({
    required this.ask,
    required this.note,
    required this.yes,
    required this.no,
  }) : assert(ask.length > 0, 'a question asks something'),
       assert(yes.length > 0 && no.length > 0, 'each answer says something');

  final String ask;
  final String note;
  final String yes;
  final String no;

  @override
  bool operator ==(Object other) =>
      other is ConfirmTexts &&
      other.ask == ask &&
      other.note == note &&
      other.yes == yes &&
      other.no == no;

  @override
  int get hashCode => Object.hash(ask, note, yes, no);
}
