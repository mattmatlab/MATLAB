%BIOE241 Final Project 
%MRI Imager 
% Matthew McHugh - Mitsuo Kumagai - Jacob Meakin

function MRI_Imager
%% Set up
%Constants
blueimager = [0 0.80 1];
yellow   = [1 1 0.75];

%GUI Figure
fig = figure('numbertitle','off','menubar','none','name','MRI Imager',...
    'color',blueimager,'position',[5 40 1530 780]);

%% Upper GUI Region
% File Load System
file_menu = uimenu('label','&File','accelerator','f');
uimenu(file_menu,'label','&Open','accelerator','o','tag','fopen');
uimenu(file_menu,'label','E&xit','accelerator','x','tag','fexit');

%Text Box for Folder Name
temp = dir;
uicontrol('Style','text','position',[80 740 70 20],'horizontalalignment','right',...
    'string','Folder: ','backgroundcolor',yellow);
uicontrol('Style','edit','position',[150 740 800 20],'horizontalalignment','left',...
    'String', temp(1).folder,'tag','folderbox');

% Load Button
uicontrol('Style','pushbutton','position',[950 740 80  20],...
    'string','LOAD','tag','loadbutton');

% Popupmenu for Segment Selection
uicontrol('Style','text','position',[80 720 70 20],'horizontalalignment','right',...
    'string','Segment: ','backgroundcolor',yellow);
uicontrol('Style','popupmenu','position',[150 719 100  20], ...
    'String', {'1';'3';'4';'5';'6';'7'},'tag','segment');

% Zoom Box
uicontrol('style','text','position',[80 700 70 27],...
    'string','Zoom Box (mm)','backgroundcolor',yellow);
uicontrol('style','edit','position',[150 700 100 20],'tag','zoombox','string','100');

% Refresh Button
uicontrol('style','pushbutton','position',[275 710 80 20],...
    'string','REFRESH','backgroundcolor','yellow','tag','refresh');

% Popupmenu for Meaningful Physiological Region Selection
uicontrol('Style','text','position',[1200 551 70 20],'horizontalalignment','right',...
    'string','Region: ');
uicontrol('Style','popupmenu','position',[1270 550 100  20], ...
    'String', {'Head';'Neck';'Chest';'Abdomen';'Pelvis';'Thighs';'Calves';'Feet'},...
    'backgroundcolor','yellow','tag','MPR');

% Intensity Selection
uicontrol('style','text','position',[1200 500 70 20],...
    'string','Intensity:','backgroundcolor',yellow);
uicontrol('style','edit','position',[1270 500 100 20],'tag','isolevel','string','250');

% Load Isosurface Button
uicontrol('Style','pushbutton','position',[1370 500 80  20],...
    'string','EXTRACT','tag','isobutton');

