function [point_1]  = save_edge( M );
% calculate the sum of 1..n
flag=0;
[m,n]=size(M);
for i=1:1:m;
    if flag==1 break;
    end
    for j=1:1:n;
        if M(i,j)==1 
            point_1(1).x=i;
            point_1(1).y=j;
            flag=1;
            break;
        end
    end
end;
north=0;
east=0;
south=0;
west=0;
t=1;
I_test=M;
I_test_2=M;
I_test_2(point_1(t).x,point_1(t).y)=0;
for k=0:1
if I_test_2(point_1(t).x,point_1(t).y+1)==1 I_test(point_1(t).x,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x;point_1(t+1).y=point_1(t).y+1;east=east+1;
elseif I_test_2(point_1(t).x+1,point_1(t).y)==1 I_test(point_1(t).x+1,point_1(t).y)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y;south=south+1;
elseif I_test_2(point_1(t).x,point_1(t).y-1)==1 I_test(point_1(t).x,point_1(t).y-1)=0;point_1(t+1).x=point_1(t).x;point_1(t+1).y=point_1(t).y-1;west=west+1;
elseif I_test_2(point_1(t).x-1,point_1(t).y)==1 I_test(point_1(t).x-1,point_1(t).y)=0;point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y;north=north+1;
elseif I_test_2(point_1(t).x+1,point_1(t).y+1)==1 I_test(point_1(t).x+1,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y+1;east=east+1;south=south+1;
elseif I_test_2(point_1(t).x+1,point_1(t).y-1)==1 I_test(point_1(t).x+1,point_1(t).y-1)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y-1;south=south+1;west=west+1;
elseif I_test_2(point_1(t).x-1,point_1(t).y-1)==1 I_test(point_1(t).x-1,point_1(t).y-1)=0; point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y-1;west=west+1;north=north+1;
elseif I_test_2(point_1(t).x-1,point_1(t).y+1)==1 I_test(point_1(t).x-1,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y+1;north=north+1;east=east+1;
else  ;
end   
t=t+1;
end

while((west~=east)||(south~=north))
% if (I_test(point_1(t).x,point_1(t).y+1)==0)&&(I_test(point_1(t).x+1,point_1(t).y+1)==0)&& 
%     (I_test(point_1(t).x+1,point_1(t).y)==0)&&(I_test(point_1(t).x+1,point_1(t).y-1)==0)&&
%     (I_test(point_1(t).x,point_1(t).y-1)==0)&&(I_test(point_1(t).x-1,point_1(t).y-1)==0)&&
%     (I_test(point_1(t).x-1,point_1(t).y)==0)&&(I_test(point_1(t).x-1,point_1(t).y+1)==0) break;
if I_test(point_1(t).x,point_1(t).y+1)==1 I_test(point_1(t).x,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x;point_1(t+1).y=point_1(t).y+1;east=east+1;
elseif I_test(point_1(t).x+1,point_1(t).y)==1 I_test(point_1(t).x+1,point_1(t).y)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y;south=south+1;
elseif I_test(point_1(t).x,point_1(t).y-1)==1 I_test(point_1(t).x,point_1(t).y-1)=0;point_1(t+1).x=point_1(t).x;point_1(t+1).y=point_1(t).y-1;west=west+1;
elseif I_test(point_1(t).x-1,point_1(t).y)==1 I_test(point_1(t).x-1,point_1(t).y)=0;point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y;north=north+1;
elseif I_test(point_1(t).x+1,point_1(t).y+1)==1 I_test(point_1(t).x+1,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y+1;east=east+1;south=south+1;
elseif I_test(point_1(t).x+1,point_1(t).y-1)==1 I_test(point_1(t).x+1,point_1(t).y-1)=0;point_1(t+1).x=point_1(t).x+1;point_1(t+1).y=point_1(t).y-1;south=south+1;west=west+1;
elseif I_test(point_1(t).x-1,point_1(t).y-1)==1 I_test(point_1(t).x-1,point_1(t).y-1)=0; point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y-1;west=west+1;north=north+1;
elseif I_test(point_1(t).x-1,point_1(t).y+1)==1 I_test(point_1(t).x-1,point_1(t).y+1)=0;point_1(t+1).x=point_1(t).x-1;point_1(t+1).y=point_1(t).y+1;north=north+1;east=east+1;
else  break;
end   
t=t+1;
%if t>count break;end
end

