smoothing1 = [1 1 1;1 1 1;1 1 1]/9;
smoothing2 = [1 2 1;2 4 2;1 2 1]/16;
gaussian = [0.3679 0.6065 0.3679;0.6065 1 0.6065;0.3679 0.6065 0.3679]/4.8976;
sharpening1 = [0 1 0;1 -4 1;0 1 0];
sharpening2 = [1 1 1;1 -8 1;1 1 1];
sharpening3 = sharpening1*-1;
sharpening4 = sharpening2*-1;
sharpening5 = sharpening3 + [0 0 0;0 1 0;0 0 0];
sharpening6 = sharpening4 + [0 0 0;0 1 0;0 0 0];

img = imread('Image 3-1.JPG');
new_img = filtering(img,gaussian,3);
subplot(121)
imshow(img)
subplot(122)
imshow(new_img)

function new_img = filtering(img,mask,padding)
img = double(img);
imgsize = size(img);
dim = 0;
if length(imgsize) == 2
    img(:,:,2) = zeros(imgsize);
    img(:,:,3) = zeros(imgsize);
    dim = 1;
end
if padding == 1
    img = [zeros(imgsize(1),1,3) img zeros(imgsize(1),1,3)];
    img = [zeros(1,imgsize(2)+2,3); img; zeros(1,imgsize(2)+2,3)];
elseif padding == 2
    img = [img(:,2,:) img img(:,imgsize(2)-1,:)];
    img = [img(2,:,:); img; img(imgsize(1)-1,:,:)];
    img(1,1,:) = img(3,3,:);
    img(1,imgsize(2),:) = img(3,imgsize(2)-2,:);
    img(imgsize(1),1,:) = img(imgsize(1)-2,3,:);
    img(imgsize(1),imgsize(2),:) = img(imgsize(1)-2,imgsize(2)-2,:);
elseif padding == 3
    img = [img(:,1,:) img img(:,imgsize(2),:)];
    img = [img(1,:,:); img; img(imgsize(1),:,:)];
    img(1,1,:) = img(2,2,:);
    img(1,imgsize(2),:) = img(2,imgsize(2)-1,:);
    img(imgsize(1),1,:) = img(imgsize(1)-1,2,:);
    img(imgsize(1),imgsize(2),:) = img(imgsize(1)-1,imgsize(2)-1,:);
end
new_img = zeros(imgsize);
new_imgsize = size(new_img);
for i=1:new_imgsize(1)
    for j=1:new_imgsize(2)
        for k=1:3
            new_img(i,j,k) = mask(1)*img(i,j,k)   + mask(4)*img(i,j+1,k)   + mask(7)*img(i,j+2,k) ...
                           + mask(2)*img(i+1,j,k) + mask(5)*img(i+1,j+1,k) + mask(8)*img(i+1,j+2,k) ...
                           + mask(3)*img(i+2,j,k) + mask(6)*img(i+2,j+1,k) + mask(9)*img(i+2,j+2,k);
        end
    end
end
if dim == 1
    new_img(:,:,2:3) = [];
end
new_img = uint8(new_img);
end


