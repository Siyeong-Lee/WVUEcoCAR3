detector = vision.CascadeObjectDetector('WVUstopSignDetector3.xml','MinSize',[30,30],'MergeThreshold',6);%,'MaxSize',[400,400]);

% Test Single Image
%bbox = step(detector, test);
%J = insertShape( test,'rectangle',bbox);
%imshow(J)
%release(detector)

% Load input
vid = VideoReader('stopSignVideo2.mp4');
numberofFrames = vid.NumberOfFrames
fprintf('Video File: %s\n',vid.Name);

VP = vision.DeployableVideoPlayer;
i = 500;
while i<= numberofFrames
    if (mod(i,100) == 0)
        fprintf('Processing frame %d\n',i);
    end
   % if (mod(i,4)== 0)
        cdata = read(vid, i);
        cdata = imresize(cdata, 0.5);
%         hsv = rgb2hsv(cdata);
%         hChannel = hsv(:,:,1);
%         sChannel = hsv(:,:,2);
%         vChannel = hsv(:,:,2);
%         sChannel = sChannel * 2;
%         hsv = cat(3, hChannel, sChannel, vChannel);
%         cdata =  hsv2rgb(hsv);
        bbox = step(detector, cdata);
        frame = insertObjectAnnotation(cdata,'rectangle',bbox,'Stop');
        step(VP,frame);
   % end
    i=i+1;
end
% Clean uprelease(detector)
release(VP)

%SAS = evaluateObjectDetector(GTS, 'groundtruthfunc', 'vehicle');