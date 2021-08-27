function varargout = HW6(varargin)
% HW6 MATLAB code for HW6.fig
%      HW6, by itself, creates a new HW6 or raises the existing
%      singleton*.
%
%      H = HW6 returns the handle to a new HW6 or the handle to
%      the existing singleton*.
%
%      HW6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW6.M with the given input arguments.
%
%      HW6('Property','Value',...) creates a new HW6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HW6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HW6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HW6

% Last Modified by GUIDE v2.5 29-Nov-2019 11:15:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HW6_OpeningFcn, ...
                   'gui_OutputFcn',  @HW6_OutputFcn, ...
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


% --- Executes just before HW6 is made visible.
function HW6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HW6 (see VARARGIN)

% Choose default command line output for HW6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HW6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HW6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global img;
[name,path]=uigetfile({'*.*'},'Select Image Data');
fullname=[path name];
img=imread(fullname);
imshow(img,'Parent',handles.axes1);

function gray=imgtogray(img)
[height,width,n]=size(img);
gray=zeros(height,width);
for i=1:height
    for j=1:width
            gray(i,j)=sum(img(i,j,:))/3;
    end
end

function T_img=Trapezoidal(img)
[ws,hs,n]=size(img);
T_img=zeros(ws,hs);
w=ws/2;h=hs/2;
a=3/4;b=1/2;
for i=1:ws
    for j=1:hs
        x=fix(i*a);
        y=fix((hs-i*b)/hs*(j-w)+w);
        if x>0 & y>0 & x<=ws & y<=hs
        T_img(x,y)=img(i,j);
        end
    end
end



function W_img=Wavy(img)
img=imgtogray(img);
[h,w,n]=size(img);
W_img=zeros(h,w);
for x=1:h    % let N1 = S1 and N2= S2 for this example WAVE1
  for y=1:w 
     % s1- compute back coordinates in the original image domain
     % [n m] = invT(x,y);
     m = y- 40*sin(2*pi*x/128);%y
     n = x - 40*sin(2*pi*y/128);
     % s2-s3 Apply (bilinear) interpolation to find the image intensity, if 
     % n,m does not fall into integer indices
     d1 = n - floor(n);
     d2 = m - floor(m);
     % s3- define the image pixel 
    if ( ((n>=1)&(n<h)) & ((m>=1)&(m<w)) ) 
     W_img(x,y) = (1-d1)*(1-d2) * img(floor(n),floor(m)) +(1-d1)*d2 * img(floor(n),floor(m)+1) +d1*(1-d2) * img(floor(n)+1,floor(m)) +d1*d2 * img(floor(n)+1,floor(m)+1) ;
    end%if
  end
end

function C_img=Circular(img)
[ws,hs,n]=size(img);
C_img=zeros(ws,hs);
w=ws/2;h=hs/2;
for i=1:ws
    for j=1:hs
        D=((h^2)-((h-i)^2))^0.5;
        if D==0
            D=1;
        end
        x=fix((j-w)*D/w+w);
        y=i;
        C_img(y,x)=img(i,j);
    end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
A= get(handles.listbox1,'value');
global img;
switch A
case 1
    T_img=Trapezoidal(img);
    imshow(uint8(T_img),'Parent',handles.axes2);
case 2
    W_img=Wavy(img);
    imshow(uint8(W_img),'Parent',handles.axes2);
case 3
    C_img=Circular(img);
    imshow(uint8(C_img),'Parent',handles.axes2);
end
