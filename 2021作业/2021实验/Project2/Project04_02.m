% 读取图像并计算图像的平均值
image=imread('C:\Users\93508\Desktop\2.jpg');
avg=mean2(image);
disp(['图像的平均值为',num2str(avg)]);

%图像处理需要双精度
image=im2double(image); 
figure(1);
imshow(image,[]);
title('初始图像');

% 扩充原图矩阵得到fp(x,y)
[M,N]=size(image);
P=2*M;
Q=2*N;
image_fp=zeros(P,Q);
image_fp(1:M,1:N)=image(1:M,1:N);

% 用(-1)^(x+y)乘以fp(x,y)，将其移动到变换中心
for i=1:P
    for j=1:Q
        image_fp(i,j)=image_fp(i,j)*(-1)^(i+j); %平移函数，移到其变换的中心
    end
end

% 对图像做二维傅里叶变换
image_F=fft2(image_fp);

% 画出傅里叶频谱图
X=real(image_F); %提取实部
Y=imag(image_F); %提取虚部
image_F1=log(1+abs(image_F));
figure(2);
imshow(image_F1,[]);
title('傅里叶变换幅度谱');
figure(3);
image_F2=atan(Y./X);
imshow(image_F2,[]);
title('傅里叶变换相位谱');
