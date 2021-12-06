classdef satellite
    properties(Access = public)
        Name            (1, 1)      string
        ModelSat                    modelSatellite
        ModelProperty   (1, 1)      struct
        NumMember       (1, 1)      double

        SeriesPosition              double
        SeriesAttitude              double
    end

    methods(Access = public)
        function obj = satellite(varargin)
            len = length(varargin);
            for i = 1 : len
                if isstring(varargin{i})
                    switch varargin{i}
                        case "ModelProperty"
                            obj.ModelProperty = varargin{i + 1};
                        case "Name"
                            obj.Name = varargin{i + 1};
                        case "SeriesPosition"
                            obj.SeriesPosition = varargin{i + 1};
                        case "SeriesAttitude"
                            obj.SeriesAttitude = varargin{i + 1};
                    end
                end
            end
            if length(obj.SeriesAttitude) == length(obj.SeriesPosition)
                obj.NumMember = size(obj.SeriesAttitude, 1);
            else
                error("The length of <SeriesPosition> isn't equal to the length of <SeriesAttitude>.");
            end
            
            % construct satellite visualization model object for each point
            for i = 1 : obj.NumMember
                AttitudeMatrix = angle2dcm(deg2rad(obj.SeriesAttitude(i, 1)), ...
                                           deg2rad(obj.SeriesAttitude(i, 2)), ...
                                           deg2rad(obj.SeriesAttitude(i, 3)), ...
                                           "ZYX")';
                obj.ModelSat(i) = modelSatellite("Position",      obj.SeriesPosition(i, :)', ...
                                                 "Attitude",      AttitudeMatrix, ...
                                                 "ModelProperty", obj.ModelProperty);
            end

        end

        function draw(obj)
            for i = 1 : obj.NumMember
                obj.ModelSat(i).draw();
            end
            if obj.NumMember > 2
                plot3(interp1(1 : obj.NumMember, obj.SeriesPosition(:, 1)', 1:0.1:obj.NumMember, "makima"), ...
                      interp1(1 : obj.NumMember, obj.SeriesPosition(:, 2)', 1:0.1:obj.NumMember, "makima"), ...
                      interp1(1 : obj.NumMember, obj.SeriesPosition(:, 3)', 1:0.1:obj.NumMember, "makima"), ...
                      'LineWidth', 1.5, 'Color', "#eea021");
            end
        end
        
    end
end
