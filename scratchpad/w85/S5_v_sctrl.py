OLD = '    __asm__("" : : "r"(config));\n    one = 1;\n    __asm__("" : "=r"(one) : "0"(one));\n    frontEnd.rampGas[i] = (char)one;\n    frontEnd.rampBrake[i] = (char)one;\n    frontEnd.rampSteer[i] = (char)one;'
VARIANTS = [
  ('X1 literals', OLD, '    frontEnd.rampGas[i] = 1;\n    frontEnd.rampBrake[i] = 1;\n    frontEnd.rampSteer[i] = 1;'),
  ('X2 chained assign', OLD, '    frontEnd.rampSteer[i] = frontEnd.rampBrake[i] = frontEnd.rampGas[i] = 1;'),
  ('X3 keep config fence, literals', OLD, '    __asm__("" : : "r"(config));\n    frontEnd.rampGas[i] = 1;\n    frontEnd.rampBrake[i] = 1;\n    frontEnd.rampSteer[i] = 1;'),
  ('X4 one plain local', OLD, '    one = 1;\n    frontEnd.rampGas[i] = (char)one;\n    frontEnd.rampBrake[i] = (char)one;\n    frontEnd.rampSteer[i] = (char)one;'),
  ('X5 config fence + one plain', OLD, '    __asm__("" : : "r"(config));\n    one = 1;\n    frontEnd.rampGas[i] = (char)one;\n    frontEnd.rampBrake[i] = (char)one;\n    frontEnd.rampSteer[i] = (char)one;'),
]
