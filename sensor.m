classdef sensor
    properties(Access = public)
        FieldAngle      (1, 1)      double      = 0
        Length          (1, 1)      double      = 0
        AssemblyMatrix  (3, 3)      double      = eye(3)
        Position        (3, 1)      double      = [0; 0; 0]
        Color           (1, 1)      string      = "#7bd0dd"
        ColorAlpha      (1, 1)      double      = 0.3
        LineWidth       (1, 1)      double      = 0.5

        ReferenceObj    (1, 1)      body
    end

    methods(Access = public)
        function obj = sensor(varargin)
            len = length(varargin);
            for i = 1 : len
                if isstring(varargin{i})
                    switch varargin{i}
                        case "FieldAngle"
                            obj.FieldAngle = varargin{i + 1};
                        case "AssemblyMatrix"
                            obj.AssemblyMatrix = varargin{i + 1};
                        case "Length"
                            obj.Length = varargin{i + 1};
                        case "Position"
                            obj.Position = varargin{i + 1};
                        case "Color"
                            obj.Color = varargin{i + 1};
                        case "ColorAlpha"
                            obj.ColorAlpha = varargin{i + 1};
                        case "ReferenceObj"
                            obj.ReferenceObj = varargin{i + 1};
                    end
                end                
            end
           
        end

        function draw(obj)
            res = 0.05;

            [l, phi] = meshgrid((0 : obj.Length : obj.Length) .* tand(obj.FieldAngle),...
                                 0 : res : 2.1*pi);
            X = l .* cos(phi);
            Y = l .* sin(phi);
            Z = sqrt((X.^2 + Y.^2) ./ tand(obj.FieldAngle)^2);

            FieldAxis = [0, 0, 0; ...
                         0, 0, obj.Length];
            
            % pose transformation: sensor field
            for i = 1 : size(Z, 1)
                for j = 1 : size(Z, 2)
                    tempPos = obj.Position + obj.ReferenceObj.Attitude * obj.AssemblyMatrix * ...
                        angle2dcm(0, pi/2, 0, "ZYX")' * ...
                        [X(i, j); Y(i, j); Z(i, j)];
                    X(i, j) = tempPos(1);
                    Y(i, j) = tempPos(2);
                    Z(i, j) = tempPos(3);
                end
            end
            % pose transformation: axis
            FieldAxis = (obj.Position + obj.ReferenceObj.Attitude * obj.AssemblyMatrix * angle2dcm(0, pi/2, 0, "ZYX")' * FieldAxis')';
            tempColor = rgb2hsv(hex2rgb(obj.Color));
            tempColor(2) = 1;
            tempColor(3) = tempColor(3) - 0.2;
            if tempColor(3) < 0
                tempColor(3) = 0;
            end
            ColorAxis = rgb2hex(hsv2rgb(tempColor));
            
            surf(X, Y, Z, ...
                "EdgeColor", "none", ...
                "FaceColor", obj.Color, ...
                "FaceAlpha", obj.ColorAlpha);
            plot3(FieldAxis(:, 1), FieldAxis(:, 2), FieldAxis(:, 3), ...
                  "LineWidth",  obj.LineWidth, ...
                  "Color",      ColorAxis, ...
                  "Marker",     ".", ...
                  "MarkerSize", 15);
        end
    end
end
