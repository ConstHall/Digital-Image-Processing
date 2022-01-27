% 读入原图像
imga = imread('Fig4.41(a).jpg');
imga = im2double(imga);
figure(1);
imshow(imga);
title('原图像');
% 读入模板图像
imgb = imread('Fig4.41(b).jpg');
imgb = im2double(imgb);
figure(2);
imshow(imgb);
title('模板图像');

[A,B]=size(imga);
[C,D]=size(imgb);

% 扩充图像，取P>=A+C,Q>+B+D，选择298*298的相等延拓尺度
P=298;
Q=298;

f=zeros(P,Q);
g=zeros(P,Q);

f(1:A,1:B)=imga(1:A,1:B);
figure(3);
imshow(f);
title('延拓原图像');

g(1:C,1:D)=imgb(1:C,1:D);
figure(4);
imshow(g);
title('延拓模板图像');

for x=1:P
    for y=1:Q
        f(x,y)=f(x,y).*(-1)^(x+y);
        g(x,y)=g(x,y).*(-1)^(x+y);
    end
end

% 利用相关理论对图像进行图像相关处理
F=fft2(f);
G=fft2(g);

Img=F.*conj(G);

img=ifft2(Img);

for x=1:P
    for y=1:Q
        img(x,y)=img(x,y).*(-1)^(x+y);
    end
end

img=real(img);
img = mat2gray(img);
figure(5);
imshow(img);
title('图像相关结果');

% 寻找最大值及最大值坐标
max_value = max(max(img));
[row,col] = find(img == max_value);

disp(['row: ', num2str(row), ' col: ', num2str(col)]);
