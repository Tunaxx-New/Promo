String formatTime(int value) {
    final minutes = value ~/ 60;
    final seconds = value % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }