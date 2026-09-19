"""Insert CHECKPOINT 2026-09-19m into the NFS4 memory hub (after the 2026-09-19l line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-19m' not in s
i = s.index('- CHECKPOINT 2026-09-19l:')
j = s.index('\n', i) + 1
NEW = (
    "- CHECKPOINT 2026-09-19m (USER: 'let's trace more in runtime'): blob-only 3780 B (from 15174), honest 0 diff "
    "(297732/297732); nfs4-decomp HEAD = 5a85198f, local commits on top of pushed 6871d324 (UNPUSHED: step 9/10, fe3dmenu, "
    "SimpleMem batch, 091285b2 runtime tracing + steps 11-12, 3002f03d steps 13-14, 03376e5f step 15, 5a85198f step 16). "
    "RUNTIME TOOLING = tools/duckstation/ (api-runtime/ 270 MB gitignored; GDB port 2350 -- NEVER 2349 = TM2's): launch.ps1 "
    "[-FastBoot] / stop.ps1 / gdb_remote.py / blob_trace.py (--seconds --min --per-chunk --attach --load NAME --out FILE "
    "--press --hold --gap; Z4 access watchpoints <=256 B over every blob-only run, maps PC -> retail fn + recon object) / "
    "blob_trace_report.py / reach_race.py (checkpoint `front_menu` @33 s) / press_to_race.py (pad injection: break at "
    "PAD_update's `jr ra` 0x800E4310, write port-0 record 0x8013E8A0 = {0, 0x41, u16 active-low}; CROSS 0x4000, START "
    "0x0008; `--hold 6 --gap 24` reaches a race in 47 s -> checkpoint `race_start`). Front end does NOT use Device_ReadPad; "
    "NFS4 has no attract-mode race; front overlay RAM 0x80010000..0x80054548 is REUSED in a race (race-time hits there are "
    "not ownership evidence). Traces in status/runtime/. Trace-proven owners applied: fixdsqrt tables (fixedsqrt walks the "
    "scale table BACKWARD from D_8012356C), spchrand seedX, aiinit literals + nonStandardList[50] local initializer. "
    "STILL TO APPLY from traces: nsync.c `loadfilecallback` 0x8013DD60, frontend/psx/mdec.cpp 0x80052b28 (16 B, "
    "initmdec/restoremdec). NEW STATIC METHODS this pass: (1) scratchpad/psyq_pipe/label_users.py = recon sources still "
    "naming an address only a blob provides (now 1 left: platform.cpp D_80054D10 in the 2152-byte main-group head; "
    "2mbyte.c D_8013DE5C ra-scratch cell); (2) `bigBuf + offset` views were ordinary literals -> minfront \"FE Data Stream\", "
    "fe3dmenu CameraLookAt upVec, feapp \"%ld\" \"%d/%d\" \"zmenu*\" \"garage*\" \"showcase*\" \"victory*\"; aidatarecord 7 "
    "formats + dead \"%sTr%02d%c.ctk\"; textsys langFileName[] defined AFTER the first function so the tag leads; (3) "
    "up-vector ANCHOR: collide's local `coorddef upVec = {0,0x10000,0}` fixes the 6-tag window 0x800559D0..A28 -> chunk, "
    "clock, [9E8 = unknown text-less object, still blob], collide, color, control; (4) 🔑 scratchpad/psyq_pipe/"
    "sdk_data_match.py = slides every PsyQ 4.3 object's .data (C:/Temp/nfs4-clean/psyq43/extracted, parser tools/objtruth.py, "
    "reloc words masked) over retail data and reports overlaps with blob-only bytes. Applied: libcard INIT.obj stamp "
    "0x8013C328/16 (byte-exact), pad object data 0x8013C338/16 {flag,0,0x1F801040,0x1F801070} (retail PAD object = "
    "ReadInitPadFlag ONLY, exists in NO SDK 4.0-4.6 libapi -> EA/custom; PAD.c now g_value 0), salloc DAT_80136dec[1] "
    "(section .data, end of file). MATCHED BUT NOT YET APPLIED: VSYNC.obj .data really starts 0x80134A80 (+8 before our row), "
    "PADMAIN.obj .data = 0x80137C70..CF0 (8 before + 12 after our row), LIBGPU SYS.obj 0x8012364C/416 (8 unowned), LIBMATH "
    "FERR.obj 0x8013BF10/16, LIBMCRD 0x80136CB0/32 (16 unowned; verify NFS4 links libmcrd), five libcd 4-pointer CD-register "
    "blocks 0x80136AE8/C58/C78/C88/C9C (every libcd C_0xx object matches -> assign by link order). Pitfalls: Bash heredoc "
    "mangles `\\\\n` in python patchers (own_step16 first attempt silently half-applied) -> ALWAYS Write-tool scripts, use "
    "chr(10); Git Bash turns `/l` args into paths -> MSYS_NO_PATHCONV=1 for psylib2.exe /lv.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
