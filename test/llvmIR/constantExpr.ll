define dso_local i32 @main() {
%1 = alloca i8*, align 8
%2 = alloca i8*, align 8
store i8* getelementptr inbounds (i8, i8* bitcast (i32 ()* @main to i8*), i64 107), i8** %1, align 8
ret i32 0
}