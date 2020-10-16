function [undistorted] = UndistortImage(image, LUT)
  
% UndistortImage - undistort an image using a lookup table
% 
% [undistorted] = UndistortImage(image, LUT)
%
% eg.
% [ ~, ~, ~, ~, ~, LUT] = ...
%     ReadCameraModel('<models_dir>/stereo_wide_left_undistortion.bin');
% image = imread('<image_dir>/<timestamp>.png');
% undistorted = UndistortImage(image, LUT);
%
% INPUTS:
%   image: distorted image to be rectified
%   LUT: lookup table mapping pixels in the undistorted image to pixels in the
%     distorted image, as returned from ReadCameraModel
%
% OUTPUTS:
%   undistorted: image after undistortion


undistorted = zeros(size(image), class(image));

for channel = 1:size(image,3)
  % Interpolate pixels from distorted image using lookup table
  channel_data = cast(reshape(interp2(cast(image(:,:,channel), 'single'), ...
                               LUT(:,1)+1, ...
                               LUT(:,2)+1, ...
                               'bilinear'), ...
                     fliplr(size(image(:,:,channel)))).', class(image));
  
  undistorted(:,:,channel) = channel_data;
end

end
