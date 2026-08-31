# TU-order audit P426 tool backup

Before adding co-equal symbol-alias disambiguation, the complete original
`tools/tu_order_audit.py` and `tools/calltarget_audit.py` are retained in Git commit
`199de6c1d076c879e64a446640f9dd1f8b7895b1` and can be recovered with:

```text
git show 199de6c1d076c879e64a446640f9dd1f8b7895b1:tools/tu_order_audit.py
git show 199de6c1d076c879e64a446640f9dd1f8b7895b1:tools/calltarget_audit.py
```

The P426 changes are audit-only. They do not alter compiler output, object code,
link order, or post-process instructions. They resolve a co-equal symbol group
only when exactly one alias suffix encodes its configured retail VA; otherwise
the group is counted and excluded as ambiguous. The call-target audit also now
returns failure when it reports a proven wrong target.
