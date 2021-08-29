terminate(pyenv);

%create ui grid
uifig = uifigure('visible', 'on');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

%create tab group with tabs
tg = uitabgroup(uigr);
tg.Layout.Row = [1 8];
tg.Layout.Column = [ 1 8];
t1 = uitab(tg,'Title','Member Information');
t2 = uitab(tg,'Title','Me');
dd = uidropdown(t1,'Items',{'Male','Female'});
dd.Position=[100 200 100 20];
cb = uicheckbox(t2,'Text','Member');
%add axes
ax=axes(t1);
ax.Position=[0.13 .11 .77 .5];
plot(ax, 1:10, rand(10,1))

ax=axes(t2);
ax.Position=[0.13 .11 .77 .5];
plot(ax, 1:10, rand(10,1))

%start app
app=start_dash(uigr, 8057);
