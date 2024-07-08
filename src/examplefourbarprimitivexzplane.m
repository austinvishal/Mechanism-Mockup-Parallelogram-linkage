%% four bar
clc;
clear all;
close all;

%% normal four bar  - rotation around axis
% l1+l2 < l3+l4 working
% l1=8;
% l2=2;
% l3=5;
% l4=6;

%% parellogram special case: opposite link lengths are equal  - translation
l1=8;
l2=4;
l3=8; 
l4=4;

% jointfc='none';
jointfc='k';
jointec='k';
linkfc='r';
linkfc2='r';
linkec='k';
     th2=pi/3;
par=deg2rad(150);
  for th2=0:0.1:par
    %l1=fixed link, l2=crank, l3=coupler l4=output link
 %% solving the loop closure equation 
 % c_i= cos(theta_i)
 % l1 +l4c4+l3c3-l2c2=0 (1)
 % l4s4+l3s3-l2s2=0 (2)
 
 % rearranging equations we get
 % l3c3= l2c2 - (l1+l4c4)
 % l3s3= l2s2-l4s4
 
 % squaring both sides equations and adding we get a polynomial and
 % expressing it in the form
 
 % as4+bc4 = c
    a= sin(th2);
    b=(cos(th2)-(l1/l2));
    c=-(l1/l4)*cos(th2)+(((l1)^2+(l2)^2+(l4)^2-(l3^2))/(2*l2*l4));
    
     th41=2*atan((a-sqrt(a^2+b^2-c^2))/(b+c));
     th42=2*atan((a+sqrt(a^2+b^2-c^2))/(b+c));
%     th41=2*atan2((a-sqrt(a.^2+b.^2-c.^2)),(b+c));
%     th42=2*atan2((a+sqrt(a.^2+b.^2-c.^2)),(b+c));

    d=-(l1/l3)*cos(th2)+((l1^2+l2^2+l3^2-l4^2)/(2*l2*l3));
    
     th31=2*atan((a-sqrt(a^2+b^2-d^2))/(b+d));
     th32=2*atan((a+sqrt(a^2+b^2-d^2))/(b+d));
%    th31=2*atan2((a-sqrt(a^2+b^2-d^2)),(b+d));
%    th32=2*atan2((a+sqrt(a^2+b^2-d^2)),(b+d));
 
    %% plot joints
    % joint 1 at base
    [x2,y2,z2] = cylinder(0.5,10);
    x2=x2*0.5;
