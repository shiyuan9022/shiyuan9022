s1=[-105.6	-105.6	-105.5	-105.5	-105.4	-105.4	-105.6	-105.6];
s4=[-105.5	-105.6	-105.6	-105.6	-105.6	-105.6	-105.6	-105.6];
s5=[-105.6	-105.5	-105.5	-105.5	-105.2	-105.6	-105.6	-105.4];
s6=[-105.6	-105.6	-105.6	-105.6	-105.7	-105.8	-105.8	-105.8];
s7=[-105.8	-105.7	-105.7	-105.7	-105.7	-105.7	-105.7	-105.6];
s8=[-105.6	-105.7	-105.5	-105.6	-105.6	-105.8	-105.7	-105.3];
s9=[-105.6	-105.6	-105.7	-105.6	-105.6	-105.6	-105.7	-105.6];
s10=[-106.1	-105.6	-105.8	-105.7	-105.8	-105.9	-105.7	-105.7];
s11=[-105.7	-105.7	-105.8	-105.7	-105.7	-105.7	-105.7	-105.7];
s12=[-105.7	-105.7	-105.7	-105.7	-105.7	-105.8	-105.7	-105.7];
s14=[-105.7	-105.6	-105.7	-105.7	-105.6	-105.4	-105.6	-105.6];
s15=[-105.8	-105.5	-105.5	-105.6	-105.8	-105.7	-105.6	-105.7];
s16=[-105.7	-105.7	-105.7	-105.7	-105.8	-105.7	-105.6	-105.6];
s17=[-105.7	-105.7	-105.8	-105.7	-105.8	-105.6	-105.6	-105.8];
s18=[-105.5	-105.7	-105.6	-105.8	-105.7	-105.7	-105.6	-105.8];
s19=[-105.9	-105.8	-105.8	-105.8	-105.7	-105	-105.6	-105.7];
s20=[-105.8	-105.8	-105.7	-105.7	-105.7	-105.7	-105.6	-105.8];
s21=[];
s22=[-105.7	-105.7	-105.6	-105.6	-105.7	-105.7	-105.5	-105.7];



ant=[1 2 3 4 5 6 7 8];
grid on;
hold on;
plot(ant,s1,'k-+');
plot(ant,s4,'k-o');
plot(ant,s5,'k-*');
plot(ant,s6,'k-.');
plot(ant,s7,'k-s');
plot(ant,s8,'k-d');
plot(ant,s9,'y-+');
plot(ant,s10,'y-o');
plot(ant,s11,'y-*');
plot(ant,s12,'y-.');
plot(ant,s14,'y-s');
plot(ant,s15,'y-d');
plot(ant,s16,'b-+');
plot(ant,s17,'b-o');
plot(ant,s18,'b-*');
plot(ant,s19,'b-.');
plot(ant,s20,'b-s');
plot(ant,s22,'b-d');
%ylim([-105.9 -105]);
ylabel('sensitivity_B');
xlabel('antenna');
