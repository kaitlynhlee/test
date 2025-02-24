
#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file main.cpp"
g++  -m64 -Wall -no-pie -o main.o -std=c++20 -c main.cpp

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the source file output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Compile the source file sort.c"
gcc  -m64 -Wall -no-pie -o sort.o -std=c2x -c sort.c

echo "Assemble the source file sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble the source file swap.asm"
nasm -f elf64 -l swap.lis -o swap.o swap.asm

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o output.out manager.o main.o sort.o swap.o isfloat.o input_array.o output_array.o sum.o -z noexecstack -lm

echo "Execute the program"
chmod +x output.out
./output.out

echo "This bash script will now terminate."

