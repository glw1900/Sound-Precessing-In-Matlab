function varargout = uitest(varargin)

% UITEST MATLAB code for uitest.fig
%      UITEST, by itself, creates a new UITEST or raises the existing
%      singleton*.
%
%      H = UITEST returns the handle to a new UITEST or the handle to
%      the existing singleton*.
%
%      UITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UITEST.M with the given input arguments.
%
%      UITEST('Property','Value',...) creates a new UITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before uitest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to uitest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES




% Edit the above text to modify the response to help uitest

% Last Modified by GUIDE v2.5 20-Apr-2015 23:33:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uitest_OpeningFcn, ...
                   'gui_OutputFcn',  @uitest_OutputFcn, ...
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

% --- Executes just before uitest is made visible.
function uitest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to uitest (see VARARGIN)

% Choose default command line output for uitest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using uitest.
if strcmp(get(hObject,'Visible'),'off')
    drawplot([0 0], handles.axes1);
    ylabel('Original');
    drawplot([0 0], handles.axes3);
end

% UIWAIT makes uitest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = uitest_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
 

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --------------------------------------------------------------------
function tools_Callback(hObject, eventdata, handles)
% hObject    handle to tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function notes_recognition_Callback(hObject, eventdata, handles)
% hObject    handle to notes_recognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function pitch_Callback(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp(FileName);

% --------------------------------------------------------------------
function vocal_elimitation_Callback(hObject, eventdata, handles)
% hObject    handle to vocal_elimitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');
    
% FileName=getappdata(handles.output,'FileName')
result_wave = vocal_elimination(wave, fs, bits);
drawplot(result_wave, handles.axes3)
setappdata(handles.output,'result_wave',result_wave);


% --------------------------------------------------------------------
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))~=0
    rmappdata(handles.output,'result_wave');
end
[FileName,PathName] = uigetfile('*.wav','Open sound');
setappdata(handles.output,'FileName',FileName);
[wave,fs,bits] = wavread(FileName);
setappdata(handles.output,'wave',wave);
setappdata(handles.output,'fs',fs);
setappdata(handles.output,'bits',bits);

drawplot(wave, handles.axes1)
ylabel('Original');



% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)  
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileName=getappdata(handles.output,'FileName');
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');
result_wave=getappdata(handles.output,'wave');
[filename,path] = uiputfile('*.wav','Save Sound');
wavwrite(result_wave,fs,filename);


% --------------------------------------------------------------------
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileName=getappdata(handles.output,'FileName');
[Original,fs,bits]=wavread(FileName);
result_wave=getappdata(handles.output,'result_wave');
sound(result_wave,fs,bits);


% --------------------------------------------------------------------
function up1_Callback(hObject, eventdata, handles)
% hObject    handle to up1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 9439, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function up2_Callback(hObject, eventdata, handles)
% hObject    handle to up2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 8909, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function up3_Callback(hObject, eventdata, handles)
% hObject    handle to up3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 8409, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function up4_Callback(hObject, eventdata, handles)
% hObject    handle to up4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 7937, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function down1_Callback(hObject, eventdata, handles)
% hObject    handle to down1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 10595, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function down2_Callback(hObject, eventdata, handles)
% hObject    handle to down2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 11225, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function down3_Callback(hObject, eventdata, handles)
% hObject    handle to down3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 11892, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)
% --------------------------------------------------------------------
function down4_Callback(hObject, eventdata, handles)
% hObject    handle to down4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
fs = getappdata(handles.output,'fs');
bits = getappdata(handles.output,'bits');


% FileName=getappdata(handles.output,'FileName');
result_wave = pitch(wave, fs, bits, 12599, 10000);
setappdata(handles.output,'result_wave',result_wave);
drawplot(result_wave, handles.axes3)

% --------------------------------------------------------------------
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time = inputdlg('Please input recording time','I am a window',[1 50],{'7'},'on');
pause(1);
bi;
pause(1);
bi;
pause(1);
bi;
pause(1);
time = str2num(time{1});
record_wave = record(time);
setappdata(handles.output,'wave',record_wave);
setappdata(handles.output,'fs',8000);
msgbox('time is over','warn','warn')
pause(1)
drawplot(record_wave, handles.axes1);

% --------------------------------------------------------------------
function people_Callback(hObject, eventdata, handles)
% hObject    handle to people (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
% record_wave = getappdata(handles.output,'record_wave');
% record_wave = wavread('success1.wav');
[result_wave music] = human2machine(wave, handles, 0);
info = [music(:,1)]
msgbox(info)

% --------------------------------------------------------------------
function music_Callback(hObject, eventdata, handles)
% hObject    handle to music (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if length(getappdata(handles.output,'result_wave'))==0
    wave = getappdata(handles.output,'wave');
else
    wave = getappdata(handles.output,'result_wave');
end
% record_wave = getappdata(handles.output,'record_wave');
% record_wave = wavread('success1.wav');
[result_wave music] = human2machine(wave, handles, 1);
info = [music(:,1)]
msgbox(info)

function drawplot(result_wave, handle_axex)
axes(handle_axex);
cla;
x = double(result_wave);
x = x / max(abs(x));
plot(x) 
axis([1 length(x) -1 1])
ylabel('Result');

function bi
fs=44100;
t=0: 1/fs: 0.5;
la = sin(2*pi*440*t);
sound(la, fs);