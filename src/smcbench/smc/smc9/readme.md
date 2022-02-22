# SMC 코드 9번

 #### encrypt.s: Code and speciﬁcation

```asm
main: la $8, pg		        # $8에 pg의 주소 저장
      la $9, pgend		# $9에 pgend의 주소 저장
      li $10, 0xffffffff	# $10에 0xffffffff 저장

xor1: lw $11, 0($8)		# $11에 $8(pg의 주소)위치 저장
      xor $11, $11, $10	        # $11에 xor 한 값 저장
      sw $11, 0($8) 		# xor 결과값을 pg에 넣는다
      addi $8, $8, 4		# 
      blt $8, $9, xor1	        # $8<$9면 xor1로 branch, (blt = branch on less than)

decr: la $8, pg		        # $8에 pg의 주소 저장
      la $9, pgend		# $9에 pgend의 주소 저장
      la $10, 0xffffffff	# $10에 0xffffffff 저장

xor2: lw $11, 0($8)		# $11에 $8(pg의 주소)위치 저장
      xor $11, $11, $10	        # $11에 xor 한 값 저장
      sw $11, 0($8)		# xor 결과값을 pg에 넣는다
      addi $8, $8, 4		# 
      blt $8, $9, xor2	        # $8<$9면 xor2로 branch
      j pg			# pg로 jump

halt: j halt		        # 종료

pg:   li $2, 1		        # 
      li $3, 2		        # 
      add $2, $2, $3		# $2 = 1+2
      j halt		        # 

pgend:			        # 
```

### Decryption
SMC9.MIPS.S는 실행 중에 암호화된 코드를 풀어 실행하는 코드를 보여주기 위한 목적으로 작성되었다. 특히 암호화된 코드가 위치한 메모리 영역에 그대로 코드를 생성한다. 

라벨 main과 xor1의 블록은 암호화 루틴이다. 라벨 pg와 pgend 사이의 명령어들을 xor 비트 연산으로 암호화시킨다. 라벨 decr과 xor2 블록은 반대로 암호화된 코드를 그 자리에 푸는 루틴이다. 

암호화 루틴과 암호를 푸는 루틴은 서로 독립적으로 구성되어 있다. 암호화한 코드와 암호를 푸는 루팅을 함께 바이너리를 만들어 저장해두고 로딩하면서 풀어 실행할 수 있다. 


xor1과 xor2 레이블이 실행될 때 pg의 명령이 0xffffffff과 xor되어 명령어가 변하도록 동작

1) xor1 : $8(pg 레이블)에 있는 모든 명령을 $10(0xffffffff)과 xor 함, pg의 명령어들은 알 수 없는 값으로 바뀜

2) xor2 : $8(pg 레이블)에 있는 모든 명령을 다시 $10(0xffffffff)과 xor 함, pg의 명령어들이 다시 원래 명령으로 복구 됨




### C Program 동작 확인
```shell
gcc smc9.c -o result 		                			#gcc compile
./result

## foo함수가 정상적으로 작동하면 SMC 정상 작동
```


```asm
lw $11, 0($8)
```

이 명령어를 통해 pg의 포인터를 가져온다.

```asm
sw $11, 0($8)
```

을 통해  pg의 값(pg:   li $2, 1)이 변화되는것을 볼 수 있다.

![image-20200514124643169](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514124643169.png)

반복으로 한번 더하면 ( li $3, 2) 의 부분이 변화된다.

![image-20200514124804521](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514124804521.png)

이런식으로 나머지 pg 라벨에 있는 명령어들이  모두 변하게 된다.

 

```asm
blt $8, $9, xor1
```

blt = s, t, label 이면 branch if s<t 인 경우 label로 분기하라는 명령어이다.

이 명령어에 따라 xor1의 문을 반복하다가 false가 되면 빠져나온다.

```asm
xor2: 
	sw $11, 0($8)
```

에서, pg의 값에 다시 $11의  즉, pg의 값이 원상복귀된다.

![image-20200514125355730](C:\Users\SWlab\AppData\Roaming\Typora\typora-user-images\image-20200514125355730.png)

이렇게 또 blt가 false 값이 나올때 까지 반복하며, pg 라벨에 있떤 명령어들을 복귀 시킨다.

그리고 나머지 명령어들을 실행하고 종료한다.

