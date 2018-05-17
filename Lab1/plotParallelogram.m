function plotParallelogram(x1,y1,x2,y2,x3,y3)
    hold on;
    plot([y1 ,y2 ,y2+y3-y1,y3,y1],[x1,x2,x2+x3-x1,x3,x1],'y','LineWidth',1);
    text(y1,x1,'1','Color',[0,1,0],'FontSize',12);
    text(y2,x2,'2','Color',[0,1,0],'FontSize',12);
    text(y3,x3,'3','Color',[0,1,0],'FontSize',12); 
    hold off
end
    