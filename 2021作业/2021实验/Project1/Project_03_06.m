%读取原图并画出原图
pic=imread('C:\Users\93508\Desktop\43.jpg'); %读取原图
figure(1);
imshow(pic); %画出原图
title('原图'); 

%扩展矩阵，做好卷积准备
mask=1/9*[1 1 1;1 1 1;1 1 1]; %平滑(均值)滤波器掩膜
[row,col]=size(pic);
dx=zeros(2,col+4);
dy=zeros(row,1);
pic_final=[dx;dy dy pic dy dy;dx]; %这里滤波器模板是3*3，所以原图矩阵扩展为[row+2,col+2]
[row_final,col_final]=size(pic_final);
lap=uint8(zeros(row_final,col_final)); %整数只能与同类的整数或双精度标量值组合使用，不加此行则后续lap无法与pic(uint8型)相加

%拉普拉斯算子的图像锐化
for i=3:row_final-2
    for j=3:col_final-2
        for s=1:3
            for t=1:3
                lap(i,j)=lap(i,j)+pic_final(i-2+s,j-2+t)*mask(s,t); %与Project 03-05的思路一致
            end
        end
    end
end

%原图的非锐化隐蔽和高升压滤波
lap=lap(3:row_final-2,3:col_final-2); %将扩展图片的矩阵裁剪为原图大小
A=1.7;
hb=A*pic+lap; %应用第2版书P105 3.7.11的公式（该公式等效于题目中要求的3.7.8）
figure(2);
imshow(hb);
title('高提升滤波处理后的图片'); 

