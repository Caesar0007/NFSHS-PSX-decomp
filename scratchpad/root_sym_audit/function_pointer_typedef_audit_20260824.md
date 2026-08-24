# Function-pointer typedef audit closure (2026-08-24)

The final two game/common type findings were reported for the `function`
parameters of `Sched_AddFunction` and `Sched_DeleteFunction`. Retail SYM records
each as `PTR FCN VOID`; the source spells the exact declared alias:

```cpp
typedef void (*Sched_tFunctionPt)(void *);
```

This is the same function-pointer constructor, not `void *` and not a conflicting
source type. Ctags exposes only the typedef name in parameter `typeref`, so the
audit previously could not activate its existing generic-function-pointer
equivalence.

The tracked audit now discovers actual `typedef R (*Name)(Args);` declarations
from reconstructed headers and accepts a typedef name only when SYM independently
records `FCN`. It does not equate ordinary pointer-sized aliases with function
pointers and does not hard-code `Sched_tFunctionPt`.

Fresh strict audits for game/common, game/PSX, and frontend/common all report:

- missing reliable SYM local names: 0;
- type-comparison findings: 0;
- function storage-class findings: 0.

`Sched_AddFunction` remains PASS at 45/45 instructions and
`Sched_DeleteFunction` remains PASS at 51/51. No reconstructed source or compiler
output was changed.
