img=imread('C1HW04_IMG01_2019.jpg');
imgsize = size(img);
img = double(img);
padded_img = [img zeros(imgsize(1),imgsize(2));zeros(imgsize(1),imgsize(2)*2)];
padded_imgsize = size(padded_img);
for i =1:padded_imgsize(1)
    for j =1:padded_imgsize(2)
        padded_img(i,j) = padded_img(i,j)*(-1)^(i+j);
    end
end
imshow(log(1+abs(fftshift(fft2(padded_img)))),[],'InitialMagnification','fit')        





%%
img=imread('C1HW04_IMG01_2019.jpg');
img=double(img);
fft_img = fft2(img);
fmin=log(1+abs(min(min(fft_img))));
fmax=log(1+abs(max(max(fft_img))));
Ynew=255*(log(1+abs(fftshift(fft_img)))-fmin)./(fmax-fmin);
%Ynew=uint8(Ynew);
magnitude = log(abs(fftshift(fft_img))+1);
phase = angle(fft_img);

subplot(121); imshow(magnitude,[]) ; subplot(122); imshow(Ynew,[]);


%%

H=lowpass('Gaussian',100,100,5,2);

function filter = lowpass(type,M,N,D0,n)
[U,V] = dftuv(M,N);
D = sqrt(U.^2+V.^2);
switch type
    case 'Ideal'
        filter = double(D <= D0);
    case 'Butterworth'
        filter = 1./(1+(D./D0).^(2*n));
    case 'Gaussian'
        filter = exp((-1.*D.^2)./(2*(D0^2)));
end
end


function [U,V] = dftuv(M,N)
u = 0:M-1;
v = 0:N-1;

idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;

[V, U] = meshgrid(v, u);
end

