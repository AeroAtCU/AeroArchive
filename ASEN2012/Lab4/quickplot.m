function quickplot(titletext)
% for making master a little smaller and easier to follow.

figure; hold on;
set(gca,'FontSize',14)
title(titletext)
axis([0 80 0 25])
xlabel('X Position (m)')
ylabel('Z Position (m)')
end