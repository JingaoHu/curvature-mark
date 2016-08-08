I=imread('B.png');
figure,imshow(I),title('原图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%图像预处理
I = rgb2gray(I);
I=im2double(I);
I=medfilt1(I,3);
I=im2uint8(I);
I=im2bw(I);
I=~I;
I=edge(I,'canny');%%%%%%提取边缘
figure,imshow(I),title('边缘');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%创建链码
obj_index=0;
while (sum(sum(I))~=0)
obj_index=obj_index+1;
point{obj_index}=save_edge( I );
[~,length]=size(point{obj_index});
for z=1:1:length
    I(point{obj_index}(z).x-7:point{obj_index}(z).x+7,point{obj_index}(z).y-7:point{obj_index}(z).y+7)=0;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%剔除太短的链码
[~,LengthOfPoint]=size(point);
for obj_index=1:LengthOfPoint
    if size(point{LengthOfPoint-obj_index+1},2)<120 point(LengthOfPoint-obj_index+1)=[];
    end

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%在窗口显示检测到的边缘链码
I_obj=zeros(size(I));

for obj_index_2=1:size(point,2);
for aCertainObjectIndex=1:size(point{obj_index_2},2)
    I_obj(point{obj_index_2}(aCertainObjectIndex).x,point{obj_index_2}(aCertainObjectIndex).y)=1;
end
end

figure,imshow(I_obj),title('边缘链码');





 r_sum=zeros(size(I));
 b_sum=zeros(size(I));
 y_sum=zeros(size(I));
 
 
for obj_index_2=1:size(point,2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算边缘的曲率
LengthOfaCertainObject=size(point{ obj_index_2},2)


point{obj_index_2}(LengthOfaCertainObject+1:LengthOfaCertainObject+100)=point{obj_index_2}(1:100);

for p=42:1:LengthOfaCertainObject+42
    if size(point{obj_index_2},2)>1300
    cur{obj_index_2}(p)=1.20*(abs(point{obj_index_2}(p).x-0.5*(point{obj_index_2}(p+41).x+point{obj_index_2}(p-41).x))+abs(point{obj_index_2}(p).y-0.5*(point{obj_index_2}(p+41).y+point{obj_index_2}(p-41).y)));
    end
    
   if size(point{obj_index_2},2)<=1300
     cur{obj_index_2}(p)=(abs(point{obj_index_2}(p).x-0.5*(point{obj_index_2}(p+18).x+point{obj_index_2}(p-18).x))+abs(point{obj_index_2}(p).y-0.5*(point{obj_index_2}(p+18).y+point{obj_index_2}(p-18).y)));
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%显示最终的标记效果
r_1=zeros(size(I));
b_1=zeros(size(I));
y_1=zeros(size(I));
[width_of_point,length_of_point]=size(cur{obj_index_2});
for z=11:length_of_point-10
    
    if size(point{obj_index_2},2)>1300
    if cur{obj_index_2}(z)>21 b_1(point{obj_index_2}(z:z).x,point{obj_index_2}(z:z).y)=1; end
    if (cur{obj_index_2}(z)>1.2)&&(cur{obj_index_2}(z)<=21) y_1(point{obj_index_2}(z).x,point{obj_index_2}(z).y)=1; end
    end
    
     if size(point{obj_index_2},2)<1300
    if cur{obj_index_2}(z)>5.0 b_1(point{obj_index_2}(z:z).x,point{obj_index_2}(z:z).y)=1; end
    if (cur{obj_index_2}(z)>1.2)&&(cur{obj_index_2}(z)<=5.0) y_1(point{obj_index_2}(z).x,point{obj_index_2}(z).y)=1; end
    end
    
     if cur{obj_index_2}(z)<=1.2 r_1(point{obj_index_2}(z).x,point{obj_index_2}(z).y)=1; end
end
 r_sum=r_sum+r_1;
 b_sum=b_sum+b_1;
 y_sum=y_sum+y_1;


end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%滤波平滑
r_sum_1=r_sum;
y_sum_1=y_sum;
b_sum_1=b_sum;

for qi=1:size(point,2)

for ti=17:size(point{qi},2)-17
    if  y_sum(point{qi}(ti).x,point{qi}(ti).y)==1
        for pi=1:32
            y_sum_1(point{qi}(ti-16+pi).x,point{qi}(ti-16+pi).y)=1;
             r_sum_1(point{qi}(ti-16+pi).x,point{qi}(ti-16+pi).y)=0;
              b_sum_1(point{qi}(ti-16+pi).x,point{qi}(ti-16+pi).y)=0;
        end
        
    end
end

for ti=27:size(point{qi},2)-27
    if  b_sum(point{qi}(ti).x,point{qi}(ti).y)==1
        for pi=1:52
            b_sum_1(point{qi}(ti-26+pi).x,point{qi}(ti-26+pi).y)=1;
             r_sum_1(point{qi}(ti-26+pi).x,point{qi}(ti-26+pi).y)=0;
              y_sum_1(point{qi}(ti-26+pi).x,point{qi}(ti-26+pi).y)=0;
        end
        
    end
end

   
    
end

 figure,imshow(cat(3,r_sum_1+y_sum_1,y_sum_1,b_sum_1)),title('标记效果2');

 
