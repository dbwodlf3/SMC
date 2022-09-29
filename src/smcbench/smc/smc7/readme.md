# SMC 코드 7번

#### Self Growing Code

```assembly
	.text
main:
	la $8, loop
	la $9, new
	move $10, $9
	
loop:
	lw $11, 0($8)
	sw $11, 0($9)
	addi $8, $8, 4 #8번 레지스터에서는 loop에 대한 주소가 들어있다.
	addi $9, $9, 4 #9번 레지스터에는 loop에 대한 명령어가 들어있다.
	bne $8, $10, loop
	move $10, $9
new:
```

### Description
SMC7.MIPS.S는 자신의 코드를 읽는 기법(self-reading code)와 런타임 코드 생성을 합하여 스스로 복제하는 코드(self-growing blocks)를 보여주기 위한 목적의 코드이다. 처음 초기화 이후 라벨 loop에서부터 6개의 명령어들을 라벨 new에 복사하고, 라벨 new의 복제된 명령어를 실행하여 그 뒤에 다시 반복해서 복사한다.

라벨 loop의 주소를 레지스터 $8에 저장하고, 라벨 new의 주소를 레지스터 $9에 저장한 다음 이 주소를 $10으로도 복사한다. 라벨 loop로 이동한다.

레지스터 $8의 주소 (loop)의 명령어를 레지스터 $11에 불러오고, 레지스터 $9의 주소에 이 명령어를 복사한다. $8과 $9에 각각 4를 더해 다음 주소를 계산한다. 현재 레지스터 $10에 라벨 new의 주소가 들어 있는데, 레지스터 $8과 $10의 값이 같으면 라벨 loop로 이동하여 다음 명령어를 반복해서 복사한다. 드디어 복사가 라벨 new에 도달하면 그 다음 라벨 new에 해당하는 주소($9)를 레지스터 $10에 저장하여 복사 목적지를 지정한다. 그 다음에 앞서 복사한 라벨 new에 있는 명령어를 실행한다. 그런데 여기서부터 6개의 명령어는 앞서 라벨 loop 블록과 동일하다. 따라서 자신의 코드를 읽어 무한 반복적으로 복사하는 동작을 보인다.

### C Program 동작 확인
```shell
gcc smc7.c -o result 		                				#gcc compile
./result

## Self growing code는 특성상 프로그램의 크기가 계속 커지게 되므로 보호되는 메모리 구역을 침범하게 된다. SegFault가 발생하지만 gdb로 확인시 SMC동작이 제대로 되는것을 확인할 수 있다.
gdb ./result
b *main+108
disass main,+200 											#Self-Growing Code 동작 확인 가능 ( get_permission 함수 메모리 구역 내에 main과 똑같은 Binary코드 발견)
```



```assembly
lw $11, 0($8)
```

이 명령어를 통해서 loop의 명령어를 가져오고



```assembly
sw $11, 0($9)
```

이 명령어를 통해서 new에 loop의 명령어를 저장한다.



즉 $8에는 loop의 코드에서 어디를 복사할것인지 $9에는 어디에 저장할것인지에 대한 레지스터다.

$8이 한칸씩 증가하면서 new에 도달하게되면 

```assembly
move $10, $9
```

해당 명령어를 실행해서 $10에 새로운 기준을 담아주게 된다. 그리고 아까 만들었던 new라는 코드를 실행하고 이게 new가 또 new를 만들고 이러한 과정이 계속 반복된다.
