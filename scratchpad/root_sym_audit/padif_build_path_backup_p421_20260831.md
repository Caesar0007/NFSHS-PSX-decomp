# PADIF path-wiring backup

Date: 2026-08-31

Before restoring the canonical `PADIF.c` owner name, the affected
`tools/build.py` entries were:

```python
"recon/syslib/psx/libpad/MCXMAIN.c":    {"cc1_alt": "2.7.2"},

"recon/syslib/psx/libpad/MCXMAIN.c": {
    "2.8.0 -mno-split-addresses": {"_padIntRecvData", "_padIntRecvHdr"},
},
```

Only the source-path key and nearby owner comments are changed. The compiler
versions, flags, and function sets are preserved exactly; this receipt is the
focused pre-edit backup required for a protected build-tool path update.
