%读取原图并画出原图
pic=imread('C:\Users\93508\Desktop\38.jpg'); %读取原图
figure(1);
imshow(pic); %画出原图
title('原图'); 

%自创的绘制图像直方图的程序
b1=zeros(1,256); %用于存储不同灰度值出现的次数,数组维度为1*256（一维数组）           
%for循环统计不同灰度值出现的次数
for i=0:255              
    b1(i+1)=numel(find(pic(:,:)==i)); 
    %find函数:返回一个数组a，数组a中的元素均为参数传入的数组中满足find条件的元素
    %numel函数:返回数组的元素数目n
end
figure(2);
bar(b1); %画出原图的直方图
title('原图的直方图');

%调用自创的直方图均衡化函数画出均衡化后的图像
pic_final=balance(pic); %调用自创的直方图均衡化函数
figure(4); 
imshow(pic_final); %画出增强图像
title('增强图像');

%自创的绘制图像直方图的程序
b2=zeros(1,256); %用于存储不同灰度值出现的次数,数组维度为1*256（一维数组）           
%for循环统计不同灰度值出现的次数
for i=0:255              
    b2(i+1)=numel(find(pic_final(:,:)==i)); 
    %find函数:返回一个数组a，数组a中的元素均为参数传入的数组中满足find条件的元素
    %numel函数:返回数组的元素数目n
end
figure(5);
bar(b2); %画出增强图像的直方图
title('增强图像的直方图');

%均衡化函数
function pic_final=balance(pic)
    [row,col]=size(pic);
    pic_final=zeros(row,col);
    a=zeros(1,256);
    b=zeros(1,256);
    
    %for循环统计不同灰度值出现的次数
    for i=0:255
        a(i+1)=numel(find(pic(:,:)==i))/(row*col); 
    end
    
    %累积分布函数
    b(1)=a(1);
    for i=2:256
       b(i)=b(i-1)+a(i);
    end
    %画出均衡转换函数图
    figure(3);
    plot(b);
    set(gca,'XTick',0:64:256); 
    
    %四舍五入转换为标准灰度级别并合并
    for i=1:row
        for j=1:col
            pic_final(i,j)=round(255*b(pic(i,j)+1));
        end
    end
    pic_final=uint8(pic_final);
end
