OLD = '  fade = *(volatile int *)&this->callingMenu->fScreenFade;'
VARIANTS = [
  ('V6 plain field into int temp', OLD, '  {\n    int fadeWord = this->callingMenu->fScreenFade;\n    fade = (short)fadeWord;\n  }'),
  ('V7 int temp no braces', OLD, '  int fadeWord = this->callingMenu->fScreenFade;\n  fade = (short)fadeWord;'),
]
