format long
g1 = GaussD('Mean', [3; 3], 'Covariance', [0.01 0; 0 0.01]);
g2 = GaussD('Mean', [0; 0], 'Covariance', [0.01 0.01; 0.01 0.01]);
mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
h = HMM(mc, [g1, g2]);
emissions = h.rand(100);
plot(1:100, emissions(1,:));
hold on
plot(1:100, emissions(2,:));
hold off