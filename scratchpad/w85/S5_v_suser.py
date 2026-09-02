OLD = '  fade = *(volatile int *)&this->callingMenu->fScreenFade;'
VARIANTS = [
  ('V1 plain int cast', OLD, '  fade = *(int *)&this->callingMenu->fScreenFade;'),
  ('V2 direct field', OLD, '  fade = this->callingMenu->fScreenFade;'),
  ('V3 int temp then short', OLD, '  {\n    int fadeWord = *(int *)&this->callingMenu->fScreenFade;\n    fade = (short)fadeWord;\n  }'),
  ('V4 long cast', OLD, '  fade = *(long *)&this->callingMenu->fScreenFade;'),
  ('V5 unsigned int cast', OLD, '  fade = (short)*(u_int *)&this->callingMenu->fScreenFade;'),
]
