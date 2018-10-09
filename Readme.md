# Multi Cycle CPU

- Initialization file is stored in `multicycle-cpu.srcs/sources_1/ip/Mem/memory.coe`
- And it represents the following assembly code:

```
lw $t1, 11($zero) # the data stored in 11($zero) is 0x11223344
lw $t2, 12($zero) # the data stored in 12($zero) is 0x00112233
add $t3, $t1, $t2
sub $t4, $t1, $t2
and $t5, $t3, $t4
nor $t6, $t4, $t5
slt $t6, $t6, $t3
or $t6, $t3, $t6
sw $t6, 13($zero)
lw $t7, 13($zero)
j 0
```
