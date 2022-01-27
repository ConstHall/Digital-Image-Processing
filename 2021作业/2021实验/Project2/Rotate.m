image=imread('Fig4.04(a).jpg');
image=im2double(image);

%angle可设置为别的角度
angle=0;
image=imrotate(image,angle);
figure(1);
imshow(image);
title('旋转0度后的图像');

% 对图像进行扩充
[M,N]=size(image);
M=2*M;
N=2*N;
Image=zeros(M,N);
Image(1:M/2,1:N/2)=image(1:M/2,1:N/2);

% 将图像移动到变换中心
for x=1:M
    for y=1:N
        Image(x,y)=Image(x,y).*(-1)^(x+y);
    end
end
Image=Image(1:M/2,1:N/2);

%对图像进行傅里叶变换，计算出频谱图像
T=fft2(Image);

% 对图像取对数，增强效果
F=log(1+abs(T));

F=mat2gray(F);
figure(2);
imshow(F);
title('频谱图');
