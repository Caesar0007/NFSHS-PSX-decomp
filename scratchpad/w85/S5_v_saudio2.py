OLD = '    fade = (short)fadeCalc;\n    __asm__("" : "+r"(fadeCalc));\n    do {\n      DrawShapeExtended(i + 0x30,1,0,0,(int)fade,0,\n                 (tDrawShapeExtended *)0x0);\n      i = i + 1;\n    } while (i < 4);'
VARIANTS = [
  ('L1 fade assigned in loop', OLD, '    do {\n      fade = (short)fadeCalc;\n      DrawShapeExtended(i + 0x30,1,0,0,(int)fade,0,\n                 (tDrawShapeExtended *)0x0);\n      i = i + 1;\n    } while (i < 4);'),
  ('L2 cast inline in call', OLD, '    fade = (short)fadeCalc;\n    do {\n      DrawShapeExtended(i + 0x30,1,0,0,(int)(short)fadeCalc,0,\n                 (tDrawShapeExtended *)0x0);\n      i = i + 1;\n    } while (i < 4);'),
  ('L3 both', OLD, '    do {\n      fade = (short)fadeCalc;\n      DrawShapeExtended(i + 0x30,1,0,0,(int)(short)fadeCalc,0,\n                 (tDrawShapeExtended *)0x0);\n      i = i + 1;\n    } while (i < 4);'),
]
