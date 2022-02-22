# SMC1

## Unbounded Code Rewriting

```assembly
section .data
    num db 8

section .text
global _init
_init:
    mov ebp, num  ; num
    mov ecx, 1 	  ; counter
    mov edx, 1 	  ; accumulator

loop:
    cmp ecx, [ebp]   ; compare num and counter
    jz halt          ; if num and counter equal then jump halt.
    add ecx, 1       ; else, counter add 1.
    mov bl, dl       ; save constant operand of add instruction to bl register.(Store Fn into bl.)

key:
    add edx, 0       ; Store next Fibonacci number to edx(Fn + Fn-1 = Fn+1)
    mov al, bl       ; store Fn fibonachi value into al.
    mov [key+2], al  ; update constant operand of add instruction. in add(edx, constant), (Fn). next instruction, Fn+2 = Fn+1 + Fn. and, now is edx Fn+1.
    jmp loop

halt:   ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

### description

SMC1.MIPS.S는 패러미터릭 코드(parameteric code)의 사용을 보여주기 목적의 코드이다. 예시로 피보나치 수열 fib(0) = 0, fib(1) = 1, fib(i+2) = fib(i) + fib(i+1)을 계산하도록 작성되었고, 특히 fib(8) = 21을 계산하여 레지스터 $2에 저장한다.

주어진 코드를 보면 $2를 변경하는 명령어는 li $2, 1과 ($2의 값에 아무 영향을 미치지 않는) 라벨 key의 addi $2, $2, 0 뿐이기 때문에 피보니차 수열 계산이 어떻게 이루어지는지 명확하지 않다.

원하는 피보나치 수를 계산해내기 위한 핵심은 key 라벨 다음의 자체수정 코드 sw $10, key이다. loop 라벨의 루프를 반복할 때마다 위 add 명령어의 3번째 오퍼런드는 다음 피보나치 수로 바뀐다. 

라벨 key의 명령어 add $2, $2, fib(k)와 같이 3번째 오퍼랜드를 패머미터 k로 대체한 패러미터릭 코드를 사용했다. 이 3번째 오퍼랜드가 반복적으로 바뀌면서 이 명령어가 무한히 변경되는 (unbounded code rewriting)의 특징을 갖는다.

#### Step 1. _init

- mov ebp num
- mov ecx, 1
- mov edx, 1

ebp is number of sequence. (n in F1,F2,F3, ... Fn)

ecx is counter.

edx is accumulator of result.

#### Step 2. loop

- cmp ecx, [ebp]

- jz halt

compare n and num and if they are equal then halt else continue.

- add ecx, 1
- mov bl, dl

increase counter.

store Fn into bl.

#### Step 3. key

- add edx, 0

This instruction will be rewritten continually.

- mov al, bl

Store Fn into al

- mov [key+2], al

Store Fn into constant operand of add instruction.


### C Program 동작 확인

```shell
gcc smc1.c -o result 							#gcc compile
./result									#execute
															
# fib(8) = 34가 출력된다면 SMC 정상 작동
```
