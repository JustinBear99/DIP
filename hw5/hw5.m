function varargout = hw5(varargin)
% HW5 MATLAB code for hw5.fig
%      HW5, by itself, creates a new HW5 or raises the existing
%      singleton*.
%
%      H = HW5 returns the handle to a new HW5 or the handle to
%      the existing singleton*.
%
%      HW5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW5.M with the given input arguments.
%
%      HW5('Property','Value',...) creates a new HW5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw5

% Last Modified by GUIDE v2.5 19-Nov-2019 21:34:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw5_OpeningFcn, ...
                   'gui_OutputFcn',  @hw5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before hw5 is made visible.
function hw5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw5 (see VARARGIN)

% Choose default command line output for hw5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hw5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile({'*.bmp';'*.jpg'},'Select image','C:\Users\SSL108\Desktop\影像處理\hw5\Image Set 5 - Homework 5 - 2019');
if(filename ~=0)
    img=strcat(pathname, filename);
    fileID = fopen(img,'r');
    A = fscanf(fileID,'%s');
    fclose(fileID);
else
    return;
end
img = imread(img);
handles.img = img;
guidata(hObject,handles);
axes(handles.axes1)
imshow(img)
axes(handles.axes5)
imshow(rgb2gray(img))



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
index = get(handles.listbox1,'Value');
img = handles.img;
switch index
    case 1
        axes(handles.axes2)
        imshow(img(:,:,1))
        axes(handles.axes3)
        imshow(img(:,:,2))
        axes(handles.axes4)
        imshow(img(:,:,3))
        set(handles.text2,'String','R')
        set(handles.text3,'String','G')
        set(handles.text4,'String','B')
        axes(handles.axes10)
        imshow(img)
    case 2
        axes(handles.axes2)
        imshow(255-img(:,:,1))
        axes(handles.axes3)
        imshow(255-img(:,:,2))
        axes(handles.axes4)
        imshow(255-img(:,:,3))
        set(handles.text2,'String','C')
        set(handles.text3,'String','M')
        set(handles.text4,'String','Y')
        mixed = cat(3,255-img(:,:,1),255-img(:,:,2),255-img(:,:,3));
        axes(handles.axes10)
        imshow(mixed)
    case 3
        img3 = double(img)/255;
        R = img3(:,:,1); G = img3(:,:,2); B = img3(:,:,3);
        mini = min(img3,[],3);
        theta = acos(0.5*((R-G)+(R-B))./((R-G).^2+(R-B).*(G-B)).^0.5);
        H = zeros(size(img3,1),size(img3,2));
        for i=1:size(B,1)
            for j=1:size(B,2)
                if B(i,j)<=G(i,j)
                    H(i,j) = theta(i,j);
                else
                    H(i,j) = 360-theta(i,j);
                end
            end
        end
        S = 1-3./(R+G+B).*mini;
        I = (R+G+B)/3;
        
        axes(handles.axes2)
        imshow(H)
        axes(handles.axes3)
        imshow(S)
        axes(handles.axes4)
        imshow(I)
        set(handles.text2,'String','H')
        set(handles.text3,'String','S')
        set(handles.text4,'String','I')
        handles.intensity = uint8(I*255);
        guidata(hObject,handles);
        mixed = cat(3,H,S,I);
        axes(handles.axes10)
        imshow(uint8(mixed))
    case 4
        img4 = double(img)/255;
        R = img4(:,:,1); G = img4(:,:,2); B = img4(:,:,3);
        X = 0.415453*R + 0.357580*G + 0.180423*B;
        Y = 0.212671*R + 0.715160*G + 0.072169*B;
        Z = 0.019334*R + 0.119193*G + 0.950227*B;
        axes(handles.axes2)
        imshow(X)
        axes(handles.axes3)
        imshow(Y)
        axes(handles.axes4)
        imshow(Z)
        set(handles.text2,'String','X')
        set(handles.text3,'String','Y')
        set(handles.text4,'String','Z')
        mixed = cat(3,X,Y,Z);
        axes(handles.axes10)
        imshow(mixed)
    case 5
        img5 = double(img)/255;
        R = img5(:,:,1); G = img5(:,:,2); B = img5(:,:,3);
        [M, N] = size(R);
        X = (0.415453*R + 0.357580*G + 0.180423*B)*0.950456;
        Y = 0.212671*R + 0.715160*G + 0.072169*B;
        Z = (0.019334*R + 0.119193*G + 0.950227*B)*1.088754;
        T = 0.008856;
        XT = X > T;
        YT = Y > T;
        ZT = Z > T;
        Y3 = Y.^(1/3);
        fX = XT .* X.^(1/3) + (~XT) .* (7.787 .* X + 16/116);
        fY = YT .* Y3 + (~YT) .* (7.787 .* Y + 16/116);
        fZ = ZT .* Z.^(1/3) + (~ZT) .* (7.787 .* Z + 16/116);
        L = reshape(YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 * Y), M, N);
        a = reshape(500 * (fX - fY), M, N);
        b = reshape(200 * (fY - fZ), M, N);
        axes(handles.axes2)
        imshow(uint8(L))
        axes(handles.axes3)
        imshow(uint8(a))
        axes(handles.axes4)
        imshow(uint8(b))
        set(handles.text2,'String','L')
        set(handles.text3,'String','*a')
        set(handles.text4,'String','*b')
        handles.lab = uint8(L);
        guidata(hObject,handles);
        mixed = cat(3,L,a,b);
        axes(handles.axes10)
        imshow(uint8(mixed))
    case 6
        img6 = double(img);
        R = img6(:,:,1); G = img6(:,:,2); B = img6(:,:,3);
        Y =  0.257 * R + 0.504 * G + 0.098 * B +  16;
        U = -0.148 * R - 0.291 * G + 0.439 * B + 128;
        V =  0.439 * R - 0.368 * G - 0.071 * B + 128;
        axes(handles.axes2)
        imshow(uint8(Y))
        axes(handles.axes3)
        imshow(uint8(U))
        axes(handles.axes4)
        imshow(uint8(V))
        set(handles.text2,'String','Y')
        set(handles.text3,'String','U')
        set(handles.text4,'String','V')
        mixed = cat(3,Y,U,V);
        axes(handles.axes10)
        imshow(uint8(mixed))
       
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
img = handles.img;
if length(size(img)) == 3
    img = rgb2gray(img);
