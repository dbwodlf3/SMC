# SMC 코드 4번

#### Multilevel runtime code generation

```assembly
.text

main: 
	la $9, gen        # get the target addr
    li $8, 0xac880000 # load Ec(sw $8,0($4))
    sw $8, 0($9)      # store to gen
    li $8, 0x00800008 # load Ec(jr $4)
    sw $8, 4($9)      # store to gen+4
    la $4, ggen       # $4 = ggen
    la $9, main       # $9 = main
    li $8, 0x01200008 # load Ec(jr $9) to $8
    j gen             # jump to target
      
gen: 
	nop               # to be generated
    nop               # to be generated
      
ggen: 
	nop               # to be generated
```



SMC4.MIPS.S는 다중 런타임 코드 생성(multilevel runtime code generation)를 보여주기 위한 목적의 코드이다. 프로그램을 실행하면서 생성한 코드를 실행하면 또 다른 코드를 생성하는 방식이다. 

먼저 라벨 gen의 주소를 레지스터 $9에 불러온다. 레지스터 $8에 0xac880000값 (MIPS 명령어 sw $8,0($4)에 해당하는)을 불러와서 이 값을 gen 라벨의 주소에 저장한다. 

레지스터 $8에 0xac880008 값 (MIPS 명령어 jr $4에 상응하는) 을 불러온다. 그리고 그 값을 레지스터 $9에 저장된 gen 주소 다음(+4)에 저장한다. 

레지스터 $4에 라벨 ggen의 주소를 저장한 다음 레지스터 $9에 라벨 main의 주소를 저장한다. 그리고 레지스터 $8의 값에 0x01200008(MIPS 명령어 jr $9에 상응하는)값을 불러온다. 라벨 gen으로 이동해서 여기에 생성한 코드를 실행한다. 즉 $8를 $4에 저장한 다음 $4의 주소로 분기한다.

앞서 레지스터 $4에 ggen의 주소를 저장했기 때문에, ggen으로 이동한다. 이때, $9에 main의 주소를 넣어두었으므로 ggen에서 main으로 이동한다. 이 과정을 무한 반복한다.

라벨 gen에 저장된 명령어 sw $8, 0($4)에 의해 라벨 ggen의 명령어를 생성하고, 라벨 gen 다음에 저장된 명령어 jr $4로 ggen으로 이동한 다음 생성한 명령어 jr $9를 실행한다. 즉, 다중 런타임 코드 생성 방식으로 동작함을 알 수 있다. 


### C Program 동작 확인
```shell
gcc smc4.c -o result 		                				#gcc compile
gdb ./result                                                #gdb execute
b *main+110                                                 #break
disass main                                                 #disass후 modifing 이전의 main의 memory 상태 확인.  (main+259 ~ main+302)
c
disass main                                                 #disass후 modifing 이후의 main의 memory 상태 확인. (main+266 ~ main+305)
```
