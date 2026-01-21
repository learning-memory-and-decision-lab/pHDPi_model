
function rgb = colorpalette(colorName)

    % Define color map
    colors = struct( ...
        'lightred',      [0.9294, 0.5294, 0.5294], ...
        'darkred',       [0.8118, 0.0667, 0.0667], ...
        'lightblue',     [0.6902, 0.8235, 0.9098], ...
        'darkblue',      [0, 0.4470, 0.7410], ...
        'lightyellow',   [1.0000, 0.9020, 0.6706], ...
        'darkyellow',    [0.9294, 0.6941, 0.1255], ...
        'lightmagenta',  [0.7882, 0.6706, 0.8118], ...
        'darkmagenta',   [0.4941, 0.1843, 0.5569] ...
    );

    % Convert to lowercase to ensure case-insensitivity
    colorName = lower(colorName);

    if isfield(colors, colorName)
        rgb = colors.(colorName);
    else
        error('Color name "%s" not found.', colorName);
    end
end






