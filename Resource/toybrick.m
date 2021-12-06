classdef toybrick  
    properties(Access = public)
        Size        (3, 1)      double      = [0, 0, 0]
        Position    (3, 1)      double      = [0, 0, 0]
        Attitude    (3, 3)      double      = eye(3)
        Color       (1, 1)      string      = "w"
        ColorAlpha  (1, 1)      double      = 0
        LineWidth   (1, 1)      double      = 0.5
    end
    properties(Access = public)
        verts       (8, 3)      double
        faces       (6, 4)      double
    end
    
    methods(Access = public)
        function obj = toybrick(varargin)
            len = length(varargin);
            for i = 1 : len
                if isstring(varargin{i})
                    switch varargin{i}
                        case "Size"
                            obj.Size = varargin{i + 1};
                        case "Position"
                            obj.Position = varargin{i + 1};
                        case "Attitude"
                            obj.Attitude = varargin{i + 1};
                        case "Color"
                            obj.Color = varargin{i + 1};
                        case "ColorAlpha"
                            obj.ColorAlpha = varargin{i + 1};
                        case "LineWidth"
                            obj.LineWidth = varargin{i + 1};
                    end
                end
            end

            % load cube definition from the input
            x = obj.Size(1);
            y = obj.Size(2);
            z = obj.Size(3);

            % define verts and faces of cube
            obj.verts = [ x/2   -y/2   -z/2;
                          x/2    y/2   -z/2;
                         -x/2    y/2   -z/2;
                         -x/2   -y/2   -z/2;
                          x/2   -y/2    z/2;
                          x/2    y/2    z/2;
                         -x/2    y/2    z/2;
                         -x/2   -y/2    z/2];
            obj.faces = [1   2   3   4;
                         1   2   6   5;
                         2   3   7   6;
                         3   4   8   7;
                         4   1   5   8;
                         5   6   7   8];
  
            % transforamtion
            obj.verts = (obj.Attitude * (obj.verts' + obj.Position))';
        end

        function draw(obj)
            faceColor      = obj.Color;
            faceColorAlpha = obj.ColorAlpha;
            lineWidth      = obj.LineWidth; 

            % plot cube in figure
            patch('Faces', obj.faces, 'Vertices', obj.verts, ...
                  "FaceColor",  faceColor       , ...
                  "FaceAlpha",  faceColorAlpha  , ...
                  "EdgeColor",  "black"         , ...
                  "LineWidth",  lineWidth       , ...
                  "LineJoin" ,  "round"         , ...
                  "Marker"   ,  "none"          );
        end
    end
end
