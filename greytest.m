%% GREYTEST
% Examine luminance of signal, noise, and background used in internal
% supervisor experiment. 
% Can redefine luminance settings with up and down arrows

function greytest
%% INIT LUMINANCE SETTINGS

% Controls tracking speed of luminance adjustment (lower is faster)
cut_point = 0.1;

% Proportional back_colour/stim_colour ~~ 32/82 cd/m^2 in Seitz et al.
signal_luminance = 255; % White
noise_luminance = 99; % Grey
background_luminance = 0; % Black

%% NORMALISE KEY FUNCTIONS (ESC TO MOVE ON)

KbName('UnifyKeyNames');
cfg.escape = KbName('ESCAPE');
cfg.lum_up = KbName('UpArrow');
cfg.lum_down = KbName('DownArrow');

%% OPEN SCREEN

% Disable keyboard printing
ListenChar(2);

cfg.screens = Screen('Screens');
window_size = [];

cfg.computer = Screen('Computer');
cfg.version = Screen('Version');

if isunix
    cfg.screen_num = min(cfg.screens); % Attached monitor
else
    cfg.screen_num = max(cfg.screens);
end

% Optional skipsynctest
Screen('Preference', 'SkipSyncTests', 1);

[cfg.win_ptr, cfg.win_rect] = Screen('OpenWindow', ...
    cfg.screen_num, background_luminance, window_size, [], 2);

%% PRESENT WHITE SCREEN (SIGNAL)

init_col = signal_luminance;

while 1
    % Fill screen
    Screen('FillRect', cfg.win_ptr,init_col);
    
    % Print luminance to screen (in black)
    lum_text = mat2str(init_col);
    DrawFormattedText(cfg.win_ptr,lum_text,'left','center',0);
    
    % Flip screen
    Screen('Flip',cfg.win_ptr);
    
    % Check for keypress
    [~,~,keyCode]=KbCheck(-1);
    
    % Act on keypress
    if keyCode(cfg.escape)
        break;
    elseif keyCode(cfg.lum_up)
        init_col = init_col + 1;
        if init_col > 255
            init_col = 255;
        end
        WaitSecs(cut_point);
    elseif keyCode(cfg.lum_down)
        init_col = init_col - 1;
        if init_col < 0
            init_col = 0;
        end
        WaitSecs(cut_point);
    end
end

% Print to command window
fprintf('White luminance is: %d\n', init_col);

WaitSecs(0.5);

%% PRESENT GREY SCREEN (NOISE)
init_col = noise_luminance;

while 1
    % Fill screen
    Screen('FillRect', cfg.win_ptr,init_col);
    
    % Print luminance to screen (in black)
    lum_text = mat2str(init_col);
    DrawFormattedText(cfg.win_ptr,lum_text,'left','center',255);
    
    % Flip screen
    Screen('Flip',cfg.win_ptr);
    
    % Check for keypress
    [~,~,keyCode]=KbCheck(-1);
    
    % Act on keypress
    if keyCode(cfg.escape)
        break;
    elseif keyCode(cfg.lum_up)
        init_col = init_col + 1;
        if init_col > 255
            init_col = 255;
        end
        WaitSecs(cut_point);
    elseif keyCode(cfg.lum_down)
        init_col = init_col - 1;
        if init_col < 0
            init_col = 0;
        end
        WaitSecs(cut_point);
    end
end

% Print to command window
fprintf('Noise luminance is: %d\n', init_col);

WaitSecs(0.5);

%% PRESENT BLACK SCREEN (BACKGROUND)

init_col = background_luminance;

while 1
    % Fill screen
    Screen('FillRect', cfg.win_ptr,init_col);
    
    % Print luminance to screen (in black)
    lum_text = mat2str(init_col);
    DrawFormattedText(cfg.win_ptr,lum_text,'left','center',255);
    
    % Flip screen
    Screen('Flip',cfg.win_ptr);
    
    % Check for keypress
    [~,~,keyCode]=KbCheck(-1);
    
    % Act on keypress
    if keyCode(cfg.escape)
        break;
    elseif keyCode(cfg.lum_up)
        init_col = init_col + 1;
        if init_col > 255
            init_col = 255;
        end
        WaitSecs(cut_point);
    elseif keyCode(cfg.lum_down)
        init_col = init_col - 1;
        if init_col < 0
            init_col = 0;
        end
        WaitSecs(cut_point);
    end
end

% Print to command window
fprintf('Black luminance is: %d\n', init_col);

WaitSecs(0.5);

%% CLOSE WINDOW & RE-ENABLE KEYBOARD

ListenChar(0);
sca;

end