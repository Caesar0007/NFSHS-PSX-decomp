OLD = '    int startTicksSnapshot = *(volatile int *)&ticks;\n    this->StartedTextFade = 1;\n    this->fTextFadeDir = -8;\n    this->fStartTicks = startTicksSnapshot;'
VARIANTS = [
  ('G1 natural, ticks last', OLD, '    this->StartedTextFade = 1;\n    this->fTextFadeDir = -8;\n    this->fStartTicks = ticks;'),
  ('G2 plain snapshot first', OLD, '    int startTicksSnapshot = ticks;\n    this->StartedTextFade = 1;\n    this->fTextFadeDir = -8;\n    this->fStartTicks = startTicksSnapshot;'),
  ('G3 ticks first store', OLD, '    this->fStartTicks = ticks;\n    this->StartedTextFade = 1;\n    this->fTextFadeDir = -8;'),
  ('G4 ticks mid', OLD, '    this->StartedTextFade = 1;\n    this->fStartTicks = ticks;\n    this->fTextFadeDir = -8;'),
  ('G5 plain snapshot after stores', OLD, '    this->StartedTextFade = 1;\n    this->fTextFadeDir = -8;\n    {\n      int startTicksSnapshot = ticks;\n      this->fStartTicks = startTicksSnapshot;\n    }'),
]
