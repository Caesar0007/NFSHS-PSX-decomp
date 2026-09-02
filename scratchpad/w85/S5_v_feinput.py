VARIANTS = [
  ('I1 goto shared return_one (bool)', 'return_bool:\n      if (result) {\n        return 1;\n      }\n      __asm__("" : : "i"(0));\n      return 0;', 'return_bool:\n      if (result) {\n        goto return_one;\n      }\n      return 0;'),
  ('I2 goto shared return_one (mask)', 'return_mask:\n      if ((result & key) != 0) {\n        return 1;\n      }\n      __asm__("" : : "i"(0));\n      return 0;', 'return_mask:\n      if ((result & key) != 0) {\n        goto return_one;\n      }\n      return 0;'),
]
