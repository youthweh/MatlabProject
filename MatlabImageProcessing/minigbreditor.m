function varargout = minigbreditor(varargin)
% MINIGBREDITOR MATLAB code for minigbreditor.fig
%      MINIGBREDITOR, by itself, creates a new MINIGBREDITOR or raises the existing
%      singleton*.
%
%      H = MINIGBREDITOR returns the handle to a new MINIGBREDITOR or the handle to
%      the existing singleton*.
%
%      MINIGBREDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MINIGBREDITOR.M with the given input arguments.
%
%      MINIGBREDITOR('Property','Value',...) creates a new MINIGBREDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before minigbreditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to minigbreditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help minigbreditor

% Last Modified by GUIDE v2.5 26-Jul-2019 23:58:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @minigbreditor_OpeningFcn, ...
                   'gui_OutputFcn',  @minigbreditor_OutputFcn, ...
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


% --- Executes just before minigbreditor is made visible.
function minigbreditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to minigbreditor (see VARARGIN)

% Choose default command line output for minigbreditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes minigbreditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = minigbreditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bukagambar_Callback(hObject, eventdata, handles)
% hObject    handle to bukagambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama,alamat] = uigetfile({'*.jpg','File JPG(*.jpg)';
    '*.bmp','File Bitmap(*.bmp)';
    '*.jpeg','File JPEG(*.jpeg)';
    '*.*','Semua File'}, 'Buka File Citra Asli');
img = imread([alamat,nama]);
info = imfinfo(fullfile(alamat,nama));
handles.image = img;
guidata(hObject, handles);
axes(handles.axes1);
imshow(img);
axes(handles.axes2);
imshow(img);

%muncul tipe warna gambar
set(handles.tipewarna,'String',info.ColorType);
%cek tipe warna gambar
ColorType =  get(handles.tipewarna,'String');

set(handles.namafile,'String',nama);
set(handles.ukuran,'String',info.FileSize);
set(handles.lebar,'String',info.Width);
set(handles.tinggi,'String',info.Height);

if (ColorType == 'grayscale')
        axes(handles.axes3)
        imhist(img);
        title('Histogram Gambar BW');
        set(handles.text5,'Visible','off');
        
        axes(handles.axes4)
        imhist(img);
        set(handles.text6,'Visible','off');
        
        axes(handles.axes5)
        imhist(img);
        set(handles.text7,'Visible','off');
        
        axes(handles.axes6)
        imhist(img);
else
    if (ColorType == 'truecolor')
        set(handles.text5,'Visible','on');
        set(handles.text6,'Visible','on');
        set(handles.text7,'Visible','on');
        input=rgb2gray(img);
        axes(handles.axes3)
        imhist(input), title ('histogram Gambar Berwarna');
        
        %histogram red
        axes(handles.axes4);
        imhist(img(:,:,1));
        %histogram green
        axes(handles.axes5);
        imhist(img(:,:,2));
        %histogram blue
        axes(handles.axes6);
        imhist(img(:,:,3));
    end
end

    
% axes(handles.axes3);
% imhist(img), title('Histogram Gambar BW ');
    
        
%histogram untuk gambar berwarna 
% input=rgb2gray(img);
% axes(handles.axes3)
% imhist(input), title ('histogram Gambar Berwarna');


global a
a = imread([alamat,nama]);



% --- Executes on slider movement.
function slider_cerah_Callback(hObject, eventdata, handles)
% hObject    handle to slider_cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
valueK = get(handles.slider_kontras,'Value');
value = get(handles.slider_cerah,'Value');
set(handles.txt_cerah,'String',value);
citra = handles.image;
kontras = valueK*(citra+value);
cerah = kontras + value;
handles.hasil = cerah;
guidata(hObject,handles);
imshow(cerah,'Parent',handles.axes2);



% --------------------------------------------------------------------
function simpangambar_Callback(hObject, eventdata, handles)
% hObject    handle to simpangambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[nama,alamat] = uiputfile({'*.jpg','File JPG(*.jpg)';
    '*.bmp','File Bitmap(*.bmp)';
    '*.jpeg','File JPEG(*.jpeg)';
    '*.*','Semua File'}, 'Simpan File Citra Asli');

imwrite(handles.hasil,fullfile(alamat,nama),'JPG')


% --- Executes during object creation, after setting all properties.
function slider_cerah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_kontras_Callback(hObject, eventdata, handles)
% hObject    handle to slider_kontras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
valueKontras = get(handles.slider_kontras,'Value');
valueCerah = get(handles.slider_cerah,'Value');
guidata(hObject,handles);
set(handles.txt_kontras,'String',valueKontras);
citra = handles.image;
cerah = citra + valueCerah;
kontras = valueKontras * cerah;
handles.hasil = kontras;
guidata(hObject,handles);
imshow(kontras,'Parent',handles.axes2);





% --- Executes during object creation, after setting all properties.
function slider_kontras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_kontras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function txt_cerah_Callback(hObject, eventdata, handles)
% hObject    handle to txt_cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_cerah as text
%        str2double(get(hObject,'String')) returns contents of txt_cerah as a double


% --- Executes during object creation, after setting all properties.
function txt_cerah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_kontras_Callback(hObject, eventdata, handles)
% hObject    handle to txt_kontras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_kontras as text
%        str2double(get(hObject,'String')) returns contents of txt_kontras as a double


% --- Executes during object creation, after setting all properties.
function txt_kontras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_kontras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
citra = handles.image;
axes(handles.axes2);
imshow(citra);


% --- Executes on button press in red_btn.
function red_btn_Callback(hObject, eventdata, handles)
% hObject    handle to red_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%dapat histogram dari red color
global a
r = a(:,:,1);
red_hist = imshist(r);
axes(handles.axes4);
plot(red_hist,'red');



% --- Executes on button press in blue_btn.
function blue_btn_Callback(hObject, eventdata, handles)
% hObject    handle to blue_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in green_btn.
function green_btn_Callback(hObject, eventdata, handles)
% hObject    handle to green_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function tipewarna_Callback(hObject, eventdata, handles)
% hObject    handle to tipewarna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tipewarna as text
%        str2double(get(hObject,'String')) returns contents of tipewarna as a double


% --- Executes during object creation, after setting all properties.
function tipewarna_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tipewarna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaussian1_btn.
function gaussian1_btn_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian1_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
gaussianFilter=fspecial('gaussian',[7,7], 5);
gaussianImple = imfilter(im,gaussianFilter,'symmetric','conv');
handles.hasil = gaussianImple;
guidata(hObject,handles);
axes(handles.axes2);
image(gaussianImple), title('Blurred Image, blur mix matrix size 7');
global gaussian1
gaussian1 = gaussianFilter;


% --- Executes on button press in gaussian2_btn.
function gaussian2_btn_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian2_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
global gaussian1
gaussianFilter2=filter2(gaussian1,im(:,:,1));
handles.hasil = uint8(gaussianFilter2);
guidata(hObject,handles);
axes(handles.axes2);
imshow(uint8(gaussianFilter2)), title('Blurred Image, blur mix matrix size 7');


% --- Executes on button press in edges1_btn.
function edges1_btn_Callback(hObject, eventdata, handles)
% hObject    handle to edges1_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
global a
im=a;
smallIm=im(1:4:size(im,1), 1:4:size(im,2), :);
handles.hasil = smallIm;
guidata(hObject,handles);
axes(handles.axes2); image(smallIm);
edges = [];
edges(:,:,1) = edge(smallIm(:,:,1), 'sobel');
edges(:,:,2) = edge(smallIm(:,:,2), 'sobel');
edges(:,:,3) = edge(smallIm(:,:,3), 'sobel');
axes(handles.axes7); imshow(edges(:,:,1)), title('Edges Channel R');
axes(handles.axes8); imshow(edges(:,:,2)), title('Edges Channel G');
axes(handles.axes9); imshow(edges(:,:,3)), title('Edges Channel B');


% --- Executes on button press in edges2_btn.
function edges2_btn_Callback(hObject, eventdata, handles)
% hObject    handle to edges2_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a
im=a;
smallIm=im(1:4:size(im,1), 1:4:size(im,2), :);
axes(handles.axes2); image(smallIm);
edges = [];
edges(:,:,1) = edge(smallIm(:,:,1), 'sobel');
edges(:,:,2) = edge(smallIm(:,:,2), 'sobel');
edges(:,:,3) = edge(smallIm(:,:,3), 'sobel');
handles.hasil = edges;
guidata(hObject,handles);
axes(handles.axes2); image(edges), title('Edges RGB');
edgesAll = edges(:,:,1) + edges(:,:,2) + edges(:,:,3);
axes(handles.axes10); imshow(edgesAll), title('Combined edges');

% --- Executes on button press in addnoise.
function addnoise_Callback(hObject, eventdata, handles)
% hObject    handle to addnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
J = imnoise(im,'salt & pepper',0.2);
handles.hasil = J;
guidata(hObject,handles);
axes(handles.axes2); imshow(J);
global gambarnoise
gambarnoise = J;


% --- Executes on button press in rmv_noise.
function rmv_noise_Callback(hObject, eventdata, handles)
% hObject    handle to rmv_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%filter each channel separately
global gambarnoise
r = medfilt2(gambarnoise(:,:,1),[3 3]);
g = medfilt2(gambarnoise(:,:,2),[3 3]);
b = medfilt2(gambarnoise(:,:,3),[3 3]);
K = cat(3,r,g,b);
handles.hasil = K;
guidata(hObject,handles);
axes(handles.axes2);
imshow(K);


% --- Executes on button press in imgadd_btn.
function imgadd_btn_Callback(hObject, eventdata, handles)
% hObject    handle to imgadd_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
im2=imadd(im,50);
handles.hasil = im2;
guidata(hObject,handles);
axes(handles.axes2); imshow(im2);


% --- Executes on button press in imgmultiply_btn.
function imgmultiply_btn_Callback(hObject, eventdata, handles)
% hObject    handle to imgmultiply_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
j=2*im;
handles.hasil = j;
guidata(hObject,handles);
axes(handles.axes2);imshow(j);


% --- Executes on button press in subtract_btn.
function subtract_btn_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
Iq=imsubtract(im,50);
handles.hasil = Iq;
guidata(hObject,handles);
axes(handles.axes2);imshow(Iq);


% --- Executes on button press in divide_btn.
function divide_btn_Callback(hObject, eventdata, handles)
% hObject    handle to divide_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
im=a;
background=imopen(im,strel('disk',15));
Ip=imdivide(im,background);
handles.hasil = Ip;
guidata(hObject,handles);
axes(handles.axes2);imshow(Ip,[]);



% --- Executes on button press in opening_btn.
function opening_btn_Callback(hObject, eventdata, handles)
% hObject    handle to opening_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbropeningclosing
img=gbropeningclosing;
SE = strel('rectangle',[40 30]);
BW2 = imerode(img,SE);
axes(handles.axes7);imshow(BW2),title('Gambar Hasil Erosi');
BW3 = imdilate(BW2,SE);
axes(handles.axes8);imshow(BW3),title('Gambar Hasil Dilasi');
L = bwlabel(BW3);
RGB = label2rgb(L,'spring','c','shuffle');
axes(handles.axes12); imshow(RGB), title('hasil');
handles.hasil = RGB;
guidata(hObject,handles);
axes(handles.axes2); imshow(RGB), title('hasil');
axes(handles.axes1); imshow(img);


% --- Executes on button press in bukabgr_btn.
function bukabgr_btn_Callback(hObject, eventdata, handles)
% hObject    handle to bukabgr_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama,alamat] = uigetfile({'*.tif','*.png';
    '*.*','Semua File'}, 'Buka File Citra Asli');
img = imread([alamat,nama]);
info = imfinfo(fullfile(alamat,nama));
handles.image = img;
guidata(hObject, handles);
axes(handles.axes11);
imshow(img);
global gbropeningclosing
gbropeningclosing = img;


% --- Executes on button press in closing_btn.
function closing_btn_Callback(hObject, eventdata, handles)
% hObject    handle to closing_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbropeningclosing
img=gbropeningclosing;
se = strel('diamond',6);
Im_Close = imclose(img,se);
axes(handles.axes1);imshow(img),title('Citra Hasil Closing');
handles.hasil = Im_Close;
guidata(hObject,handles);
axes(handles.axes2);imshow(Im_Close),title('Citra Hasil Closing');
axes(handles.axes12);imshow(Im_Close);

se = strel('octagon',6);
Im_Close2 = imclose(img,se);
axes(handles.axes7);imshow(Im_Close2),title('Closing SE Diamond');

se = strel('disk',6);
Im_Close3 = imclose(img,se);
axes(handles.axes8);imshow(Im_Close3),title('Closing SE Disk');

se = strel('square',6);
Im_Close4 = imclose(img,se);
axes(handles.axes9);imshow(Im_Close4),title('Closing SE Square');

se = strel('disk',12);
Im_Close5 = imtophat(img,se);
axes(handles.axes10);imshow(Im_Close5),title('ClosingTopHat SE Disk');

function ukuran_Callback(hObject, eventdata, handles)
% hObject    handle to ukuran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ukuran as text
%        str2double(get(hObject,'String')) returns contents of ukuran as a double


% --- Executes during object creation, after setting all properties.
function ukuran_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ukuran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lebar_Callback(hObject, eventdata, handles)
% hObject    handle to lebar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lebar as text
%        str2double(get(hObject,'String')) returns contents of lebar as a double


% --- Executes during object creation, after setting all properties.
function lebar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lebar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tinggi_Callback(hObject, eventdata, handles)
% hObject    handle to tinggi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tinggi as text
%        str2double(get(hObject,'String')) returns contents of tinggi as a double


% --- Executes during object creation, after setting all properties.
function tinggi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tinggi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function namafile_Callback(hObject, eventdata, handles)
% hObject    handle to namafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of namafile as text
%        str2double(get(hObject,'String')) returns contents of namafile as a double


% --- Executes during object creation, after setting all properties.
function namafile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to namafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function rotate_sliider_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_sliider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
nilai_slider = get(handles.rotate_sliider,'Value');
handles.nilai_slider = round(nilai_slider);
guidata(hObject,handles);
set(handles.rotates,'String',handles.nilai_slider);

global a
hasil = imrotate(a,1*handles.nilai_slider,'bilinear','crop');
handles.hasil = hasil;
guidata(hObject,handles);
axes(handles.axes2);
imshow(hasil);

% --- Executes during object creation, after setting all properties.
function rotate_sliider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotate_sliider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function rotates_Callback(hObject, eventdata, handles)
% hObject    handle to rotates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotates as text
%        str2double(get(hObject,'String')) returns contents of rotates as a double


% --- Executes during object creation, after setting all properties.
function rotates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
