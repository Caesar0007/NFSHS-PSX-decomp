VARIANTS = [
  ('F1 re-read after tag10 block', '      do {\n        p = p + 1;\n      } while (*p == tag);\n      tag = *(volatile byte *)p;\n    }\n    if (tag == 9) {', '      do {\n        p = p + 1;\n      } while (*p == tag);\n    }\n    tag = *p;\n    if (tag == 9) {'),
  ('F2 re-read after tag2a block', '      do {\n        p = p + 1;\n      } while (*p == tag);\n      tag = *(volatile byte *)p;\n    }\n    if (tag == 0x5e) {', '      do {\n        p = p + 1;\n      } while (*p == tag);\n    }\n    tag = *p;\n    if (tag == 0x5e) {'),
]
