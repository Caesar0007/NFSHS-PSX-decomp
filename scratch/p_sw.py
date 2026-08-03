import os

DEF = "u_long font_abr;\r\n"
BODY_ABR = "  abr_val = font_abr;"
ZEROS = ("  *(u_int *)(base + 0x94) = 0;\r\n"
         "  *(u_int *)(base + 0x98) = 0;\r\n"
         "  *(u_int *)(base + 0x9c) = 0;")

# a sized-[1] STRUCT view (MEM_IN_STRUCT_P set) on font_abr ...
SVIEW = ("u_long font_abr;\r\n"
         "struct FontAbrView { u_long v; };\r\n"
         "extern struct FontAbrView font_abr_s[1] __asm__(\"font_abr\");\r\n")
# ... and a matching struct view for the three zero stores
ZSTRUCT = ("  {\r\n  struct FontZeroView { u_int a, b, c; };\r\n"
           "  ((struct FontZeroView *)(base + 0x94))->a = 0;\r\n"
           "  ((struct FontZeroView *)(base + 0x94))->b = 0;\r\n"
           "  ((struct FontZeroView *)(base + 0x94))->c = 0;\r\n  }")

V = {
 'a1': lambda s: s.replace(DEF, SVIEW).replace(BODY_ABR, "  abr_val = font_abr_s[0].v;"),
 'a2': lambda s: s.replace(DEF, SVIEW).replace(BODY_ABR, "  abr_val = font_abr_s[0].v;")
                  .replace(ZEROS, ZSTRUCT),
 'a3': lambda s: s.replace(ZEROS, ZSTRUCT),
 # whole-struct zero assignment for the three words
 'a4': lambda s: s.replace(ZEROS,
        "  {\r\n  struct FontZeroView { u_int a, b, c; };\r\n"
        "  struct FontZeroView z; z.a = 0; z.b = 0; z.c = 0;\r\n"
        "  *(struct FontZeroView *)(base + 0x94) = z;\r\n  }"),
 # abr read through a sized-[1] SCALAR array view + struct zero stores
 'a5': lambda s: s.replace(DEF, "u_long font_abr;\r\nextern u_long font_abr_v[1] __asm__(\"font_abr\");\r\n")
                  .replace(BODY_ABR, "  abr_val = font_abr_v[0];").replace(ZEROS, ZSTRUCT),
}


def apply(src):
    assert src.count(DEF) == 1 and src.count(BODY_ABR) == 1 and src.count(ZEROS) == 1
    return V[os.environ['V']](src)
