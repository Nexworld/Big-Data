A = load '/user/hue/input/Word_Count_input.txt' ;
B = foreach A generate flatten(TOKENIZE((chararray)$0)) as word;
C = group B by word;
D = foreach C generate COUNT(B), group;
store D into '/user/hue/pigwordcount';