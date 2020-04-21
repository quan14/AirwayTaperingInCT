% Function by Ashkan Pakzad (ashkanpakzad.github.io) on 21st April 2020.
% 
% MIT License
% 
% Copyright (c) 2020 Ashkan Pakzad
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

function ShowTaperImages(tapermatfilename)
% loads in output of single tapering result from AirwayTaperingInCT 
% by Kin Quan (https://github.com/quan14/AirwayTaperingInCT)

% INPUT: filename of mat file output from tapering software include '.mat'
% suffix.
% OUTPUT: plots interactive figure showing metrics overlaid with ray cast
% stopping points and final ellipse fitted to results.
% EXAMPLE: 
% ShowTaperImages('P_CTcase_1_A_23623484.mat')

% load in the tapering .mat file
load(tapermatfilename,'sturct_to_save')
taper_result = sturct_to_save;

% extract saved results
cross_images = [taper_result.tapering_raw_image.resample_image];
info = cell2mat(taper_result.tapering_raw_image.area_results.elliptical_info);
lumen_x = {info(:).x_stop}';
lumen_y = {info(:).y_stop}';
lumen_area = [taper_result.tapering_raw_image.area_results.phyiscal_area];
arc_length = [taper_result.tapering_raw_image.arclegth];
ellipses = {info(:).elipllical_info}';

% Plot resampled airway slices overlayed with FWHMesl ray cast
% points and fitted ellipse
f = figure('Position',  [100, 100, 850, 600]);
slide = 1;
numSteps = size(cross_images, 3);
PlotAirway(slide)

% set up slider controls
b = uicontrol('Parent',f,'Style','slider','Position',[50,10,750,23],...
    'value',slide, 'min',1, 'max',numSteps, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1)]);
bgcolor = f.Color;
uicontrol('Parent',f,'Style','text','Position',[25,10,23,23],...
    'String', '1','BackgroundColor',bgcolor);
uicontrol('Parent',f,'Style','text','Position',[800,10,23,23],...
    'String',numSteps,'BackgroundColor',bgcolor);

b.Callback = @sliderselect;

    function sliderselect(src,event)
        val=round(b.Value);
        PlotAirway(val);
    end


    function PlotAirway(slide)
        % display image
        imagesc(cross_images(:,:,slide))
        hold on
        colormap gray
        
        % plot ray cast results
        plot(lumen_x{slide,1}, lumen_y{slide,1},'r.')
        
        % plot ellipse fitting
        ellipse(ellipses{slide,1}(3),ellipses{slide,1}(4), ...
            ellipses{slide,1}(5), ellipses{slide,1}(1), ...
            ellipses{slide,1}(2), 'm')
        
        % display area measurements
        rectangle('Position',[0,0,133,10],'FaceColor','y','LineWidth',2);
        ax = gca;
        
        text(ax, 1,5,sprintf('Arc Length = %4.1f mm; Inner area = %4.2f mm^2; %3.0i of %3.0i', ...
            arc_length(slide), lumen_area(slide), slide, numSteps));
        
    end
end