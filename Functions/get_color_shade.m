
function[c_dark, c_light] = get_color_shade(color_id)


if color_id ==1
    
    c_dark = 1/255 .* [202, 201, 37];
    c_light = 1/255 .* [112, 111, 21];

elseif color_id ==2
    c_light = 1/255 .* [174, 175, 194];
    c_dark = 1/255 .* [41, 41, 110];

elseif color_id ==3

    c_light = 1/255 .* [181, 228, 140];
    c_dark = 1/255 .* [82, 182, 154];

elseif color_id ==4

    c_light = 1/255 .* [255, 155, 84];
    c_dark = 1/255 .* [255, 127, 81];

elseif color_id ==5

    c_dark = 1/255 .* [56, 102, 65];
    c_light = 1/255 .* [106, 153, 78];

elseif color_id ==6

    c_dark = 1/255 .* [114, 0, 38];
    c_light = 1/255 .* [196, 69, 54];

end
