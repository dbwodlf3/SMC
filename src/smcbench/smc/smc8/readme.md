# SMC 코드 8번

#### Polymorphic Code - Mutual Modiﬁcation

```asm
main: la $10, body	# load $10에  body주소 즉, 0x20420003이 들어간다

body: lw $8, 12($10)	# $8 = $10+12의 명령어 즉, 3줄 다음인 (addi $2,$2, 21) 
      lw $9, 16($10)    # $9 = $10+16의 명령어 즉, 4줄 다음인 두번째(addi $2,$2, 21) 
      sw $9, 12($10)    # (1) $10+12 위치에 $9(addi $2,$2, 21)를 저장 
      addi $2,$2, 21    #
      addi $2,$2, 21    #
      sw $8, 16($10)    # (2) $10+16 위치에 $8(addi $2,$2, 21)을 저장 
      lw $9, 8($10)     # $9 = $10+8의 명령어(sw $9, 12($10))
      lw $8, 20($10)    # $8 = $10+20의 명령어(sw $8, 16($10))
      sw $9, 20($10)    # (3) $10+20 위치에 $9((sw $9, 12($10))를 저장 
      sw $8, 8($10)	# (4) $10+8 위치에 $8(sw $8, 16($10))을 저장 
      j body            # body로 가서 위를 무한 반복
```
### Description

SMC8.MIPS.S는 코드의 원래 동작은 유지하면서 형태를 바꾸는 코드(polymorphic code)를 보여주기 위한 목적의 코드이다. 컴퓨터 바이러스와 트로이안 목마 프로그램에서 자신의 존재를 숨기고자 흔히 사용된다. 안티 바이러스 소프트웨어는 흔히 특별한 바이너리 패턴을 통해 바이러스를 확인하기 때문에 다형 코드 기법으로 확인을 어렵게 할 수 있다.

(1), (2) : body의 4, 5번째 줄의 명령(addi $2, $2, 21, 그리고 addi $2, $2, 21)이 서로 바뀌지만, 같은 명령이기 때문에 실질적인 변화는 없다

(3), (4) : body의 3, 6번째 줄의 명령(sw $9, 12($10) , 그리고 sw $8, 16($10))이 서로 바뀐다

j body 명령으로 body의 처음으로 돌아가 무한 반복, body의 3, 6번째 줄의 명령이 서로 계속해서 바뀐다


### C Program 동작 확인
```shell
gcc smc8.c -o result 		                			#gcc compile
./result
## 무한루프 발생시 SMC 동작

gdb ./result
b *main+62                                                  
# 이후 continue명령어를 실행해가면서 disass main을 해보면 main binary가 계속 바뀌는것을 확인할 수 있다.
```




전체적으로 이 코드는 $8과 $9에 서로 포인터를 저장해서 덮어 씌운후 다시 body 문을 돌면서 원래대로 보여지는 코드이다.

$9에는 body+2번째 줄을, $8에는 body + 5번째 줄을  load 한후

바꿔서 sw 한 후에 반복하는 과정에 다시 바뀌어 원래 자리애 sw 된다.



#### SMC8_Mutual_Modification Written As C 동작 확인 방법

해당 코드는 GCC Compiler에서 작동하도록 작성되었습니다.

해당 코드를 컴파일 한 뒤,  gdb 디버거로 Self-Modifing 동작을 확인할 수 있습니다.

1. body 부분에 break를 걸기 (break *main+62)
2. c (continue)명령과 disass main으로 코드의 동작을 확인합니다.
3. gdb상에서 main + 279의 이전에 해당하는 명령어가 계속 바뀌는 것을 확인할 수 있습니다. (mov -> add -> mov -> add)



