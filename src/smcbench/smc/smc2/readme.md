# SMC 코드 2번

#### Runtime Code Checking



```assembly
	.text
main:	
	jal f	
        move $2, $8
        j halt		
        
f:	
	li $8, 42
        lw $9, -4($31)
        lw $10, addr  
        bne $9, $10, halt
        jr $31

halt :	
	j halt

addr:	
	jal f
```

### Description

SMC2.MIPS.S는 스스로 자신의 코드를 읽는 코드(self-reading code)를 보여주기 위한 목적의 코드이다. 특정 프로그램을 실행할지 여부를 결정하기 위해서 자신의 코드를 읽는다. 

대부분의 아키텍처에서 서브루틴을 호출하는 명령어를 제공한다. MIPS는 jal, x86은 call 명령어가 있다. 서브루틴 호출 명령어는 사실 두 개의 명령어의 조합으로 볼 수 있다. 다음 명령어의 주소를 리턴 주소 레지스터 (MIPS에서 $31)에 저장하고, 서브루틴의 주소로 이동한다. 서브루틴이 끝나면 리턴 주소 레지스터는 저장했던 바로 이 다음 명령어를 가리키는 주소를 담고 있을 것이다. 이 주소로 돌아가서 프로그램을 계속 실행한다. 

하지만 악성 프로그램의 경우 리턴 주소 레지스터에 악성 주소를 저장하고 서브루틴으로 이동할 수도 있다. 위 MIPS 예제 코드는 실행시간에 코드를 검사하여(runtime code-checking) 이런 시도를 막는 법을 데모로 보여준다. 

main 프로그램에서 서브루틴 f를 호출한다. 서브루틴의 할 일을 하고 ($8에 42를 저장) 돌아오기 전에 리턴 주소 레지스터 ($31)에 담긴 주소의 바로 앞에 명령어가 jal 호출 명령어인지 확인한다. 맞다면 정상적으로 main 프로그램의 다음 명령어로 돌아가고, 그렇지 않다면 프로그램을 종료한다.

### C Program 동작 확인

```shell
gcc smc2.c -o result 						#gcc compile
./result						        #execute

## Working? 42 => Code Checking 결과 일치하지 않기때문에 Halt 함수 호출 
## Working? 0 => Code Checking 결과 이상 없음. 정상 종료

```

