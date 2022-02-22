# SMC 코드 3번

#### Runtime Code Generation

원소의 길이가 3인 두 개의 벡터 vec1과 vec2의 내적을 구하는 코드를 생성하는 프로그램
(주어진 데이터에 맞춘 코드를 생성함으로써 빠르게 내적을 구하는 코드)

```assembly
	.data                  # Data declaration section
vec1:   
        .word 22, 0, 25        # vector1
vec2:   
        .word 7, 429, 6        # vector2
result: 
        .word 0

.text 
main:
        li $4, 3                                    # $4 = number of vector element(3)
        li $8, 0                                    # index for vector element

        la $9, gen                                  # $9 = gen
        la $11, tpl                                 #$11 = tpl

        lw $12, $11	                            # $12 = $11
        sw $12, $9                               # gen의 첫번째에 복사!
                                                    # (참고) 마지막 명령어 처리하는 부분과 비교!

        addi $9, $9, 4                              # $9를 gen의 두번째 명령어 주소를 가리킴

loop:
	beq $8, $4, post                            # if (counter == size) post로 분기
                                                    # else if (counter < size) 코드 생성

                                                    # [REMIND]
                                                    #     counter($8)  = 0, 1, ..., size-1   (cf. size=3)
                                                    #     $9  = gen + ???
                                                    #     $11 = tpl

        li $13, 4                                   # $13 = counter($8) * 4
        mul $13, $13, $8                            #  (참고: mul $13, 4, $8 !!!)

                                                    # 벡터 값이0이냐에 따라 코드 생성 여부 결정
        lw $10, vec1($13)                           #    현재 벡터 값 vec1($13)를 읽어 $10에 읽어오기
        beqz $10, next                              # 현재 벡터 값 $10 == 0:
                                                    #      코드를 생성하지 않고 다음 next로 분기

                                                    # 현재 벡터 값 $10 != 0:
                                                    #      내적합 구하는 코드를 생성

                                                    # [1] lw $13, counter*4($4) 
        lw $12, 4($11)                              #     - lw $13, 0($4)을 읽어
        add $12, $12, $13                           #     - lw $13, counter*4($4)을 만든 다음
        sw $12, 0($9)                               #     - gen+1번째 명령어에 저장

                                                    # [2] li $12, vec1[counter]
        lw $12, 8($11)                              #     - li $12, 0을 읽어
        add $12, $12, $10                           #     - li $12, vec1[counter]을 만든 다음
        sw $12, 4($9)                               #     - gen+2번째 명령어에 저장

                                                    # [3] mul $12, $12, $13
        lw $12, 12($11)	                            #     - gen+3번째 명령어에 저장
        sw $12, 8($9)

        lw $12, 16($11)	                            # [4] add $2, $2, $12
        sw $12, 12($9)                              #     - gen+4번째 명령어에 저장

        addi $9, $9, 16                             # 다음 벡터 원소에 대해 생성할  코드 블록 주소를 $9에 설정

next:
	addi $8, $8, 1                               # counter($8) = counter + 1
        j loop                                       # loop로 돌아감

post:
	lw $12, 20($11)                              # tpl의 마지막 명령어(jr $31)을 읽어서
        sw $12, 0($9)                                # gen의 마지막에 복사!

        la $4, vec2                                  # $4에 vec2의 주소를 가져옴! 나중에 내적 구할 때 사용.

        jal gen                                      # gen에 생성한 코드를 호출한다
        sw $2, result                                # 리턴하면 $2에 들어있는 내적합을 result에 저장한다.

        j main                                       # (종료를 위한 무한 반복 dummy code)

tpl:
                                                     # gen 블록의 첫번째 명령어로 그대로 복사
	li $2, 0                                     #  (참고) 내적의 누적합: $2

                                                     # 벡터의 i번째 원소에 대해 일부 명령어를 수정하여 복사
                                                     #   i=0, 1, 2, ..., size-1

        lw $13, 0($4)                                # ==> lw $13, i*4($4)         (참고) i*4($4) == vec2[i] !!
        li $12, 0                                    # ==> li $12, vec1[i]
        mul $12, $12, $13                            # ==> mul $12, $12, $13
        add $2, $2, $12                              # ==> add $2, $2, $12

        jr $31	                                     # gen 블록의 마지막 명령어로 그대로 복사

gen:	                                             # gen 라벨 다음 코드는 위 프로그램을
                                                     # 실행하면 만들어짐

	li $2, 0           # int gen(int *v)         # 내적의 누적합 = 0 

	lw $13, 0($4)      # {                       # 내적의 누적합 = 0 + vec1[0] * vec2[0] = 0 + 22*7
	li $12, 22         # int res = 0;
	mul $12, $12, $13  # res += 22 * v[0];
	add $2, $2, $12    # res += 25 * v[2];

                                                     # 내적의 누적합 = 0 + vec1[0] * vec2[0] 
                                                     #                 +  vec1[1] * vec2[1] = 0 + 22*7 + 0*429
                                                     #  코드가 생성되지 않음
                                                     #  왜냐하면 vec1[1]이 0이기 때문에 곱하기를 해봐야 결과는 0이므로 영항이 없음.

	lw $13, 8($4)      # return res;             # 내적의 누적합 = 0 + vec1[0] * vec2[0]
                                                     #                 + vec1[1] * vec2[1]
                                                     #                 +  vec1[2] * vec2[2] = 0 + 22*7 + 0*429 + 25*6
	li $12, 25         # }
	mul $12, $12, $13
	add $2, $2, $12

	jr $31
```