% Isosurface Perspective Sliders
uicontrol('style','slider','position',[1200 150 250 20],'min',-180,'max',180,'value',60,...
    'tag','az_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[1180 150 20 20],'string','Az','backgroundcolor','yellow');

uicontrol('style','slider','position',[1460 197 20 250],'min',-90,'max',90,'value',30,...
    'tag','el_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[1460 177 20 20],'string','El','backgroundcolor','yellow');

% Not A Secret Feature
uicontrol('Style','pushbutton','position',[1500,10,20,20],'string','?','tag','surprise');

%% Views Normal(Global)
%Global Front View (Vary Y)
axes('units','pixels','position',[25 380 250 250],'tag','norm_f_axes');
uicontrol('style','text','position',[25 630 128 20],'string','Front View');
%global y-position box
uicontrol('style','text','position',[153 630 64 20],'string','Y (mm): ');
uicontrol('style','text','position',[217 630 58 20],'string','0','tag','norm_y_tval',...
    'backgroundcolor','yellow');
%global y-slider
uicontrol('style','slider','position',[25 340 250 20],'min',-1,'max',1,'value',0,'tag',...
    'norm_y_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[5 340 20 20],'string','Y','backgroundcolor','yellow');    

%Global Side View (Vary X)
axes('units','pixels','position',[300 380 250 250],'tag','norm_s_axes');
uicontrol('style','text','position',[300 630 128 20],'string','Side View');
%global x-position box
uicontrol('style','text','position',[428 630 64 20],'string','X (mm): ');
uicontrol('style','text','position',[492 630 58 20],'string','0','tag','norm_x_tval',...
    'backgroundcolor','yellow');
%global x-slider
uicontrol('style','slider','position',[300 340 250 20],'min',-1,'max',1,'value',0,'tag',...
    'norm_x_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[280 340 20 20],'string','X','backgroundcolor','yellow');

%Global Bottom View (Vary Z)
axes('units','pixels','position',[300 50 250 250],'tag','norm_b_axes');
uicontrol('style','text','position',[300 300 128 20],'string','Bottom View');
%global z-position box
uicontrol('style','text','position',[428 300 64 20],'string','Z (mm): ');
uicontrol('style','text','position',[492 300 58 20],'string','0','tag','norm_z_tval',...
    'backgroundcolor','yellow');
%global z-slider
uicontrol('style','slider','position',[560 60 20 250],'min',-1,'max',1,'value',0,'tag',...
    'norm_z_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[560 40 20 20],'string','Z','backgroundcolor','yellow');

%Global Slices
axes('units','pixels','position',[25 50 250 250],'tag','norm_slice_axes');
uicontrol('style','text','position',[25 300 128 20],'string','Slice View');

%Global Isosurface
axes('units','pixels','position',[1200 200 250 250],'tag','norm_iso_axes');
uicontrol('style','text','position',[1200 450 128 20],'string','Isosurface View');

%% Views Zoom
%Zoom Front View (Vary Y)
axes('units','pixels','position',[605 380 250 250],'tag','zoom_f_axes');
uicontrol('style','text','position',[605 630 128 20],'string','Front View');
%Zoom y-position box
uicontrol('style','text','position',[733 630 64 20],'string','Y (mm): ');
uicontrol('style','text','position',[797 630 58 20],'string','0','tag','zoom_y_tval',...
    'backgroundcolor','yellow');
%Zoom y-slider
uicontrol('style','slider','position',[605 340 250 20],'min',-1,'max',1,'value',0,'tag',...
    'zoom_y_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[585 340 20 20],'string','Y','backgroundcolor','yellow');    

%Zoom Side View (Vary X)
axes('units','pixels','position',[880 380 250 250],'tag','zoom_s_axes');
uicontrol('style','text','position',[880 630 128 20],'string','Side View');
%Zoom x-position box
uicontrol('style','text','position',[1008 630 64 20],'string','X (mm): ');
uicontrol('style','text','position',[1072 630 58 20],'string','0','tag','zoom_x_tval',...
    'backgroundcolor','yellow');
%Zoom x-slider
uicontrol('style','slider','position',[880 340 250 20],'min',-1,'max',1,'value',0,'tag',...
    'zoom_x_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[860 340 20 20],'string','X','backgroundcolor','yellow');

%Zoom Bottom View (Vary Z)
axes('units','pixels','position',[880 50 250 250],'tag','zoom_b_axes');
uicontrol('style','text','position',[880 300 128 20],'string','Bottom View');
%Zoom z-position box
uicontrol('style','text','position',[1008 300 64 20],'string','Z (mm): ');
uicontrol('style','text','position',[1072 300 58 20],'string','0','tag','zoom_z_tval',...
    'backgroundcolor','yellow');
%Zoom z-slider
uicontrol('style','slider','position',[1140 60 20 250],'min',-1,'max',1,'value',0,'tag',...
    'zoom_z_slider','backgroundcolor',yellow);
uicontrol('style','text','position',[1140 40 20 20],'string','Z','backgroundcolor','yellow');

%Zoom Slices
axes('units','pixels','position',[605 50 250 250],'tag','zoom_slice_axes');
uicontrol('style','text','position',[605 300 128 20],'string','Slice View');

%% Boiler Plate: Single Callback
handles = guihandles(fig);
guidata(fig,handles);
hca = struct2cell(handles);
for k = 1:length(hca)
    obj = hca{k};
    if isfield(obj,'callback') | isprop(obj,'callback')
        set(obj,'callback', { @main_cb, handles } );
    end
end

% Main callback: process button and menu evens ......................
function main_cb(uiobject,~,handles)
tag  = get(uiobject,'tag');
switch tag
    case 'norm_y_slider'
        gshow(handles);
        zshow(handles);
        zreset_sliders(handles);
    case 'norm_x_slider'
        gshow(handles);
        zshow(handles);
        zreset_sliders(handles);
    case 'norm_z_slider'
         gshow(handles);
        zshow(handles);
        zreset_sliders(handles);
        
    case 'zoom_y_slider'
        zshow(handles);
        
    case 'zoom_x_slider'
        zshow(handles);
        
    case 'zoom_z_slider'
        zshow(handles);
    
    case 'refresh'
        gshow(handles);
        zshow(handles);
        do_isosurface(handles);
        zreset_sliders(handles);
        
    case {'el_slider','az_slider'}
        az = get(handles.az_slider,'value');
        el = get(handles.el_slider,'value');
        ax = handles.norm_iso_axes;
        risosurface(handles);
        view(ax,[az el]);
        
    case {'segment','folderbox','loadbutton'}
        MR_load(handles);
        gshow(handles);
        zshow(handles);
        do_isosurface(handles);
        greset_sliders(handles)
        zreset_sliders(handles);
        
    case {'isolevel','isobutton'}
        do_isosurface(handles);
        greset_sliders(handles);
        
    case 'MPR'
        risosurface(handles);
        gshow(handles);
        zshow(handles);
        do_isosurface(handles);
        zreset_sliders(handles);
        greset_sliders(handles);
        
    case 'fopen'
        fpath = uigetdir;
        if fpath
            set(handles.folderbox,'string',fpath);
            MR_load(handles);
            greset_sliders(handles);
            gshow(handles);
            zreset_sliders(handles);
            zshow(handles);
        end
    
    case 'surprise'
        fsurprise(handles);
        
    case 'fexit'
        p = get(get(uiobject,'parent'),'parent');
        delete(p);
end

% Load data based on selected segment, and selected folder ..........
function MR_load(handles)
global imstack x y z cscale
folder     = get(handles.folderbox,'string');
MR_channel = folder(end-6:end);
dirlist    = dir(folder);
sect       = get(handles.segment,'value');
if sect > 1
    sect = sect+1;
end
fids = [];
for k = 1:length(dirlist)
    fname = dirlist(k).name;
    if length(fname) >= 4
        if fname(end-3:end) == '.png' & fname(end-4) == MR_channel(end)
            fidx = str2num(fname(4:7));
            if floor(fidx/1000) == sect
                fids = [fids ; fidx];
            end
        end
    end
end
if ~isempty(fids)
    fids = sort(fids,'descend');
    nim  = length(fids);
    k = 1;
    fname = [folder '/mvf' num2str(fids(k)) MR_channel(end) '.png'];
    im1  = imread(fname);
    if sect == 1
        imstack = single(zeros(size(im1,1),size(im1,2),nim));
        imstack(:,:,k) = fliplr(im1');
    else
        imstack = single(zeros(size(im1,2),nim,size(im1,1)));
        imstack(:,nim-k+1,:) = fliplr(im1');
    end
    tic;
    for k = 2:nim
        fname = [folder '/mvf' num2str(fids(k)) MR_channel(end) '.png'];
        if sect == 1
            imstack(:,:,k) = fliplr(imread(fname)');
        else
            imstack(:,nim-k+1,:) = fliplr(imread(fname)');
        end
    end
    % define x, y, z axis extents -----------------------------------------
    if sect == 1
        y = linspace(-110,110,256);
        x = linspace(-110,110,256);
        z = 4*(0:nim-1);
    else
        x = 2*linspace(-110,110,256);
        y = 4*(0:nim-1) - 2*nim;
        z = 2*linspace(0,220,256);
    end
    % find min and max pixel intensities of imstack
    cscale = [min(imstack(:)) max(imstack(:))];
else
    set(handles.folderbox,'string','Files Not Found');	% <- *** put this in a different text box
end

% Gshow: display front, side, bottom and 3-D slice views ...........
function gshow(handles)
global imstack x y z cscale
% get size of zoom box
zbox = get(handles.zoombox,'string');
zoomsn = str2num(zbox);		% <- *** get this from a text box instead
% get global x-y-z level from sliders
xnslv = get(handles.norm_x_slider,'value');	% <- *** get this from a slider instead
ynslv = get(handles.norm_y_slider,'value');
znslv = get(handles.norm_z_slider,'value');	% <- *** get this from a slider instead

% update text box(es)
set(handles.norm_x_tval,'string',num2str(round(xnslv)))
set(handles.norm_y_tval,'string',num2str(round(ynslv)))
set(handles.norm_z_tval,'string',num2str(round(znslv)))

% find indices corresponding to global x-y-z levels
[~,ixnsl] = min(abs(xnslv-x));    % iysl = index fot x-level
[~,iynsl] = min(abs(ynslv-y));	% iysl = index for y-level
[~,iznsl] = min(abs(znslv-z));

% show global front  view (x-z) at specified y position
axnf = handles.norm_f_axes;
pcolor(axnf,x,z,squeeze(imstack(:,iynsl,:))')
decoratenf(axnf,cscale)
hold(axnf,'on')
plot(axnf,[xnslv xnslv],[min(z) max(z)],'y',[min(x) max(x)],[znslv znslv],'y')
rectangle(axnf,'position',[[xnslv znslv]-zoomsn/2 zoomsn zoomsn],'edgecolor','red');
hold(axnf,'off')

% show global bottom view (x-y) at specified z position
axnb = handles.norm_b_axes;
pcolor(axnb,x,y,squeeze(imstack(:,:,iznsl))')
decoratenb(axnb,cscale)
hold(axnb,'on')
plot(axnb,[xnslv xnslv],[min(y) max(y)],'y',[min(x) max(x)],[ynslv ynslv],'y')
rectangle(axnb,'position',[[xnslv ynslv]-zoomsn/2 zoomsn zoomsn],'edgecolor','red');
hold(axnb,'off')

% show global side   view (y-z) at specified x position
axns = handles.norm_s_axes;
pcolor(axns,y,z,squeeze(imstack(ixnsl,:,:))')
decoratens(axns,cscale)
hold(axns,'on')
plot(axns,[ynslv ynslv],[min(z) max(z)],'y',[min(y) max(y)],[znslv znslv],'y')
rectangle(axns,'position',[[ynslv znslv]-zoomsn/2 zoomsn zoomsn],'edgecolor','red');
hold(axns,'off')

% show global 3-D slices
axnslice = handles.norm_slice_axes;
slice(axnslice,y,x,z,imstack,ynslv,[],[])
hold(axnslice,'on')
slice(axnslice,y,x,z,imstack,[],xnslv,[])
slice(axnslice,y,x,z,imstack,[],[],znslv)
hold(axnslice,'off')
colormap(axnslice,'gray')
shading(axnslice,'flat'); view(axnslice,60,30)
axis(axnslice,'equal'); 
axis(axnslice,'tight');
xlabel(axnslice,'y (mm)');ylabel(axnslice,'x (mm)');zlabel(axnslice,'z (mm)');

% Zshow: display front, side, bottom and 3-D slice views ...........
function zshow(handles)
global imstack x y z cscale

% get size of zoom box
zbox = get(handles.zoombox,'string');
zoomsz = str2num(zbox);
% get global x-y-z level from global sliders
xnslv = get(handles.norm_x_slider,'value');	% <- *** get this from a slider instead
ynslv = get(handles.norm_y_slider,'value');
znslv = get(handles.norm_z_slider,'value');	% <- *** get this from a slider instead
% update global x-y-z text box(es)
set(handles.norm_x_tval,'string',num2str(round(xnslv)))
set(handles.norm_y_tval,'string',num2str(round(ynslv)))
set(handles.norm_z_tval,'string',num2str(round(znslv)))
% get stack indices corresponding to x-y-z levels +/- zoom size/2 ...
[~,ixz0] = min(abs(xnslv-zoomsz/2-x));
[~,ixz1] = min(abs(xnslv+zoomsz/2-x));
[~,iyz0] = min(abs(ynslv-zoomsz/2-y));
[~,iyz1] = min(abs(ynslv+zoomsz/2-y));
[~,izz0] = min(abs(znslv-zoomsz/2-z));
[~,izz1] = min(abs(znslv+zoomsz/2-z));
xz = x(ixz0:ixz1);
yz = y(iyz0:iyz1);
zz = z(izz0:izz1);

% get zoomed sub-image stack from global image stack
zimstack = imstack(ixz0:ixz1,iyz0:iyz1,izz0:izz1);

% get zoomed x-y-z level from zoom sliders
xzslv = get(handles.zoom_x_slider,'value');	% <- *** get this from a slider instead
yzslv = get(handles.zoom_y_slider,'value');	% <- *** get this from a slider instead
zzslv = get(handles.zoom_z_slider,'value');

% update zoomed x-y-z text box(es)
set(handles.zoom_x_tval,'string',num2str(round(xzslv)))
set(handles.zoom_y_tval,'string',num2str(round(yzslv)))
set(handles.zoom_z_tval,'string',num2str(round(zzslv)))

% find indices corresponding to zoomed x-y-z levels
[~,ixzsl] = min(abs(xzslv-xz));
[~,iyzsl] = min(abs(yzslv-yz));	% iysl = index for y-level
[~,izzsl] = min(abs(zzslv-zz));

% show zoomed front  view (x-z) at specified y position
axzb = handles.zoom_f_axes;
pcolor(axzb,xz,zz,squeeze(zimstack(:,iyzsl,:))')
decoratezf(axzb,cscale)
hold(axzb,'on')
plot(axzb,[xzslv xzslv],[min(zz) max(zz)],'g',[min(xz) max(xz)],[zzslv zzslv],'g')
hold(axzb,'off')
% show zoomed bottom view (x-y) at specified z position
axzb = handles.zoom_b_axes;
pcolor(axzb,xz,yz,squeeze(zimstack(:,:,izzsl))')
decoratezf(axzb,cscale)
hold(axzb,'on')
plot(axzb,[xzslv xzslv],[min(yz) max(yz)],'g',[min(xz) max(xz)],[yzslv yzslv],'g')
hold(axzb,'off')
% show zoomed side   view (y-z) at specified x position
axzs = handles.zoom_s_axes;
pcolor(axzs,yz,zz,squeeze(zimstack(ixzsl,:,:))')
decoratezs(axzs,cscale)
hold(axzs,'on')
plot(axzs,[yzslv yzslv],[min(zz) max(zz)],'g',[min(yz) max(yz)],[zzslv zzslv],'g')
hold(axzs,'off')
% show zoomed 3-D slices
axzslice = handles.zoom_slice_axes;
slice(axzslice,yz,xz,zz,zimstack,yzslv,[],[])
hold(axzslice,'on')
slice(axzslice,yz,xz,zz,zimstack,[],xzslv,[])
slice(axzslice,yz,xz,zz,zimstack,[],[],zzslv)
hold(axzslice,'off')
colormap(gray)
shading(axzslice,'flat'); view(axzslice,60,30)
axis(axzslice,'equal'); 
axis(axzslice,'tight');
xlabel(axzslice,'y (mm)');ylabel(axzslice,'x (mm)');zlabel(axzslice,'z (mm)');

% risosurface: Regional Isosurfaces    
function risosurface(handles)
global imstack x y z cscale
MPRV = get(handles.MPR,'value'); % MPR value
switch MPRV
    case 1
      set(handles.segment,'value',1);
    case 2
      set(handles.segment,'value',2);
    case 3
      set(handles.segment,'value',3);
    case 4
      set(handles.segment,'value',3);
    case 5
      set(handles.segment,'value',4);
    case 6
      set(handles.segment,'value',4);
    case 7
      set(handles.segment,'value',5);
    case 8
      set(handles.segment,'value',6);
end
MR_load(handles);
% 'Head'1 ;'Neck'3 ;'Chest'4 ;'Abdomen'4 ;'Pelvis' 5;'Thighs' 5;'Calves'
% 6;'Feet' 7
% set region specific slider value
switch MPRV
    case 1
        rsslvy = round(mean(y));
        rsslvx = round(mean(x));
        rsslvz = round(mean(z));
        set(handles.zoombox,'string',200);
    case 2
        rsslvy = round(mean(y));
        rsslvx = round(mean(x));
        rsslvz = round(mean(z));
        set(handles.zoombox,'string',200);
    case 3
        rsslvy = round(mean(y));
        rsslvx = round(mean(x));
        rsslvz = 315;
        set(handles.zoombox,'string',300);
    case 4
        rsslvy = round(mean(y));
        rsslvx = round(mean(x));
        rsslvz = 120;
        set(handles.zoombox,'string',300);
    case 5
        rsslvy = round(mean(y));
        rsslvx = -25;
        rsslvz = round(mean(z));
        set(handles.zoombox,'string',200);
    case 6
        rsslvy = round(mean(y));
        rsslvx = 75;
        rsslvz = 105;
        set(handles.zoombox,'string',200);
    case 7
        rsslvy = round(mean(y));
        rsslvx = 25;
        rsslvz = 200;
        set(handles.zoombox,'string',150);
    case 8
        rsslvy = round(mean(y));
        rsslvx = round(mean(x));
        rsslvz = 100;
        set(handles.zoombox,'string',250);
end
% reset global y-slider
set(handles.norm_y_slider,'min',min(y))
set(handles.norm_y_slider,'max',max(y))
set(handles.norm_y_slider,'value',rsslvy)
set(handles.norm_y_tval,'string',num2str(get(handles.norm_y_slider,'value')))
% reset the global x-slider
set(handles.norm_x_slider,'min',min(x))
set(handles.norm_x_slider,'max',max(x))
set(handles.norm_x_slider,'value',rsslvx)
set(handles.norm_x_tval,'string',num2str(get(handles.norm_x_slider,'value')))
% reset the global z-slider
set(handles.norm_z_slider,'min',min(z))
set(handles.norm_z_slider,'max',max(z))
set(handles.norm_z_slider,'value',rsslvz)
set(handles.norm_z_tval,'string',num2str(get(handles.norm_z_slider,'value')))

% do_isosurface: Plot Isosurfaces
function do_isosurface(handles)
global imstack x y z cscale
zbox = get(handles.zoombox,'string');
zoomsz = str2num(zbox);
% get global x-y-z level from global sliders
xnslv = get(handles.norm_x_slider,'value');	% <- *** get this from a slider instead
ynslv = get(handles.norm_y_slider,'value');
znslv = get(handles.norm_z_slider,'value');	% <- *** get this from a slider instead
% update global x-y-z text box(es)
set(handles.norm_x_tval,'string',num2str(round(xnslv)))
set(handles.norm_y_tval,'string',num2str(round(ynslv)))
set(handles.norm_z_tval,'string',num2str(round(znslv)))
% get stack indices corresponding to x-y-z levels +/- zoom size/2 ...
[~,ixz0] = min(abs(xnslv-zoomsz/2-x));
[~,ixz1] = min(abs(xnslv+zoomsz/2-x));
[~,iyz0] = min(abs(ynslv-zoomsz/2-y));
[~,iyz1] = min(abs(ynslv+zoomsz/2-y));
[~,izz0] = min(abs(znslv-zoomsz/2-z));
[~,izz1] = min(abs(znslv+zoomsz/2-z));
xz = x(ixz0:ixz1);
yz = y(iyz0:iyz1);
zz = z(izz0:izz1);
% get zoomed sub-image stack from global image stack
zimstack = imstack(ixz0:ixz1,iyz0:iyz1,izz0:izz1);
% show isosurface
pixelthresh = get(handles.isolevel,'string');% pixel threshhold for section 1
pixelthresh1 = str2num(pixelthresh);
az = get(handles.az_slider,'value');
el = get(handles.el_slider,'value');
axniso = handles.norm_iso_axes;
cla(axniso); % clear lighting and other effects on isosurface axes

s = isosurface(yz,xz,zz,zimstack,pixelthresh1);
c = isocaps(yz,xz,zz,zimstack,pixelthresh1);
patch(axniso,s,'FaceColor',[0.8,0.8,0.8],'EdgeColor','none'); 
patch(axniso,c,'FaceColor','flat','EdgeColor','none');

%hold off
view(axniso,[az el]) % shading and view settings
camlight(axniso,'right')
lighting(axniso,'gouraud')

colormap(axniso,'gray') % colormap for inside cuts
axis(axniso,'equal'); axis(axniso,'tight') % axis settings
xlabel(axniso,'x (mm)');ylabel(axniso,'y (mm)');zlabel(axniso,'z (mm)'); % labels

% set colormap, color scale, shading, etc, for normal front plot 
function decoratenf(axnf,cminmaxn,xlnf,ylnf,zlnf,azelnf)
colormap(axnf,gray);
caxis(axnf,cminmaxn);
shading(axnf,'flat'); axis(axnf,'equal'); axis(axnf,'tight')
if nargin > 2
    if ~isempty(xlnf)
        xlabel(axnf,xlnf)
    end
end
if nargin > 3
    if ~isempty(ylnf)
        ylabel(axnf,ylnf)
    end
end
if nargin > 4
    if ~isempty(zlnf)
        zlabel(axnf,zlnf)
    end
end
if nargin > 5
    view(axnf,azelnf);
end

% set colormap, color scale, shading, etc, for normal bottom plot 
function decoratenb(axnb,cminmaxn,xlnb,ylnb,zlnb,azelnb)
colormap(axnb,gray);
caxis(axnb,cminmaxn);
shading(axnb,'flat'); axis(axnb,'equal'); axis(axnb,'tight')
if nargin > 2
    if ~isempty(xlnb)
        xlabel(axnb,xlnb)
    end
end
if nargin > 3
    if ~isempty(ylnb)
        ylabel(axnb,ylnb)
    end
end
if nargin > 4
    if ~isempty(zlnb)
        zlabel(axnb,zlnb)
    end
end
if nargin > 5
    view(axnb,azelnb);
end

% set colormap, color scale, shading, etc, for normal side plot
function decoratens(axns,cminmaxn,xlns,ylns,zlns,azelns)
colormap(axns,gray);
caxis(axns,cminmaxn);
shading(axns,'flat'); axis(axns,'equal'); axis(axns,'tight')
if nargin > 2
    if ~isempty(xlns)
        xlabel(axns,xlns)
    end
end
if nargin > 3
    if ~isempty(ylns)
        ylabel(axns,ylns)
    end
end
if nargin > 4
    if ~isempty(zlns)
        zlabel(axns,zlns)
    end
end
if nargin > 5
    view(axns,azelns);
end

% set colormap, color scale, shading, etc, for zoomed front plot 
function decoratezf(axzf,cminmaxz,xlzf,ylzf,zlzf,azelzf)
colormap(axzf,gray);
caxis(axzf,cminmaxz);
shading(axzf,'flat'); axis(axzf,'equal'); axis(axzf,'tight')
if nargin > 2
    if ~isempty(xlzf)
        xlabel(axzf,xlzf)
    end
end
if nargin > 3
    if ~isempty(ylzf)
        ylabel(axzf,ylzf)
    end
end
if nargin > 4
    if ~isempty(zlzf)
        zlabel(axzf,zlzf)
    end
end
if nargin > 5
    view(axzf,azelzf);
end

% set colormap, color scale, shading, etc, for zoom bottom plot
function decoratezb(axzb,cminmaxz,xlzb,ylb,zlzb,azelzb)
colormap(axzb,gray);
caxis(axzb,cminmaxz);
shading(axzb,'flat'); axis(axzb,'equal'); axis(axzb,'tight')
if nargin > 2
    if ~isempty(xlzb)
        xlabel(axzb,xlzb)
    end
end
if nargin > 3
    if ~isempty(ylb)
        ylabel(axzb,ylb)
    end
end
if nargin > 4
    if ~isempty(zlzb)
        zlabel(axzb,zlzb)
    end
end
if nargin > 5
    view(axzb,azelzb);
end

% set colormap, color scale, shading, etc, for zoom side plot
function decoratezs(axzs,cminmaxz,xlzs,ylzs,zlzs,azelzs)
colormap(axzs,gray);
caxis(axzs,cminmaxz);
shading(axzs,'flat'); axis(axzs,'equal'); axis(axzs,'tight')
if nargin > 2
    if ~isempty(xlzs)
        xlabel(axzs,xlzs)
    end
end
if nargin > 3
    if ~isempty(ylzs)
        ylabel(axzs,ylzs)
    end
end
if nargin > 4
    if ~isempty(zlzs)
        zlabel(axzs,zlzs)
    end
end
if nargin > 5
    view(axzs,azelzs);
end

% Reset the global view sliders .....................................
function greset_sliders(handles)
global imstack x y z cscale
% reset the global y-slider
set(handles.norm_y_slider,'min',min(y))
set(handles.norm_y_slider,'max',max(y))
set(handles.norm_y_slider,'value',round(mean(y)))
set(handles.norm_y_tval,'string',num2str(get(handles.norm_y_slider,'value')))

% reset the global x-slider
set(handles.norm_x_slider,'min',min(x))
set(handles.norm_x_slider,'max',max(x))
set(handles.norm_x_slider,'value',round(mean(x)))
set(handles.norm_x_tval,'string',num2str(get(handles.norm_x_slider,'value')))

% reset the global z-slider
set(handles.norm_z_slider,'min',min(z))
set(handles.norm_z_slider,'max',max(z))
set(handles.norm_z_slider,'value',round(mean(z)))
set(handles.norm_z_tval,'string',num2str(get(handles.norm_z_slider,'value')))

% reset the az slider
set(handles.az_slider,'value',60);

% reset the el slider
set(handles.el_slider,'value',30);

% Reset the zoomed view sliders .....................................
function zreset_sliders(handles)
global imstack x y z cscale

% get size of zoom box
zbox = get(handles.zoombox,'string');
zoomsz = str2num(zbox);		% <- *** get this from a text box instead
% get position of global zoom sliders
xslv = get(handles.norm_x_slider,'value');
yslv = get(handles.norm_y_slider,'value');
zslv = get(handles.norm_z_slider,'value');	% <- *** get this from a slider instead

% build z coord vector for zoomed sub-imstack
[~,ixz0] = min(abs(xslv-zoomsz/2-x));
[~,ixz1] = max(abs(xslv-zoomsz/2-x));
[~,iyz0] = min(abs(yslv-zoomsz/2-y));
[~,iyz1] = max(abs(yslv-zoomsz/2-y));
[~,izz0] = min(abs(zslv-zoomsz/2-z));
[~,izz1] = min(abs(zslv+zoomsz/2-z));
xz = x(ixz0:ixz1);
yz = y(iyz0:iyz1);
zz = z(izz0:izz1);	% z-coords vector for zoomed sub-imstack

% reset the zoomed-view z-slider
set(handles.zoom_z_slider, 'min',    min(zz))
set(handles.zoom_z_slider, 'max',    max(zz))
set(handles.zoom_z_slider, 'value',  round(mean(zz)))
set(handles.zoom_z_tval,   'string', num2str(get(handles.zoom_z_slider,'value')))

% reset the zoomed-view y slider
set(handles.zoom_y_slider, 'min',    min(yz))
set(handles.zoom_y_slider, 'max',    max(yz))
set(handles.zoom_y_slider, 'value',  round(mean(yz)))
set(handles.zoom_y_tval,   'string', num2str(get(handles.zoom_y_slider,'value')))

% reset the zoomed-view x slider
set(handles.zoom_x_slider, 'min',    min(xz))
set(handles.zoom_x_slider, 'max',    max(xz))
set(handles.zoom_x_slider, 'value',  round(mean(xz)))
set(handles.zoom_x_tval,   'string', num2str(get(handles.zoom_x_slider,'value')))

function fsurprise(handles)
axsurprise1 = handles.norm_s_axes;
axsurprise2 = handles.zoom_f_axes;
axsurprise3 = handles.norm_b_axes;
axsurprise4 = handles.zoom_slice_axes;
axv = [axsurprise1,axsurprise2,axsurprise3,axsurprise4];
for k = 1:4
    cla(axv(k))
end 
text(axsurprise1,0.35,0.5,0.5,'THANK YOU');
text(axsurprise2,0.35,0.5,0.5,'DR. MONTAS');
text(axsurprise3,0.35,0.5,0.5,'WE LOVED');
text(axsurprise4,0.35,0.5,0.5,'BIOE241');

%Thanks for a great semester Dr. Montas!!!









