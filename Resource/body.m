classdef body
    properties(Access = public)
        CubeBody    (1, 1)      toybrick
        Inertial    (1, 1)      inertialSymbol

        Size        (3, 1)      double      = [0; 0; 0] 
        Position    (3, 1)      double      = [0; 0; 0]
        Attitude    (3, 3)      double      = eye(3)     
        Color       (1, 1)      string      = "#d5d7db"
        ColorAlpha  (1, 1)      double      = 0.7
        LineWidth   (1, 1)      double      = 0.5
    end
    
    methods(Access = public)
        function obj = body(varargin)
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
            
            obj.CubeBody = toybrick("Size",       obj.Size, ...
                                    "Position",   [0; 0; 0], ...
                                    "Attitude",   obj.Attitude, ...
                                    "Color",      obj.Color, ...
                                    "ColorAlpha", obj.ColorAlpha, ...
                                    "LineWidth",  obj.LineWidth);
            obj.CubeBody.Position = obj.Position;
            obj.CubeBody.verts = obj.CubeBody.verts + obj.Position';

            obj.Inertial.Radius = max(obj.CubeBody.Size) / 5;
            obj.Inertial.Position = obj.CubeBody.Position;
        end

        function draw(obj)
            obj.CubeBody.draw();
            obj.Inertial.draw();
        end
    end
end
