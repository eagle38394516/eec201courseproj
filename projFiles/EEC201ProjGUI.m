function varargout = EEC201ProjGUI(varargin)
% EEC201PROJGUI MATLAB code for EEC201ProjGUI.fig
%      EEC201PROJGUI, by itself, creates a new EEC201PROJGUI or raises the existing
%      singleton*.
%
%      H = EEC201PROJGUI returns the handle to a new EEC201PROJGUI or the handle to
%      the existing singleton*.
%
%      EEC201PROJGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEC201PROJGUI.M with the given input arguments.
%
%      EEC201PROJGUI('Property','Value',...) creates a new EEC201PROJGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EEC201ProjGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EEC201ProjGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EEC201ProjGUI

% Last Modified by GUIDE v2.5 16-Mar-2019 22:29:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEC201ProjGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EEC201ProjGUI_OutputFcn, ...
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


% --- Executes just before EEC201ProjGUI is made visible.
function EEC201ProjGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EEC201ProjGUI (see VARARGIN)

% Choose default command line output for EEC201ProjGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EEC201ProjGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function readArguments(handles)
    globals = guidata(handles.figure1);

    globals.frameSize_ms = str2double(get(handles.frameSizeTxt, 'String'));
    globals.samplingRate = str2double(get(handles.samplingRateTxt, 'String'));
    globals.lpcOrder = str2double(get(handles.lpcOrderTxt, 'String'));
    globals.overlapProporation = str2double(get(handles.overlapTxt, 'String'));

    guidata(handles.figure1, globals);


% --- Outputs from this function are returned to the command line.
function varargout = EEC201ProjGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openFileBtn.
function openFileBtn_Callback(hObject, eventdata, handles)
% hObject    handle to openFileBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    readArguments(handles);
    globals = guidata(handles.figure1);

    [file, path] = uigetfile('*.wav');
    WAV_FILE = [path, file];
    globals.data = myAudioIn(WAV_FILE, globals.samplingRate);
    plot(handles.axes1, globals.data);

    guidata(handles.figure1, globals)


% --- Executes on button press in recordBtn.
function recordBtn_Callback(hObject, eventdata, handles)
% hObject    handle to recordBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    readArguments(handles);
    globals = guidata(handles.figure1);

    if length(get(hObject, 'String')) == 6
        globals.recorder = audiorecorder(globals.samplingRate, 16 ,1) ;
        record(globals.recorder);
        set(hObject, 'String', 'Stop');
    else
        stop(globals.recorder);
        globals.data = getaudiodata(globals.recorder);

        sizeOFData = size(globals.data);
        if sizeOFData(2) == 2
            globals.data(:, 2) = [];
        end

        plot(handles.axes1, globals.data);

        set(hObject, 'String', 'Record');
    end

    guidata(handles.figure1, globals)


% --- Executes on button press in exportBtn.
function exportBtn_Callback(hObject, eventdata, handles)
% hObject    handle to exportBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    globals = guidata(handles.figure1);
    numOfFrames = globals.numOfFrames;
    numOfFrameDots = globals.numOfFrameDots;
    ifVoice = globals.ifVoice;
    gain = globals.gain;
    pitchArray = globals.pitchArray;
    lpcCoeffs = globals.lpcCoeffs;
    frameSize_ms = globals.frameSize_ms;
    samplingRate = globals.samplingRate;
    overlapProporation = globals.overlapProporation;
    save('args.mat', 'numOfFrames', 'numOfFrameDots', 'ifVoice', 'gain', 'pitchArray', 'lpcCoeffs', 'frameSize_ms', 'samplingRate', 'overlapProporation');
%     globals.signalOut = myDecoder(globals.numOfFrames, ...
%                                   globals.numOfFrameDots, ...
%                                   globals.ifVoice, ...
%                                   globals.gain, ...
%                                   globals.pitchArray, ...
%                                   globals.lpcCoeffs, ...
%                                   globals.frameSize_ms, ...
%                                   globals.samplingRate, ...
%                                   globals.overlapProporation, ...
%                                   handles);
%
%     globals.signalOut = myPreFilter(globals.signalOut, 0.98);
%     globals.signalOut = globals.signalOut / max(globals.signalOut);
    audiowrite("output.wav", globals.signalOut, globals.samplingRate);
    guidata(handles.figure1, globals)


