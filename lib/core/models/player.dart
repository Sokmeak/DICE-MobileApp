class Player {
  String nickname;
  int score;
  int answerStreak;
  String avatarUrl; // To store image URL for the avatar

  Player({
    required this.nickname,
    this.score = 0,
    this.answerStreak = 0,
    this.avatarUrl = 'https://placekitten.com/200/200', // Default placeholder
  });
}
