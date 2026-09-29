#!/usr/bin/env python3
"""Coverage check: every file name on an extracted NFS3 / NFS4 disc must match a documented family.

  track_coverage.py nfs3 C:/Temp/nfs3_disc
  track_coverage.py nfs4 C:/Temp/nfs4_disc

Prints one line per family (count, first example, spec section) and lists every name that matches
neither a track family nor a known non-track family; exits 1 if any name is unclassified.
"""
import os, re, sys

L = r'(ENG|FRE|GER|ITA|SPA|SWE|MET)'
TRACK = {
 'nfs3': [
  (r'ZZZTR\d\d[AB]\.TRK', 'TRK §1'), (r'ZTR\d\d[AB]\.COL', 'COL §2'), (r'ZTR\d\d[AB]\.CCM', 'CCM §4'),
  (r'ZTR\d\d[AB][0R]\.PSH', 'PSH (NFS4_PSH.md)'), (r'ZTR\d\d[AB]A\.VIV', 'A.VIV §8'),
  (r'ZTR\d\d[AB]\.DPQ', 'DPQ §10.2'), (r'ZTR\d\d[AB]\.HRZ', 'HRZ §10.1'), (r'ZTR\d\d[AB][DNW]\.CLR', 'CLR §10.3'),
  (r'ZTR\d\d[AB](N|W|NW)?\.BNK', 'BNK §11.1'), (r'ZTR\d\d[AB]T[FB]\.BIN', 'tutor §5'), (r'ZTR\d\d[AB]\.VIS', 'VIS (unused) §1.5'),
  (r'ZTR\d\d[FR]\.Q[AS][LS]', 'Q* §7'), (r'ZTR\d\d[FR]\.QBE', 'QBE §7'), (r'ZTR\d\d\.QTS', 'QTS §7'),
  (r'ZTR\d\d(BEG|EXP)\.COP', 'COP §6'), (r'ZTR\d\dCSP\.' + L, 'speech table §11.2'), (r'ZZZTR\d\dC\.' + L, 'speech clips §11.2'),
  (r'ZZZTR\d\dA\.TRJ', 'music stream §11'), (r'ZZZTR\d\dB\.TRM', 'music stream §11'),
  (r'ZTR\d\d(PGR|PGT|ROK|TEC|TOK|R\d\d|T\d\d|R0[AB])\.MAP', 'music map §11.3'),
  (r'ZLOADT\d[AB]?\.QPS', 'loading picture (file set)'),
  (r'ZSFX\.PSH', 'global'), (r'ZNIGHT\.PSH', 'global'), (r'ZZTRK[A-Z]{3}\.PSH', 'FE track pictures'),
  (r'ZGRID\.BIN', 'unused'), (r'ZSURF\d\.PSH', 'unused'), (r'ZCARMAP\.DAT', 'global (car data)'),
  (r'Z(PRSONAL|SCRIPTS|SPREAD|GLUE|HHGLUE|KOGLUE)\.BIN', 'global race config'),
 ],
 'nfs4': [
  (r'ZTR\d\d[NSW]?\.GRP', 'GRP'), (r'ZTR\d\d[NSW]?0\.PSH', 'textures'), (r'ZTR\d\dR\.PSH', 'reflection textures'),
  (r'ZTR\d\d[NSW]?\.FOG', 'AUX .FOG'), (r'ZTR\d\d\.ENV', 'AUX .ENV'), (r'ZTR\d\d\.BIN', 'AUX TrackSpec'),
  (r'ZTR\d\d\.KIL', 'AUX .KIL'), (r'ZTR\d\d\.COP', 'AUX .COP'), (r'ZTR\d\d\.Q(BE|CR)', 'AUX .QBE/.QCR'),
  (r'ZTR\d\d0[0-3]\.AUD', 'AUX .AUD'), (r'ZTR\d\dA\.VIV', 'AUX A.VIV'), (r'ZLOAD\d+[AB]\.QPS', 'loading picture'),
  (r'ZCAMERA\.VIV', 'AUX .rho'), (r'ZSCENE\.VIV', 'AUX .scn'),
  (r'ZTRACK\.DAT', 'AUX global'), (r'ZTRAFCFG\.DAT', 'AUX global (not loaded)'), (r'ZFETRKB?\.TRK', 'AUX global'),
  (r'ZTOURN[BC]?\.TRN', 'AUX global'), (r'ZSFX(4W?)?\.PSH', 'AUX global'), (r'ZNIGHT\.PSH', 'AUX global'),
  (r'ZZZZTR(\d\d|N)\.DCT', 'preview videos'), (r'ZZZZW[A-Z0-9]{3}\.VIV', 'cop speech'),
  (r'ZCARMAP\.DAT', 'global (car data)'), (r'ZZHPURS2?\.MIS', 'AUX Hot Pursuit stages'),
 ],
}
# Known non-track families (cars, front end, audio, system) — listed so that the remainder is provably empty.
OTHER = {
 'nfs3': [r'Z[A-Z0-9]{2,5}\.(GEO|PSH|QDA)', r'ZP[A-Z0-9]{4}\.QDA', r'ZLOADC\d\.QPS', r'Z[OS]?B[A-Z0-9]{3,6}\.BNK', r'ZZ.*',
          r'ZTEXT\.' + L, r'ZCNT[A-Z]{3}\.BNK', r'Z(GEN|FESFX)\.BNK', r'ZPAUSE[A-Z]{2}\.PSH', r'Z(SMALL\d?|LARGE)\.PFN',
          r'ZSPEECH\.IDX', r'ZSIMTUNE\.(QDA|DAT)', r'ZCARMENU\.CLR', r'Z(HUD|BAR|SHOW|LOADB)\.PSH', r'ZDELTA\.SJH', r'ZDCT\.BIN',
          r'(SLUS_\d+\.\d+|SYSTEM\.CNF|LICENSEA\.DAT|FRONT\.BIN)'],
 'nfs4': [r'Z[A-Z0-9]{3,5}\.(QDA|QCS)', r'Z[A-Z0-9]{3,5}EN[GS]\.VIV', r'ZZZ[A-Z0-9]{3,5}[SLHD]?\.(VIV|PSH)', r'ZZZZ.*',
          r'ZZ(SWED|GERM|FREN|ENGL)\.VIV', r'ZZCRED[A-Z0-9]\.DAT', r'Z(P?TEXT)\.' + L, r'ZPAUSE[A-Z]{2}\.PSH',
          r'Z(TITLE|TINY|SMALL|FONT)\.PFN', r'Z(HUD|BAR|SHOW|LOADA|LOADB|LICENSE|LDIC)\.PSH', r'Z(TUNING|SPREAD|SCRIPTS|PRSONAL|GLUE|HHGLUE|BTCGLUE)\.(CSV|BIN)',
          r'ZFECARS[BD]?\.CAR', r'Z(GEN[A-Z]{3}|CNT[A-Z]{3}|ENGINE[OM]?|FESFX)\.BNK', r'ZDUSTY\.VIV', r'ZZZFE\.VIV',
          r'(PSX\.EXE|NFS4[A-Z]*\.(SYM|MAP|EXE|CPE|XA)|DEMO\d+AV\.XA|EADOLBY\.XA|SYSTEM\.CNF|LICENSEA\.DAT|FRONT\.BIN|INSTALL\.PSX)'],
}

def main():
    game, root = sys.argv[1], sys.argv[2]
    names = sorted({f.upper() for _, _, fs in os.walk(root) for f in fs})
    left = set(names)
    for pat, sec in TRACK[game]:
        hit = [n for n in names if re.fullmatch(pat, n)]
        left -= set(hit)
        print(f'{len(hit):4d}  {pat:48s} {hit[0] if hit else "-":16s} {sec}')
    track_left = set(left)
    for pat in OTHER[game]:
        left -= {n for n in left if re.fullmatch(pat, n)}
    print(f'\n{len(names)} files; {len(names) - len(track_left)} in track families; {len(track_left) - len(left)} known non-track; unclassified: {sorted(left) or "none"}')
    sys.exit(1 if left else 0)

if __name__ == '__main__':
    main()
