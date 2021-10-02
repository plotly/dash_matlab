function plotlyFig = updateGraph(freq1, freq2, amp1, amp2, noiseButton)
    F1 = double(freq1);
    F2 = double(freq2);
    A1 = double(amp1);
    A2 = double(amp2);
    
    % Signal
    subplot(2,1,1);
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = 1500;             % Length of signal
    t = (0:L-1)*T;        % Time vector 
    S = A1*sin(2*pi*F1*t) + A2*sin(2*pi*F2*t);
    if strcmp(string(noiseButton), 'true')
        X = S + 2*randn(size(t));
    else
        X = S;
    end
    plot(1000*t(1:50),X(1:50))
    title(A1+"&#183;sin(2&#183;&#960;&#183;"+F1+"&#183;t)+"+...
        A2+"&#183;sin(2&#183;&#960;&#183;"+F2+"&#183;t)", 'FontSize', 16)
    xlabel('t (milliseconds)', 'FontSize', 14)
    ylabel('X(t)', 'FontSize', 14)
    
    % Compute FFT
    subplot(2,1,2);
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1) 
    title('Single-Sided Amplitude Spectrum of X(t)', 'FontSize', 16)
    xlabel('f (Hz)', 'FontSize', 14)
    ylabel('|P1(f)|', 'FontSize', 14)

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    
    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end