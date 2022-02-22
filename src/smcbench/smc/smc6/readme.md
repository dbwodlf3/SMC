# smc 코드 6번

#### Mutual-modifying Modules - Mutual modification

```asm
	.text
main:  j alter
	sw $8, alter
alter: lw $8, main
       li $9, 0
       sw $9, main
       j main

```

### Description
SMC6.MIPS.S는 서로 상대를 변경하는 코드(mutual modifying blocks)을 보여주기 위한 목적의 코드이다. 라벨 main에서 시작해서 라벨 alter로 먼저 이동한다. 라벨 main의 주소의 명령어를 레지스터 $8에 저장하고, 레지스터 $9에 0을 저장한다. 0은 MIPS 명령어 nop에 해당한다. 라벨 main으로 이동해서 명령어 nop를 실행한 다음 라벨 alter의 위치에 레지스터 $8에 저장해두었던 j alter를 저장한다. 그 다음에 실행할 주소가 라벨 alter이고, 이 명령어는 자기 자신의 위치로 이동하는 명령어이므로 이후 무한 반복 실행한다.

Step 1.
- Jump Alter

Step 2.

- Load value of main into $8
- $8 = 'j alter'

Step 3.

- Load value 0 into $9

Step 4.

- Store value of $9 into main

- So ' j alter ' -> 'nop'

Step 5.

- Jump main

Step 6.

- NOP. then execute next instruction(Step 7)

Step 7.

- Store value of $8 into alter

- So The result like this.

```asm
	.text
main:  
	nop
	sw $8, alter
alter: 
	jp alter ; pc is here now.
	li $9, 0
	sw $9, main
	j main
```

Step 8.

- JMP TO SELF.

- INFINITY LOOP.


### C Program 동작 확인
```shell
gcc smc6.c -o result 		                				      #gcc compile
./result

## 무한루프시 SMC 정상 작동
```


실행 과정

```
  $8 <- "j alter"
  $9 <- 0       // MIPS에서 nop 명령어

  alter := "j alter"
```
위 실행 후 alter에서 무한 루프를 수행한다.


