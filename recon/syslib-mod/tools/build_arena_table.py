#!/usr/bin/env python3
"""Generate the compact resident arena table from production_race_reclaim.json."""
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];SOURCE=ROOT/'production_race_reclaim.json';OUTPUT=ROOT/'psx/overlay_arena_table.inc'
def main():
 d=json.loads(SOURCE.read_text());rows=d['ranges'];starts=','.join(f'0x{int(x["va"],16):08X}' for x in rows);sizes=','.join(str(x['size']) for x in rows)
 text=f'#define SYSLIBMOD_ARENA_COUNT {len(rows)}\nstatic const u32 arena_start[SYSLIBMOD_ARENA_COUNT]={{{starts}}};\nstatic const unsigned short arena_size[SYSLIBMOD_ARENA_COUNT]={{{sizes}}};\n'
 OUTPUT.write_text(text,encoding='ascii');print(f'{OUTPUT}: {len(rows)} ranges, {sum(x["size"] for x in rows)} bytes')
if __name__=='__main__':main()
