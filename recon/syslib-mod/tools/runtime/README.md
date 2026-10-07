# Dual DuckStation runtime gate

The pair uses isolated runtimes in `C:\Temp\nfs4-syslib-pair\retail` (port 2350) and
`candidate` (port 2351). Process records bind each run to DuckStation, BIOS, settings, CUE and disc
hashes. Save states are never exchanged between images.

Initial harness control:

```powershell
powershell -ExecutionPolicy Bypass -File recon/syslib-mod/tools/runtime/launch_pair.ps1 -FastBoot
python recon/syslib-mod/tools/runtime/capture_startup_pair.py --output C:\Temp\nfs4-syslib-pair\reports\retail-control-01
powershell -ExecutionPolicy Bypass -File recon/syslib-mod/tools/runtime/stop_pair.ps1
```

The first gate is retail versus retail at `Nfs2_GameModuleStartUp` (`0x800A41A8`). It compares all
game RAM, scratchpad and live registers, while reporting kernel-timing and dead-stack differences.
