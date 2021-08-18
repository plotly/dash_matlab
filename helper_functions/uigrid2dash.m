%convert matlab ui grid to dash
function ui_dash = uigrid2dash(chldrn)
    %chldrn
    chln=length(chldrn);
    ver=[1 1]; 
    hor=[1 1];
    occrow=int16.empty(0,2);
    occol=int16.empty(0,2);
    for i=1:chln
        
        row=chldrn(i).Layout.Row;
        col=chldrn(i).Layout.Column;

        if length(row)==1
            row(2)=row(1);
        end
        if length(col)==1
            col(2)=col(1);
        end
        % get borders
        for r=row(1):row(2)
            for c=col(1):col(2)
                occrow(end+1,:)= [r c];
                occrow(end+1,:)= [r+1 c];
                occol(end+1,:)= [r c];
                occol(end+1,:)= [r c+1];
                
                %row lims
                if r==row(1) && row(1)==row(2)
                    hor(end+1,:)=[row(1) c];
                    hor(end+1,:)=[row(1)+1 c];
                elseif  r==row(1) && row(1)~=row(2)
                    hor(end+1,:)=[row(1) c];
                elseif r==row(2) && row(1)~=row(2)
                    hor(end+1,:)=[row(2)+1 c];
                end

                %col lims
                if c==col(1) && col(1)==col(2)
                    ver(end+1,:)=[r col(1)];
                    ver(end+1,:)=[r col(1)+1];
                elseif  c==col(1) && col(1)~=col(2)
                    ver(end+1,:)=[r col(1)];
                elseif  c==col(2) && col(1)~=col(2)
                    ver(end+1,:)=[r col(2)+1];
                end
            end
        end
    end
    %horiz and vert borders of elements
    hor=unique(hor,'rows');
    ver=unique(ver,'rows');
    occrow=unique(occrow,'rows');
    occol=unique(occol,'rows');
    fulr=1;
    fulc=1;
    empr=zeros(13,1);
    %get r delims
    for r=1:13
        bor=1;
        empt_part_row=0;
        full_empt=1;
        for c=1:12
            %mark empty rows
            if ~ismember([r c],occrow,'rows')
                empt_part_row=1;
            else
                full_empt=0;
            end
            %mark if border broke
            if ~ismember([r c],hor,'rows') && ismember([r c],occrow,'rows')
                bor=0;
            end
        end
        %add if full border present and non empty row
        if bor && ~full_empt
            fulr(end+1)=r;
        end     
        %check if full empty
        if full_empt
            empr(r)=1;
        end
    end
    emprln=length(empr(empr==1)); %fully empty rows count
    % if no full rows, search columns
    %get c delims
    for c=2:12
        bor=1;
        for r=1:12
            if ~(ismember([r c],ver,'rows') || ~ismember([r c],occol,'rows'))
                bor=0;
            end
        end
        if bor
            fulc(end+1)=c;
        end
    end
        
    % start recursive walk
    fulr(end+1) = 13;
    fulc(end+1) = 13;
    fulrowln = length(fulr);
    fulcolln = length(fulc);
    bordchl=gobjects(0);
    chilcols={};
    res={};
    %nest rows
    if fulrowln>3 && emprln<11   
        for ir=1:fulrowln-1
            for ic = 1:chln
                ch=chldrn(ic);
                if ch.Layout.Row(1) >= fulr(ir) && ch.Layout.Row(end) < fulr(ir+1)
                    bordchl(end+1)=ch;
                end
            end
            bordln=length(bordchl);
            if ~bordln
                continue
            elseif bordln==1
                res{end+1} = py.dash_bootstrap_components.Row(py.dash_bootstrap_components.Col(ui2dash(bordchl, bordchl.UserData)));
            else
                res{end+1} = py.dash_bootstrap_components.Row(uigrid2dash(bordchl));
            end
            bordchl=gobjects(0);
        end
        ui_dash=res;
    % if no row border but there are columns
    elseif (fulrowln<4 || (fulrowln>3 && emprln >= 11)) && chln>1 
        for ic=1:fulcolln-1
             for indch = 1:chln
                ch=chldrn(indch);
                 if ch.Layout.Column(1) >= fulc(ic) && ch.Layout.Column(end) < fulc(ic+1)
                    chilcols{end+1}=ui2dash(ch, ch.UserData);
                 end
             end
            res{end+1} = py.dash_bootstrap_components.Col(chilcols);
            chilcols={};
            
        end
        ui_dash=res;
    %if no row&col border  then it is 1 element
    elseif chln == 1
        bordchl = chldrn;
        ui_dash = ui2dash(bordchl, bordchl.UserData);        
    end
    
end
