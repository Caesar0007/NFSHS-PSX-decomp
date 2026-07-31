import io, subprocess, sys, shutil
P = 'recon/game/psx/device.cpp'
BASE = io.open(P, encoding='utf-8').read()
ORIG = """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = -isP2;
    uVar2 = uVar1 & 2;"""
variants = {
 'A_notplus1': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = ~isP2 + 1;
    uVar2 = uVar1 & 2;""",
 'B_signed': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = (u_int)(0 - (int)isP2);
    uVar2 = uVar1 & 2;""",
 'C_zerominus': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = 0 - isP2;
    uVar2 = uVar1 & 2;""",
 'D_xor': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = (isP2 ^ 0xffffffff) + 1;
    uVar2 = uVar1 & 2;""",
 'E_mult': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = isP2 * 0xffffffff;
    uVar2 = uVar1 & 2;""",
 'F_sub1': """    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = isP2 - (isP2 << 1);
    uVar2 = uVar1 & 2;""",
}
assert ORIG in BASE
for name, v in variants.items():
    io.open(P, 'w', encoding='utf-8', newline='').write(BASE.replace(ORIG, v))
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', P, 'Device_VerifyType__Fi'],
                       capture_output=True, text=True)
    line = [l for l in r.stdout.splitlines() if 'PASS' in l or 'FAIL' in l]
    print(name, line[:1] if line else r.stdout[-200:] + r.stderr[-300:])
io.open(P, 'w', encoding='utf-8', newline='').write(BASE)