tpl 명령어를 참고해 vec1[0] * vec2[0] + vec1[1] * vec2[1] + vec1[2] * vec2[2] ... 를 계산하는 명령어를 gen에 생성한 후, 계산을 실행함

 - tpl - 명령어 코드를 생성할 때 사용할 템플릿 코드

 - gen - tpl을 참고해 새로 생성할 명령어를 저장할 위치

 - 벡터(vec1, vec2)에 저장된 값

          vec1 : 22, 0, 25

          vec2 : 7, 429, 6

(1) loop, next : tpl(template code)를 가져와 해당 명령에 vec1의 값을 넣어 수정하고, gen에 새로운 명령으로 저장

```assembly
tpl에서 명령이 수정될 부분

tpl:
	li $2, 0
        
        lw $13, 0($4)           # 0을 현재 vec1의 index 값으로 바꿈(4byte 단위)
        li $12, 0               # 0을 현재 vec1의 원소 값으로 바꿈
        mul $12, $12, $13
        add $2, $2, $12 

        jr $31
```
 - vec1의 22, 0, 25 세 원소에서 0은 건너뛰었기 때문에 gen은 두 번만 반복되어 생성
```assembly
tpl을 이용해 생성된 gen

gen:
	li $2, 0

	lw $13, 0($4)           # 22 * vec2[0];
	li $12, 22
	mul $12, $12, $13
	add $2, $2, $12

	lw $13, 8($4)           # 25 * vec2[2];
	li $12, 25
	mul $12, $12, $13
	add $2, $2, $12

	jr $31
```

(2) post : vec2을 불러오고 gen을 호출 (gen이 끝나면 다시 post로 돌아와 gen에서 계산된 값을 result에 저장)

(3) gen : 생성된 (vec1[0] * vec2[0]) + (vec1[1] * vec2[1]) + (vec1[2] * vec2[2]) ... 를 계산

따라서 (vec1[0] * vec2[0]) + (vec1[2] * vec2[2]) 를 계산하고, ```22*7 + 25*6``` 의 계산 결과가 result에 저장됨




### C Program 동작 확인
```shell
gcc smc3.c -o result 						#gcc compile
./result > result.log						#execute
## Ctrl + C 를 눌러 프로그램 종료
## result.log의 첫번째줄의 결과 확인  304가 출력되면 SMC 정상 작동

```
