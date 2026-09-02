F = ('  __asm__("" : "=r"(volume) : "0"(volume));\n'
     '  __asm__("" : "=r"(sound) : "0"(sound));\n')
TAIL = '  AudioCmn_PlayFESFXVol(sound,volume);\n'
def rep(s,n): return ''.join(s for _ in range(n))
VARIANTS=[("drop",[(F,"")])]
VARIANTS += [
 ("abs_vol1", [(F, '  volume &= (volume | sound);\n')]),
 ("abs_vol2", [(F, rep('  volume &= (volume | sound);\n',2))]),
 ("abs_snd1", [(F, '  sound &= (sound | volume);\n')]),
 ("abs_both", [(F, '  volume &= (volume | sound);\n  sound &= (sound | volume);\n')]),
 ("abs_both_rev", [(F, '  sound &= (sound | volume);\n  volume &= (volume | sound);\n')]),
 ("abs_both_or", [(F, '  volume |= (volume & sound);\n  sound |= (sound & volume);\n')]),
 ("abs_vs_key", [(F, '  volume &= (volume | (int)keyval);\n  sound &= (sound | (int)keyval);\n')]),
 ("deadreassign", [(F, ""), (TAIL, TAIL + '  sound = 0;\n  volume = 0;\n')]),
 ("deadreassign_keepfence1", [(F, '  __asm__("" : "=r"(volume) : "0"(volume));\n'), (TAIL, TAIL + '  sound = 0;\n')]),
]