y2=y2*0.5;
 z2 = z2*0.5;
 p01=[0; 0; 0;];
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
    cylin = [eye(3) p01; 0 0 0 1]*[x2(i,:); z2(i,:)-0.5/2; y2(i,:); ones(1,11)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
%  camlight
  light('Position',[2 10 10],'Style','infinite')
  lighting gouraud
patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
text(p01(1)-1,p01(2)-1,p01(3),'A','fontsize',14,'Interpreter', 'latex');
hold on

%joint 2 at base
 [x2,y2,z2] = cylinder(0.5,10);
 x2=x2*0.5;
y2=y2*0.5;
 z2 = z2*0.5;
 p04=[l1; 0; 0;];
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
    cylin = [eye(3) p04; 0 0 0 1]*[x2(i,:); z2(i,:)-0.5/2; y2(i,:); ones(1,11)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
p=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
%  shading interp
lightangle(-45,30)
% p.AmbientStrength = 0.3;
% p.DiffuseStrength = 0.8;
% p.SpecularStrength = 0.9;
% p.SpecularExponent = 25;
% p.BackFaceLighting = 'unlit';
patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
text(p04(1)+0.5,p04(2)+0.5,p04(3),'D','fontsize',14,'Interpreter', 'latex');

% joint3 
[x2,y2,z2] = cylinder(0.5,10);
 x2=x2*0.5;
y2=y2*0.5;
 z2 = z2*0.5;
%  p04=[l2*cos(th2); l2*sin(th2); 0;];
p04=[l2*cos(th2); 0; l2*sin(th2);];
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
    cylin = [eye(3) p04; 0 0 0 1]*[x2(i,:); z2(i,:)-0.5/2; y2(i,:); ones(1,11)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
%   lighting gouraud
patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
text(p04(1)-1.25,p04(2)-1,p04(3)+0.75,'B','fontsize',14,'Interpreter', 'latex');
% joint4 
[x2,y2,z2] = cylinder(0.5,10);
 x2=x2*0.5;
y2=y2*0.5;
 z2 = z2*0.5;
%  p04=[l1+l4*cos(th41); l4*sin(th41); 0;];
p04=[l1+l4*cos(th41);  0; l4*sin(th41);];
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
    cylin = [eye(3) p04; 0 0 0 1]*[x2(i,:); z2(i,:)-0.5/2; y2(i,:); ones(1,11)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
%   lighting gouraud
patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:10],'FaceColor',jointfc, ...
'EdgeColor',jointec,'AmbientStrength',0.6)
text(p04(1)+0.5,p04(2)+0.5,p04(3),'C','fontsize',14,'Interpreter', 'latex');
%% plot the links
hold on
[vert2,face2] =rectangular(1,0.25,0.25)
vert3= [vert2(:,1)*l1+l1/2 vert2(:,3) vert2(:,2) ones(8,1)]';
p=patch('Vertices',vert3(1:3,:)','Faces',face2,'FaceColor',linkfc, ...
'Facealpha',1,'EdgeColor',linkec,'AmbientStrength',0.6),
%  shading interp
% lightangle(-45,30)

hold on
[vert2,face2] =rectangular(1,0.25,0.25)
% vert3= [cos(th2) -sin(th2) 0 0;
%     sin(th2) cos(th2) 0 0
%     0 0 1 0
%     0 0 0 1]*[vert2(:,1)*l2+l2/2 vert2(:,3) vert2(:,2) ones(8,1)]';
vert3= [cos(th2)  0 -sin(th2) 0;
    0  1  0 0
    sin(th2) 0 cos(th2) 0
    0 0 0 1]*[vert2(:,1)*l2+l2/2 vert2(:,2) vert2(:,3) ones(8,1)]';
p=patch('Vertices',vert3(1:3,:)','Faces',face2,'FaceColor',linkfc2, ...
'Facealpha',1,'EdgeColor',linkec,'AmbientStrength',0.6),
hold on
[vert2,face2] =rectangular(1,0.25,0.25)
% vert3= [cos(pi+th32) -sin(pi+th32) 0 l2*cos(th2);
%     sin(pi+th32) cos(pi+th32) 0 l2*sin(th2)
%     0 0 1 0
%     0 0 0 1]*[vert2(:,1)*l3+l3/2 vert2(:,2) vert2(:,3) ones(8,1)]';
vert3= [cos(pi+th32)  0 -sin(pi+th32) l2*cos(th2);
    0  1 0 0
    sin(pi+th32) 0 cos(pi+th32) l2*sin(th2)
    0 0 0 1]*[vert2(:,1)*l3+l3/2 vert2(:,2) vert2(:,3) ones(8,1)]';
p=patch('Vertices',vert3(1:3,:)','Faces',face2,'FaceColor',linkfc, ...
'Facealpha',1,'EdgeColor',linkec,'AmbientStrength',0.6),

hold on
[vert2,face2] =rectangular(1,0.25,0.25)
% vert3= [cos(th41) -sin(th41) 0 l1;  %changed the x coordinate to l1 for parallelogram case
%     sin(th41) cos(th41) 0 0;
%     0 0 1 0;
%     0 0 0 1]*[vert2(:,1)*l4+l4/2 vert2(:,2) vert2(:,3) ones(8,1)]';
vert3= [cos(th41)  0 -sin(th41) l1;  %changed the x coordinate to l1 for parallelogram case
    0  1 0 0;
    sin(th41) 0 cos(th41) 0;
    0 0 0 1]*[vert2(:,1)*l4+l4/2 vert2(:,2) vert2(:,3) ones(8,1)]';
p=patch('Vertices',vert3(1:3,:)','Faces',face2,'FaceColor',linkfc, ...
'Facealpha',1,'EdgeColor',linkec,'AmbientStrength',0.6),


   %% plot zero pitch constraint screws
    %% Parameters
Xt = [0; 0; 0]; % tail point of vector
% Xh = [1; 1; 1]; % head point of vector
Xh = [0; -4; 0]; % head point of vector
screwarrowR3( Xt, Xh,'N',12,'ArrowHeadLength',0.395,'ArrowHeadColor',[1 0 0],...
'ArrowHeadRadius',0.065,'ArrowHeadBackColor',[0 0 0],...
    'AHeadalpha',0.3,'ecshaftcolor','k' )
hold on
Xt = [0; 0; 0]; % tail point of vector
Xh = [l1*cos(th2); 0; l1*sin(th2)]; % head point of vector
screwarrowR3( Xt, Xh,'N',12,'ShaftRadius',0.0085,'ArrowHeadLength',0.095,'ArrowHeadRadius',0.019,...
    'ArrowHeadColor',[1 0 0],'ArrowHeadBackColor',[0 0 0],...
    'AHeadalpha',0.3,'ecshaftcolor','k','scalefactorz',1 )
hold on
Xt = [l1; 0; 0]; % tail point of vector
% Xh = [1; 1; 1]; % head point of vector
Xh = [l1+l4*cos(th41); 0; l4*sin(th41)]; % head point of vector
screwarrowR3( Xt, Xh,'N',12,'ShaftRadius',0.0125,'ArrowHeadLength',0.135,'ArrowHeadRadius',0.035,...
    'ArrowHeadColor',[1 0 0],'ArrowHeadBackColor',[0 0 0],...
    'AHeadalpha',0.3,'ecshaftcolor','k','scalefactorz',1.5 )
 %% plot infinite pitch constraint screws
 Xt = [-2; -2; 0]; % tail point of vector
 Xh = [-2; -2; 2]; % head point of vector
 screwarrowR3( Xt, Xh,'N',4,'ArrowHeadLength',0.445,'ArrowHeadRadius',0.235,...
    'ArrowHeadBackColor',[1 0 0],'ArrowHeadColor',[1 0 0],...
    'AHeadalpha',1,'ecshaftcolor','k','ShaftColor','r','isconstraintcouple',1)

Xt = [-2.5; -2; 0]; % tail point of vector
 Xh = [-4.5; -2; 0]; % head point of vector
 screwarrowR3( Xt, Xh,'N',4,'ShaftRadius',0.0225,'ArrowHeadLength',0.445,'ArrowHeadRadius',0.235,...
    'ArrowHeadBackColor',[1 0 0],'ArrowHeadColor',[1 0 0],...
    'AHeadalpha',1,'ecshaftcolor','k','ShaftColor','r','isconstraintcouple',1)
     %% axis setting
%      grid on
       axis([-8 16 -6 8 -4 8]);

 view(3)
view(-17.255297536307953,19.553301568479569)
set(gca, 'CameraPosition', [-32.23468274323638 -119.4889793139063 47.183200678267085]);

set(gca, 'FontName', 'Times', 'FontSize', 18)
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$z$', 'Interpreter', 'latex')
     box on
     hold off
     
     pause(0.1)
     

  end


