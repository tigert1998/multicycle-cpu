# Multi Cycle CPU

- Initialization file is stored in `ipcore_dir/memory.coe`
- And it represents the following assembly code:

```
lw $t1, 9($zero) # the data stored in 9($zero) is 0x11223344
lw $t2, 10($zero) # the data stored in 10($zero) is 0x00112233
add $t3, $t1, $t2
sub $t4, $t1, $t2
and $t5, $t3, $t4
nor $t6, $t4, $t5
sw $t6, 11($zero)
lw $t7, 11($zero)
j 0
```