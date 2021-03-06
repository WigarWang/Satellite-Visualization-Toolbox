classdef sailboard
    properties(Access = public)
        PartBoard       (3, 3)      toybrick
        Interval        (2, 2)      toybrick
        
        AssemblyMatrix  (3, 3)      double      = eye(3)
        Size            (3, 1)      double      = [0; 0; 0]
        Position        (3, 1)      double      = [0; 0; 0]
        Color           (2, 1)      string      = ["w"; "#3e53a4"]
        ColorAlpha      (2, 1)      double      = [0; 0]
        LineWidth       (1, 1)      double      = 0.5;

        ReferenceObj    (1, 1)      body
    end
    
    methods(Access = public)
        function obj = sailboard(varargin)
            len = length(varargin);
            for i = 1 : len
                if isstring(varargin{i})
                    switch varargin{i}
                        case "AssemblyMatrix"
                            obj.AssemblyMatrix = varargin{i + 1};
                        case "Size"
                            obj.Size = varargin{i + 1};
                        case "Position"
                            obj.Position = varargin{i + 1};
                        case "Color"
                            obj.Color = varargin{i + 1};
                        case "ColorAlpha"
                            obj.ColorAlpha = varargin{i + 1};
                        case "LineWidth"
                            obj.LineWidth = varargin{i + 1};
                        case "ReferenceObj"
                            obj.ReferenceObj = varargin{i + 1};
                    end
                end                
            end

            % calculate the sub-part of the sailborad
            SizeInterval_row = [obj.Size(1); ...
                                obj.Size(2) / 10; ...
                                obj.Size(3) ];
            SizeInterval_col = [obj.Size(2) / 10; ...
                                obj.Size(2); ...
                                obj.Size(3) ];
            SizePartboard = [(obj.Size(1) - 2 * SizeInterval_row(2)) / 3; ...
                             (obj.Size(2) - 2 * SizeInterval_col(1)) / 3; ...
                             obj.Size(3) ];

            Interval(1, 1).Size = SizeInterval_row;
            Interval(2, 1).Size = SizeInterval_row;
            Interval(1, 2).Size = SizeInterval_col;
            Interval(2, 2).Size = SizeInterval_col;

            Interval(1, 1).Position = [obj.Position(1), ...
                                       obj.Position(2) + 0.5 * (SizeInterval_row(2) + SizePartboard(2)), ...
                                       obj.Position(3) ];
            Interval(2, 1).Position = [obj.Position(1), ...
                                       obj.Position(2) - 0.5 * (SizeInterval_row(2) + SizePartboard(2)), ...
                                       obj.Position(3) ];
            Interval(1, 2).Position = [obj.Position(1) - 0.5 * (SizeInterval_col(1) + SizePartboard(1)) , ...
                                       obj.Position(2), ...
                                       obj.Position(3) ];
            Interval(2, 2).Position = [obj.Position(1) + 0.5 * (SizeInterval_col(1) + SizePartboard(1)) , ...
                                       obj.Position(2), ...
                                       obj.Position(3) ];
            
            obj.Interval(1, 1) = toybrick("Size",       Interval(1, 1).Size, ...
                                          "Position",   Interval(1, 1).Position, ...
                                          "Attitude",   obj.AssemblyMatrix, ...
                                          "Color",      obj.Color(1), ...
                                          "ColorAlpha", obj.ColorAlpha(1), ...
                                          "LineWidth",  obj.LineWidth);
            obj.Interval(1, 2) = toybrick("Size",       Interval(1, 2).Size, ...
                                          "Position",   Interval(1, 2).Position, ...
                                          "Attitude",   obj.AssemblyMatrix, ...
                                          "Color",      obj.Color(1), ...
                                          "ColorAlpha", obj.ColorAlpha(1), ...
                                          "LineWidth",  obj.LineWidth);
            obj.Interval(2, 1) = toybrick("Size",       Interval(2, 1).Size, ...
                                          "Position",   Interval(2, 1).Position, ...
                                          "Attitude",   obj.AssemblyMatrix, ...
                                          "Color",      obj.Color(1), ...
                                          "ColorAlpha", obj.ColorAlpha(1), ...
                                          "LineWidth",  obj.LineWidth);
            obj.Interval(2, 2) = toybrick("Size",       Interval(2, 2).Size, ...
                                          "Position",   Interval(2, 2).Position, ...
                                          "Attitude",   obj.AssemblyMatrix, ...
                                          "Color",      obj.Color(1), ...
                                          "ColorAlpha", obj.ColorAlpha(1), ...
                                          "LineWidth",  obj.LineWidth);
            obj.Interval(1, 1).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.Interval(1, 1).verts')';
            obj.Interval(1, 2).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.Interval(1, 2).verts')';
            obj.Interval(2, 1).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.Interval(2, 1).verts')';
            obj.Interval(2, 2).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.Interval(2, 2).verts')';

