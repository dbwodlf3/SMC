define dso_local i32 @main() {
  entry:
    %add_ins1 = add i8 add (i8 1, i8 add (i8 2, i8 3)), 1
    %add_ins2 = add i8 1, %add_ins1
    %add_ins3 = add i8 2, 3
    ret i32 0
}  