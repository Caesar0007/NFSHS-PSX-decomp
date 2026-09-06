# P882 FEDialog scalar shape view

Removed the CPP-local gHelpShapesA[] asm-label view and replaced its four
array-view uses with the existing scalar gHelpShapes pointer. Native SYM768122
is EXT PTR STRUCT tTexture_ShapeInfo,size32,VA80052A64; the public declaration
already has this scalar pointer type. The pointed-to shape table stays indexed.

Whole32/32 PASS, no branch discrepancies; every byte of the normal object is
unchanged (c6c396dcd266d5d211506f03e71c8ee09ae2cc0f01282b4ef0bcbf9897156983).
This includes data, symbols and all relocation names/addends, so no reference
or neighbor change is hidden by normalized comparisons. No new helper/name,
asm/volatile or shared-header change belongs to this retained edit.

The separate ticks scalar-header experiment is fully reverted. Its actual
consumer census was four TUs; both scalar and existing-helper-parameter forms
regressed only Help CalculateDimensions by9 differences/one instruction.
Base32/32 and all6 selected regional cases were reverified after restoration.
See ../p882_fedialog_ticks/README.md for the exact negative evidence; Draw's
loadedTicks was not modified. Existing inferred inline names, source carriers
and the ticks declaration remain open, not newly certified as original source.

Source/header backups here precede the retained pointer-view cleanup. No commit.
