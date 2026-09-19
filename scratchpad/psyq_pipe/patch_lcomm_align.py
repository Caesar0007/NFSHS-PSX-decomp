"""One-shot: teach the vendored maspsx the ASPSX 2.77 `.lcomm` layout and wire it into build.py's C++ path.
LAW (scratchpad/psyq_pipe/lcomm_probe.py + lcomm_sweep.py, real ASPSX 2.77 + PSYLINK 2.73): every `.lcomm`
symbol is aligned, relative to its section start, to the next power of two >= its size, capped at 16
(5->8, 12->16, 17..->16); ASPSX 2.56 packs at 4.  Retail collide: three 36-byte arrays 48 apart, then a
24-byte one -- exactly this.  GNU as equivalent of the lowering: `.align n` before the label."""
R = 'C:/Temp/nfs4-decomp/tools/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:60], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('maspsx/maspsx/__init__.py', [
    ('        preserve_small_common_binding=False,\n    ):',
     '        preserve_small_common_binding=False,\n        aspsx_lcomm_align=False,\n    ):'),
    ('        self.preserve_small_common_binding = preserve_small_common_binding\n',
     '        self.preserve_small_common_binding = preserve_small_common_binding\n'
     '        self.aspsx_lcomm_align = aspsx_lcomm_align\n'),
    ('                # only mark bss symbols as global -- and only those that\n',
     '                # ASPSX 2.77 `.lcomm` layout (nfs4 2026-09-19, real-assembler probes\n'
     '                # scratchpad/psyq_pipe/lcomm_probe.py / lcomm_sweep.py): each local common is\n'
     '                # aligned, section-relative, to the next power of two >= its size, capped at 16.\n'
     '                if section == "bss" and self.aspsx_lcomm_align and symbol not in self.comm_symbols:\n'
     '                    exp = 0\n'
     '                    while (1 << exp) < size and exp < 4:\n'
     '                        exp += 1\n'
     '                    if exp:\n'
     '                        res.append(f"\\t.align {exp}")\n'
     '\n'
     '                # only mark bss symbols as global -- and only those that\n'),
])
edit('maspsx/maspsx.py', [
    ('    parser.add_argument("--preserve-small-common-binding", action="store_true")\n',
     '    parser.add_argument("--preserve-small-common-binding", action="store_true")\n'
     '    parser.add_argument("--aspsx-lcomm-align", action="store_true")\n'),
    ('        preserve_small_common_binding=args.preserve_small_common_binding,\n',
     '        preserve_small_common_binding=args.preserve_small_common_binding,\n'
     '        aspsx_lcomm_align=args.aspsx_lcomm_align,\n'),
])
edit('build.py', [
    ('    if tu_flags.get("preserve_small_common_binding"):\n        maspsx_cmd.append("--preserve-small-common-binding")\n'
     '    # cfront dtor mangling:',
     '    if tu_flags.get("preserve_small_common_binding"):\n        maspsx_cmd.append("--preserve-small-common-binding")\n'
     '    # ASPSX 2.77 `.lcomm` layout (2026-09-19): the game/frontend C++ objects were assembled by 2.77, which\n'
     '    # aligns every local common to min(16, next pow2 >= size) -- retail collide/camera/screenmain spacing.\n'
     '    if not tu_flags.get("no_aspsx_lcomm_align"):\n        maspsx_cmd.append("--aspsx-lcomm-align")\n'
     '    # cfront dtor mangling:'),
])
