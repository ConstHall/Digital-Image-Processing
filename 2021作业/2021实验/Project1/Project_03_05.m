A=imread('pic2.tif');   %读入图片
[m,n]=size(A);  %获取图片大小
lap_fil=[-1,-1,-1;-1,8,-1;-1,-1,-1];    %滤波器模板
B=zeros(m+4,n+4);   %在矩阵周围补0
for i=1:m
    for j=1:n
        B(i+2,j+2)=A(i,j);
    end
end

res=zeros(m+4,n+4); %进行滤波运算
for i=2:m+3
    for j=2:n+3
        for x=-1:1
            for y=-1:1
                res(i,j)=res(i,j)+B(i+x,j+y)*lap_fil(2+x,2+y);
            end
        end
    end
end

C=zeros(m,n);   %将原图像和拉普拉斯图像叠加
for i=1:m
    for j=1:n
        C(i,j)=A(i,j)+res(i+2,j+2);
    end
end

imshow(C,[0,255]);  %生成新的图像
