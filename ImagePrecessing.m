
function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 13-Oct-2018 16:13:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;
%global cm
%cm = 6;
global centercol
global centerrow
centercol = 1004;%round(406*2.43);%1004   
centerrow = 793; %round(355*2.43);793;

% Update handles structure
guidata(hObject, handles);
set(hObject, 'toolbar','figure');
ha=axes('units','normalized','pos',[0 0 1 1]);
 uistack(ha,'down');
 ii=imread('img1.jpg');
%设置程序的背景图为img1.jpg
 image(ii);
 colormap gray
 set(ha,'handlevisibility','off','visible','off');

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%'选择图片'按钮回调函数
function pushbutton1_Callback(hObject, eventdata, handles)
axis off  %%关闭坐标轴显示  
%[filename pathname] =uigetfile({'*.bmp';'*.jpg';'*.png';'*.*'},'打开图片');
[filename pathname] =uigetfile({'*.*'},'打开图片');
global str
str=[pathname filename];  
%%打开图像

set(handles.edit4,'String',filename);
im1 = imread(str); 
%im1 = im1(119:1418,374:1673);
%%打开axes1的句柄 进行axes1的操作
axes(handles.axes1);  
%%在axes1中显示图像  
imshow(im1); 
global im3
im3 = imread(str);
%im3 = im3(119:1418,374:1673);
% im3 = rgb2gray(im3);
axes(handles.axes3);
imshow(im3);


% ‘锐化’按钮回调
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = inputdlg ({'半径','数量'},'锐化',1);
a = str2num(answer{1});
b = str2num(answer{2});
global im2
global im3
im2 = imsharpen (im3, 'Radius',a,'Amount', b);

axes(handles.axes2);
imshow(im2);



%‘保存’按钮回调
function pushbutton5_Callback(hObject, eventdata, handles)
%global cm
%cm = cm-1;
%cd('C:\Users\hou\Desktop');
%filename = strcat('山大尚光队',num2str(cm),'cm','处理后');
 [FileName, PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';...
                                   '*.bmp','Bitmap(*.bmp)';...
                                   '*.*', 'All Files(*.*)'},...
                                   'Save Picture', 'Untitled');
  global im3
 if FileName == 0
     return;
 else
 %    h = getframe(handles.axes3);
     imwrite(im3,[PathName,FileName]);
 end
 
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ‘对比度调节’回调
function slider1_Callback(hObject, eventdata, handles)
global im3

sliderValue = get(hObject,'Value');
global im2
im2 = imadjust(im3,[0.3,0.7],[0,min(sliderValue,1)]);
axes(handles.axes2); 
imshow(im2);


% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%set(handles.slider1,'Min',0.4);
% Hint: slider controls usually have a light gray background.
%set(hObject,'Min',0.4);
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% ‘亮度调节’回调
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global im3
sliderValue = get(hObject,'Value');
global im2
im2 = (0.6+sliderValue)*im3;
axes(handles.axes2);
imshow(im2);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject,'Value',0.4);
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% ‘重置’按钮回调
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2,'reset');
global im3
global str
im3 = imread(str);
%im3 = im3(119:1418,374:1673);
axes(handles.axes3);
imshow(im3);



% ‘确认’按钮回调
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3
global im2
im3 = im2;
axes(handles.axes3);
imshow(im3);


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function text11_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all 
close



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imaqtool


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
global im3
im2 = rgb2gray(im3);
axes(handles.axes2);
imshow(im2);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
global im3
[row,col] = size(im3);
PMF = zeros(1,256);
for i = 1:row
    for j = 1:col
        PMF(im3(i,j) + 1) = PMF(im3(i,j) + 1) + 1;
    end
end
CDF = zeros(1,256);
CDF(1) = PMF(1);
for i = 2:256
    CDF(i) = CDF(i - 1) + PMF(i);
end
for i = 1:256
    Map(i) = round((CDF(i)-1)*255/(row*col));
end
for i = 1:row
    for j = 1:col
        im3(i,j) = Map(im3(i,j) + 1);
    end
end
im2 = im3;
axes(handles.axes2);
imshow(im2);
