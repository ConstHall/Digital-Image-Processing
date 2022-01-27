image = imread('C:\Users\93508\Desktop\3.png');% 读入图片
[row,col,rgb] = size(image);%记录图片尺寸大小(忽略亮度信息rgb)
%展示原图
figure(1)
imshow(image);
title('原图');

%将图像从RGB格式转为YCbCr格式
YCbCr = rgb2ycbcr(image);
%提取图片的YCbCr分量：Y亮度分量，Cb蓝色分量，Cr红色分量
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);
image_gray = zeros(row,col);

%查阅资料可知，肤色点的Y值范围为(87,230)，Cb值范围为(77,127)，Cr值范围为(133,173)
for i = 1:row
    for j = 1:col
        if(Y(i,j) > 87 && Y(i,j) < 230 && Cb(i,j) > 77 && Cb(i,j) < 127 && Cr(i,j) > 133 && Cr(i,j) < 173)
            image_gray(i,j) = 255;
            %若为肤色点，则将其像素值置为255（白色）
        else
            image_gray(i,j) = 0;
            %若不是肤色点，则将其像素值置为0（黑色）
        end
    end
end
%展示肤色覆盖范围（白色表示肤色，黑色表示背景）
figure(2)
imshow(image_gray);
title('肤色覆盖范围黑白图');

%开运算：先腐蚀后膨胀
%开运算用来消除小物体、在纤细点处分离物体、平滑较大物体的边界的同时并不明显改变其面积
%图像腐蚀
SE = strel('disk',10);
image_erode = imerode(image_gray,SE);
figure(3)
imshow(image_erode);
title('图像腐蚀');
%图像膨胀
image_dilate=imdilate(image_erode,SE); 
figure(4)
imshow(image_dilate);
title('图像膨胀');

%确定人脸边界
x_min = 10000;
x_max = 0;
y_min = 10000;
y_max = 0;
%找到横向的肤色边界值x_min和x_max
for i = 1:row
    for j = 1:col
        if(image_dilate(i,j) == 255 && j < x_min)
            x_min = j;
        end
        if(image_dilate(i,j) == 255 && j > x_max)
            x_max = j;
        end
    end
end
%找到纵向向的肤色边界值y_min和y_max
for i = 1:row
    for j = 1:col
        if(image_dilate(i,j) == 255 && i < y_min)
            y_min = i;
        end
        if(image_dilate(i,j) == 255 && i > y_max)
            y_max = i;
        end
    end
end

%根据刚才确定的边界，对原图进行画框，标出人脸所在范围，框线颜色为红色(R:240,G:65,B:85)
image(y_min:y_max,x_min,1)=uint8(240);
image(y_min:y_max,x_min,2)=uint8(65);
image(y_min:y_max,x_min,3)=uint8(85);

image(y_min:y_max,x_max,1)=uint8(240);
image(y_min:y_max,x_max,2)=uint8(65);
image(y_min:y_max,x_max,3)=uint8(85);

image(y_min,x_min:x_max,1)=uint8(240);
image(y_min,x_min:x_max,2)=uint8(65);
image(y_min,x_min:x_max,3)=uint8(85);

image(y_max,x_min:x_max,1)=uint8(240);
image(y_max,x_min:x_max,2)=uint8(65);
image(y_max,x_min:x_max,3)=uint8(85);

%画图
figure(5)
imshow(image);
title('人脸识别区域');