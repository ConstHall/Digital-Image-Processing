% 读取图像
image=imread('C:\Users\93508\Desktop\1.jpg');
image=im2double(image); %图像处理需要双精度
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
for x=1:P
    for y=1:Q
        image_fp(x,y)=image_fp(x,y).*(-1)^(x+y);
    end
end

% 对图像做二维傅里叶变换
image_F=fft2(image_fp);

% 生成理想低通滤波器H(u,v)
image_H=zeros(P,Q);
D0=60;
for x=1:P
    for y=1:Q
        D=sqrt((x-M)^2+(y-N)^2);
        if D>D0
            image_H(x,y)=0;
        else
            image_H(x,y)=1;
        end
    end
end
figure(2);
imshow(image_H);
title('理想低通滤波器');

% 阵列相乘得到乘积G(u,v)=H(u,v)*F(u,v)
image_G=image_H.*image_F;

% 求G的IDFT并取其实部，再乘以(-1)^(x+y),得到处理后的图像gp(x,y)
image_gp=real(ifft2(image_G));
for x=1:P
    for y=1:Q
        image_gp(x,y)=image_gp(x,y).*(-1)^(x+y);
    end
end

% 从gp(x,y)的左上象限提取M*N区域得到最终处理结果g(x,y)
image_g=image_gp(1:M,1:N);
figure(3);
imshow(image_g,[]);
title('最终结果');

% 画出傅里叶频谱图
R=real(image_F); %提取实部
I=imag(image_F); %提取虚部
image_F1=log(1+abs(image_F));
figure(4);
imshow(image_F1,[]);
title('傅里叶变换幅度谱');
figure(5);
image_F2=atan(I./R);
imshow(image_F2,[]);
title('傅里叶变换相位谱');