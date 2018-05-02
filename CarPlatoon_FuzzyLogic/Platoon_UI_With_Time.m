%  Autonomous Car Platoon
% UI Implementation of the simulation using GUIDE
% of MATLAB.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = Platoon_UI_With_Time(varargin)
%PLATOON_UI_WITH_TIME M-file for Platoon_UI_With_Time.fig
%      PLATOON_UI_WITH_TIME, by itself, creates a new PLATOON_UI_WITH_TIME or raises the existing
%      singleton*.
%
%      H = PLATOON_UI_WITH_TIME returns the handle to a new PLATOON_UI_WITH_TIME or the handle to
%      the existing singleton*.
%
%      PLATOON_UI_WITH_TIME('Property','Value',...) creates a new PLATOON_UI_WITH_TIME using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Platoon_UI_With_Time_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PLATOON_UI_WITH_TIME('CALLBACK') and PLATOON_UI_WITH_TIME('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PLATOON_UI_WITH_TIME.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Platoon_UI_With_Time

% Last Modified by GUIDE v2.5 12-Aug-2016 16:04:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Platoon_UI_With_Time_OpeningFcn, ...
                   'gui_OutputFcn',  @Platoon_UI_With_Time_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Platoon_UI_With_Time is made visible.
function Platoon_UI_With_Time_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Platoon_UI_With_Time
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Platoon_UI_With_Time wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Platoon_UI_With_Time_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Dd_tag_Callback(hObject, eventdata, handles)
% hObject    handle to Dd_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dd_tag as text
%        str2double(get(hObject,'String')) returns contents of Dd_tag as a double


% --- Executes during object creation, after setting all properties.
function Dd_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dd_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D12_tag_Callback(hObject, eventdata, handles)
% hObject    handle to D12_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D12_tag as text
%        str2double(get(hObject,'String')) returns contents of D12_tag as a double


% --- Executes during object creation, after setting all properties.
function D12_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D12_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vd_tag_Callback(hObject, eventdata, handles)
% hObject    handle to Vd_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vd_tag as text
%        str2double(get(hObject,'String')) returns contents of Vd_tag as a double


% --- Executes during object creation, after setting all properties.
function Vd_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vd_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vini_tag_Callback(hObject, eventdata, handles)
% hObject    handle to Vini_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vini_tag as text
%        str2double(get(hObject,'String')) returns contents of Vini_tag as a double


% --- Executes during object creation, after setting all properties.
function Vini_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vini_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D23_tag_Callback(hObject, eventdata, handles)
% hObject    handle to D23_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D23_tag as text
%        str2double(get(hObject,'String')) returns contents of D23_tag as a double


% --- Executes during object creation, after setting all properties.
function D23_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D23_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toggleButton.
function toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggleButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(hObject, 'String', 'Stop System');
    set(handles.Vini_tag, 'Enable', 'off');
    set(handles.D12_tag, 'Enable', 'off');
    set(handles.D23_tag, 'Enable', 'off');
    set(handles.centroid, 'Enable', 'off');
    set(handles.mom, 'Enable', 'off');
    set(handles.bisector, 'Enable', 'off');
    set(handles.triangular, 'Enable', 'off');
    set(handles.gaussian, 'Enable', 'off');
	
elseif button_state == get(hObject,'Min')
	set(hObject, 'String', 'Start System')
    set(handles.Vini_tag, 'Enable', 'on');
    set(handles.D12_tag, 'Enable', 'on');
    set(handles.D23_tag, 'Enable', 'on');
    set(handles.centroid, 'Enable', 'on');
    set(handles.mom, 'Enable', 'on');
    set(handles.bisector, 'Enable', 'on');
    set(handles.triangular, 'Enable', 'on');
    set(handles.gaussian, 'Enable', 'on');
    cla(handles.velocties_tag,'reset');
    cla(handles.acceleration_tag,'reset');
    cla(handles.distances_tag,'reset')
    cla(handles.animation_tag, 'reset');
    set(handles.car1_vs, 'String', ' ');
    set(handles.car2_vs, 'String', ' ');
    set(handles.car3_vs, 'String', ' ');
    set(handles.car2_ds, 'String', ' ');
    set(handles.car3_ds, 'String', ' ');
end
CarPlatoon(handles, hObject);


% --- Executes on button press in centroid.
function centroid_Callback(hObject, eventdata, handles)
% hObject    handle to centroid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of centroid
set(handles.mom, 'Value', 0.0);
set(handles.bisector, 'Value', 0.0);

% --- Executes on button press in mom.
function mom_Callback(hObject, eventdata, handles)
% hObject    handle to mom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mom
set(handles.centroid, 'Value', 0.0);
set(handles.bisector, 'Value', 0.0);

% --- Executes on button press in bisector.
function bisector_Callback(hObject, eventdata, handles)
% hObject    handle to bisector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bisector
set(handles.centroid, 'Value', 0.0);
set(handles.mom, 'Value', 0.0);


% --- Executes on button press in triangular.
function triangular_Callback(hObject, eventdata, handles)
% hObject    handle to triangular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of triangular
set(handles.gaussian, 'Value', 0.0);

% --- Executes on button press in gaussian.
function gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussian
set(handles.triangular, 'Value', 0.0);
