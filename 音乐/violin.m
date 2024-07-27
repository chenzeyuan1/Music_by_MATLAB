function y = violin(pitch,time)
% 基本参数
fs = 44100; % 采样率
duration = time; % 持续时间（秒）
t = linspace(0, duration, fs * duration); % 时间向量

% 基本频率（A4音符，440 Hz）
f0 = pitch/(2*pi);

% 谐波频率和幅度（简化的示例）
harmonics = [1, 0.8, 0.6, 0.4, 0.2]; % 谐波幅度
frequencies = f0 * (1:length(harmonics)); % 谐波频率

% 生成谐波并叠加
violin_sound = zeros(size(t));
for k = 1:length(harmonics)
    violin_sound = violin_sound + harmonics(k) * sin(2 * pi * frequencies(k) * t);
end

% 归一化
y = violin_sound / max(abs(violin_sound));

% 播放声音
% 创建 audioplayer 对象并播放声音
    % player = audioplayer(y, fs);
    % playblocking(player); % 阻塞播放，直到当前音频播放完毕
end