end
Maps = {parula;jet;hsv;hot;cool;spring;summer;autumn;winter;gray;bone;copper;pink;lines;colorcube;prism;flag;white};
index = get(handles.popupmenu1,'Value');

if index < 19
    map = cell2mat(Maps(index));
else
    first_color = uisetcolor('Choose your first color');
    last_color = uisetcolor('Choose your last color');
    d = (last_color - first_color)/256;
    map = zeros(256,3);
    map(1,:) = first_color;
    map(256,:) = last_color;
    for i = 2:255
        map(i,:) = first_color + d*(i-1);
    end
end
Red = map(:,1);
Green = map(:,2);
Blue = map(:,3);
colorbars = zeros(256,30,3);
for i =1:30
    colorbars(:,i,1) = Red;
    colorbars(:,i,2) = Green;
    colorbars(:,i,3) = Blue;
end
colorbars2 = zeros(90,256);
for i =1:30
    colorbars2(i,:) = Red';
    colorbars2(i+30,:) = Green';
    colorbars2(i+60,:) = Blue';
end
new_img = zeros(size(img,1),size(img,2),3);
new_img(:,:,1) = Red(img(:,:)+1);
new_img(:,:,2) = Green(img(:,:)+1);
new_img(:,:,3) = Blue(img(:,:)+1);

axes(handles.axes6)
imshow(new_img)
axes(handles.axes7)
imshow(colorbars)
axes(handles.axes8)
imshow(colorbars2)

    


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
k = double(get(handles.edit1,'String'));
img = handles.img;
I = handles.intensity;
lab = handles.lab;
type = handles.kmeans;
if type == 1
    [L, centers] = imsegkmeans(img,k);
elseif type == 2
    [L, centers] = imsegkmeans(I,k);
elseif type == 3
    [L, centers] = imsegkmeans(lab,k);
end
B = labeloverlay(img,L);
axes(handles.axes9)
imshow(B)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
index = get(handles.listbox2,'Value');
handles.kmeans = index;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes9)
imsave