%             obj.Interval(1, 1).Position = obj.AssemblyMatrix * obj.Interval(1, 1).Position;
%             obj.Interval(2, 1).Position = obj.AssemblyMatrix * obj.Interval(2, 1).Position;
%             obj.Interval(1, 2).Position = obj.AssemblyMatrix * obj.Interval(1, 2).Position;
%             obj.Interval(2, 2).Position = obj.AssemblyMatrix * obj.Interval(2, 2).Position;

            PartBoard(1, 1).Size = SizePartboard;
            PartBoard(1, 2).Size = SizePartboard;
            PartBoard(1, 3).Size = SizePartboard;
            PartBoard(2, 1).Size = SizePartboard;
            PartBoard(2, 2).Size = SizePartboard;
            PartBoard(2, 3).Size = SizePartboard;
            PartBoard(3, 1).Size = SizePartboard;
            PartBoard(3, 2).Size = SizePartboard;
            PartBoard(3, 3).Size = SizePartboard;

            PartBoard(1, 1).Position = [obj.Position(1) - (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2) + (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];
            PartBoard(2, 1).Position = [obj.Position(1) - (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2), ...
                                        obj.Position(3) ];
            PartBoard(3, 1).Position = [obj.Position(1) - (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2) - (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];
            PartBoard(1, 2).Position = [obj.Position(1), ...
                                        obj.Position(2) + (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];
            PartBoard(2, 2).Position = [obj.Position(1), ...
                                        obj.Position(2), ...
                                        obj.Position(3) ];
            PartBoard(3, 2).Position = [obj.Position(1), ...
                                        obj.Position(2) - (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];
            PartBoard(1, 3).Position = [obj.Position(1) + (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2) + (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];
            PartBoard(2, 3).Position = [obj.Position(1) + (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2), ...
                                        obj.Position(3) ];
            PartBoard(3, 3).Position = [obj.Position(1) + (SizePartboard(1) + SizeInterval_col(1)), ...
                                        obj.Position(2) - (SizePartboard(2) + SizeInterval_row(2)), ...
                                        obj.Position(3) ];

            obj.PartBoard(1, 1) = toybrick("Size",       PartBoard(1, 1).Size, ...
                                           "Position",   PartBoard(1, 1).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(1, 2) = toybrick("Size",       PartBoard(1, 2).Size, ...
                                           "Position",   PartBoard(1, 2).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(1, 3) = toybrick("Size",       PartBoard(1, 3).Size, ...
                                           "Position",   PartBoard(1, 3).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(2, 1) = toybrick("Size",       PartBoard(2, 1).Size, ...
                                           "Position",   PartBoard(2, 1).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(2, 2) = toybrick("Size",       PartBoard(2, 2).Size, ...
                                           "Position",   PartBoard(2, 2).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(2, 3) = toybrick("Size",       PartBoard(2, 3).Size, ...
                                           "Position",   PartBoard(2, 3).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(3, 1) = toybrick("Size",       PartBoard(3, 1).Size, ...
                                           "Position",   PartBoard(3, 1).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(3, 2) = toybrick("Size",       PartBoard(3, 2).Size, ...
                                           "Position",   PartBoard(3, 2).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(3, 3) = toybrick("Size",       PartBoard(3, 3).Size, ...
                                           "Position",   PartBoard(3, 3).Position, ...
                                           "Attitude",   obj.AssemblyMatrix, ...
                                           "Color",      obj.Color(2), ...
                                           "ColorAlpha", obj.ColorAlpha(2), ...
                                           "LineWidth",  obj.LineWidth);
            obj.PartBoard(1, 1).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(1, 1).verts')';
            obj.PartBoard(1, 2).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(1, 2).verts')';
            obj.PartBoard(1, 3).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(1, 3).verts')';
            obj.PartBoard(2, 1).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(2, 1).verts')';
            obj.PartBoard(2, 2).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(2, 2).verts')';
            obj.PartBoard(2, 3).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(2, 3).verts')';
            obj.PartBoard(3, 1).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(3, 1).verts')';
            obj.PartBoard(3, 2).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(3, 2).verts')';
            obj.PartBoard(3, 3).verts = (obj.ReferenceObj.Position + obj.ReferenceObj.Attitude * obj.PartBoard(3, 3).verts')';

%             obj.PartBoard(1, 1).Position = obj.AssemblyMatrix * obj.PartBoard(1, 1).Position;
%             obj.PartBoard(1, 2).Position = obj.AssemblyMatrix * obj.PartBoard(1, 2).Position;
%             obj.PartBoard(1, 3).Position = obj.AssemblyMatrix * obj.PartBoard(1, 3).Position;
%             obj.PartBoard(2, 1).Position = obj.AssemblyMatrix * obj.PartBoard(2, 1).Position;
%             obj.PartBoard(2, 2).Position = obj.AssemblyMatrix * obj.PartBoard(2, 2).Position;
%             obj.PartBoard(2, 3).Position = obj.AssemblyMatrix * obj.PartBoard(2, 3).Position;
%             obj.PartBoard(3, 1).Position = obj.AssemblyMatrix * obj.PartBoard(3, 1).Position;
%             obj.PartBoard(3, 2).Position = obj.AssemblyMatrix * obj.PartBoard(3, 2).Position;
%             obj.PartBoard(3, 3).Position = obj.AssemblyMatrix * obj.PartBoard(3, 3).Position;
        end

        function draw(obj)
            obj.Interval(1, 1).draw();
            obj.Interval(1, 2).draw();
            obj.Interval(2, 1).draw();
            obj.Interval(2, 2).draw();

            obj.PartBoard(1, 1).draw();
            obj.PartBoard(2, 1).draw();
            obj.PartBoard(3, 1).draw();
            obj.PartBoard(1, 2).draw();
            obj.PartBoard(2, 2).draw();
            obj.PartBoard(3, 2).draw();
            obj.PartBoard(1, 3).draw();
            obj.PartBoard(2, 3).draw();
            obj.PartBoard(3, 3).draw();
        end
    end
end