% --- Executes on button press in encoderBtn.
function encoderBtn_Callback(hObject, eventdata, handles)
% hObject    handle to encoderBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    readArguments(handles);
    globals = guidata(handles.figure1);
    globals.audioData = myPreFilter(globals.data, 0.98);

    [globals.numOfFrames, ...
     globals.numOfFrameDots, ...
     globals.ifVoice, ...
     globals.gain, ...
     globals.pitchArray, ...
     globals.lpcCoeffs] ...
            = myEncoder(globals.audioData, ...
                        globals.frameSize_ms, ...
                        globals.samplingRate, ...
                        globals.lpcOrder, ...
                        globals.overlapProporation, ...
                        handles);

    guidata(handles.figure1, globals)


% --- Executes on button press in decoderBtn.
function decoderBtn_Callback(hObject, eventdata, handles)
% hObject    handle to decoderBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    globals = guidata(handles.figure1);
    globals.signalOut = myDecoder(globals.numOfFrames, ...
                                  globals.numOfFrameDots, ...
                                  globals.ifVoice, ...
                                  globals.gain, ...
                                  globals.pitchArray, ...
                                  globals.lpcCoeffs, ...
                                  globals.frameSize_ms, ...
                                  globals.samplingRate, ...
                                  globals.overlapProporation, ...
                                  handles);

    globals.signalOut = myPreFilter(globals.signalOut, 0.98);
    globals.signalOut = globals.signalOut / max(globals.signalOut);
    guidata(handles.figure1, globals)



function samplingRateTxt_Callback(hObject, eventdata, handles)
% hObject    handle to samplingRateTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingRateTxt as text
%        str2double(get(hObject,'String')) returns contents of samplingRateTxt as a double


% --- Executes during object creation, after setting all properties.
function samplingRateTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingRateTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lpcOrderTxt_Callback(hObject, eventdata, handles)
% hObject    handle to lpcOrderTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lpcOrderTxt as text
%        str2double(get(hObject,'String')) returns contents of lpcOrderTxt as a double


% --- Executes during object creation, after setting all properties.
function lpcOrderTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lpcOrderTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function overlapTxt_Callback(hObject, eventdata, handles)
% hObject    handle to overlapTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of overlapTxt as text
%        str2double(get(hObject,'String')) returns contents of overlapTxt as a double


% --- Executes during object creation, after setting all properties.
function overlapTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlapTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frameSizeTxt_Callback(hObject, eventdata, handles)
% hObject    handle to frameSizeTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameSizeTxt as text
%        str2double(get(hObject,'String')) returns contents of frameSizeTxt as a double


% --- Executes during object creation, after setting all properties.
function frameSizeTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameSizeTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in playOriginalBtn.
function playOriginalBtn_Callback(hObject, eventdata, handles)
% hObject    handle to playOriginalBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    globals = guidata(handles.figure1);

%     player = audioplayer(globals.data, globals.samplingRate);
%     play(player);
    sound(globals.data, globals.samplingRate);

    guidata(handles.figure1, globals)

% --- Executes on button press in playSynthBtn.
function playSynthBtn_Callback(hObject, eventdata, handles)
% hObject    handle to playSynthBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    globals = guidata(handles.figure1);

%     player = audioplayer(globals.signalOut, globals.samplingRate);
%     play(player);
    sound(globals.signalOut, globals.samplingRate);

    guidata(handles.figure1, globals)


% --- Executes on button press in voiceConvBtn.
function voiceConvBtn_Callback(hObject, eventdata, handles)
% hObject    handle to voiceConvBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    globals = guidata(handles.figure1);

    globals.pitchArray = globals.pitchArray * str2double(get(handles.pitchTransTxt, 'String'));

    stem(handles.axes2, globals.ifVoice * 200, '.');
    set(handles.axes2, 'NextPlot', 'Add');
    plot(handles.axes2, globals.pitchArray, '.-');
    set(handles.axes2, 'NextPlot', 'Replace');
    legend(handles.axes2, 'ifVoice', 'pitch');

    guidata(handles.figure1, globals)


function pitchTransTxt_Callback(hObject, eventdata, handles)
% hObject    handle to pitchTransTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitchTransTxt as text
%        str2double(get(hObject,'String')) returns contents of pitchTransTxt as a double


% --- Executes during object creation, after setting all properties.
function pitchTransTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchTransTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
