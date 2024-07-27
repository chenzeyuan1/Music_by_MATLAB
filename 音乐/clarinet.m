function y = clarinet(pitch,time)
% 设置采样频率
fs = 44100; % 采样频率 (Hz)

duration = time; 
t = 0:1/fs:duration; 

% 基频和谐波频率
f0 = pitch/(2*pi);
harmonics = [1, 3, 5, 7, 9, 11, 13]; % 单簧管的奇次谐波
amplitudes = [1, 0.8, 0.6, 0.4, 0.3, 0.2, 0.1]; % 谐波幅度

% 包络生成
attackTime = 0.1; % 攻击时间 (秒)
decayTime = 0.2; % 衰减时间 (秒)
sustainLevel = 0.7; % 持续电平
releaseTime = 0.5; % 释放时间 (秒)

% 计算包络的长度
attackSamples = round(attackTime * fs);
decaySamples = round(decayTime * fs);
releaseSamples = round(releaseTime * fs);
sustainSamples = length(t) - (attackSamples + decaySamples + releaseSamples);

% 生成包络
envelope = [linspace(0, 1, attackSamples), ...
            linspace(1, sustainLevel, decaySamples), ...
            sustainLevel * ones(1, sustainSamples), ...
            linspace(sustainLevel, 0, releaseSamples)];

% 确保包络长度与时间向量长度一致
envelope = envelope(1:length(t));

% 生成合成信号
y = zeros(size(t));
for i = 1:length(harmonics)
    y = y + amplitudes(i) * sin(2*pi*f0*harmonics(i)*t);
end

% 应用包络
y = y .* envelope;

% 归一化音频信号，防止溢出
y = y / max(abs(y));

% 播放合成声音
% 创建 audioplayer 对象并播放声音
    % player = audioplayer(y, fs);
    % playblocking(player); % 阻塞播放，直到当前音频播放完毕
end
% % 绘制波形
% figure;
% plot(t, y);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Synthesized Clarinet Sound');