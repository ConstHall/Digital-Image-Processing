%读入原图像
img = imread('Fig4.11(a).jpg');
img = im2double(img);
figure(1);
imshow(img);
title('原图像');

% 扩充原图像
[M, N] = size(img);
P = 2 * M;
Q = 2 * N;
img_fp = zeros(P, Q);
img_fp(1:M, 1:N) = img(1:M, 1:N);

% 计算滤波函数;
alf = 80;
H = zeros(P, Q);
for i = 1:P
    for j = 1:Q
        H(i, j) = exp(-((i-P/2)^2 + (j-Q/2)^2) / (2 * alf^2));
    end
end

figure(2);
imshow(H);
title('滤波函数');

%将f移到变换重心
img_f = zeros(P, Q);
for x = 1:P
    for y = 1:Q
        img_f(x, y) = img_fp(x, y) .* (-1)^(x+y);
    end
end

%计算图像的傅里叶变换
img_F = fft2(img_f);

%用阵列相乘得到img_G，再用傅里叶反变换得到img_g
img_G = img_F .* H;
img_g = real(ifft2(img_G));

%将f变换回左上角，得到处理后的图像
for x = 1:P
    for y = 1:Q
        img_g(x, y) = img_g(x, y) .* (-1)^(x+y);
    end
end

%截取左上角部分，得到高斯低通滤波图像
img_o = img_g(1:M, 1:N);

%用原图像减去高斯低通滤波图像，得到高斯高通滤波图像
img_4=img-img_o;
figure(3);
imshow(img_4);
title('高斯高通滤波后的图像')

