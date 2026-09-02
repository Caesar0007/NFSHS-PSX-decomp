OLD = 'return_mask:\n      if ((result & key) != 0) {\n        return 1;\n      }\n      __asm__("" : : "i"(0));\n      return 0;'
VARIANTS = [
  ('J1 goto shared', OLD, 'return_mask:\n      if ((result & key) != 0) {\n        goto return_one;\n      }\n      return 0;'),
  ('J2 inverted early-return', OLD, 'return_mask:\n      if ((result & key) == 0) {\n        return 0;\n      }\n      goto return_one;'),
  ('J3 inverted, return 1', OLD, 'return_mask:\n      if ((result & key) == 0) {\n        return 0;\n      }\n      return 1;'),
  ('J4 goto zero label', OLD, 'return_mask:\n      if ((result & key) != 0) {\n        goto return_one;\n      }\n      goto return_zero;\nreturn_zero:\n      return 0;'),
  ('J5 result masked local', OLD, 'return_mask:\n      result = result & key;\n      if (result != 0) {\n        goto return_one;\n      }\n      return 0;'),
]
