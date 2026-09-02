BASE = """            i = 0;
          } while (0);
        } while (0);
      } while (0);

language_draw_loop:
      if (i < 2) {"""
VARIANTS = [
 ('cur goto-loop', BASE),
 ('for-loop init', """          } while (0);
        } while (0);
      } while (0);

      for (i = 0; i < 2; ) {"""),
]
