require 'victor'

def grad(deg)
    return deg * Math::PI / 180
end

def main
    dim = 975
    svg = Victor::SVG.new width: dim, height: dim
    scale = 1.5

    center = dim/2.0
    outer_radius = 442.5
    difference = 52.5
    shift = 0
    zodiac_height = 40.0
    term_height = 30

svg.build do

    circle cx: center, cy: center, r: outer_radius, stroke: 'black', fill: 'none', stroke_width: '2px'

    circle cx: center, cy: center, r: outer_radius - difference, stroke: 'black', fill: 'none', stroke_width: '2px'

    circle cx: center, cy: center, r: outer_radius - difference*2, stroke: 'black', fill: 'none', stroke_width: '2px'

    circle cx: center, cy: center, r: outer_radius - difference*3, stroke: 'black', fill: 'none', stroke_width: '2px'

    for i in (0...360).step(30)
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference}, #{center})"
    end

    circle cx: center, cy: center, r: outer_radius - difference*4.5, stroke: 'black', fill: 'none', stroke_width: '2px'

    circle cx: center, cy: center, r: outer_radius - difference*6, stroke: 'black', fill: 'none', stroke_width: '2px'


    for i in (0...180).step(30)
        x11 = (Math.cos(grad(i)) * (center - (outer_radius - difference * 3)) - Math.sin(grad(i)) * (center - 1)).abs
        y11 = (Math.cos(grad(i)) * (center-1) + Math.sin(grad(i)) * (center - (outer_radius - difference * 3))).abs
        x21 = (Math.cos(grad(i)) * (center + (outer_radius - difference * 3)) - Math.sin(grad(i)) * (center + 1)).abs
        y21 = (Math.cos(grad(i)) * (center + 1) + Math.sin(grad(i)) * (center + (outer_radius - difference * 3))).abs

puts "DEG #{i} X1 #{x11}, Y1 #{y11}, X2 #{x21}, Y2 #{y21}"

        if i == 150
        line x1: x11, y1: y11, x2: x21 , y2: y21, stroke: "red", stroke_width: '2'#, stroke_dasharray: '10 5 4'
    else
        line x1: x11, y1: y11, x2: x21 , y2: y21, stroke: "blue", stroke_width: '2'#, stroke_dasharray: '10 5 4'

    end

    end

    # line x1: center - (outer_radius - difference * 3 ), y1: center-1, x2:center + (outer_radius - difference * 3), y2: center+1, stroke: "black", stroke_width: '2', stroke_dasharray: '10 5 4'





    for i in (0...360).step(10) do
        if i % 2 == 0
            rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{i}, #{center}, #{center})     translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*2}, #{center}) "
        else
            rect x: 0, y: 0, width: difference, height: 2, fill: 'red', transform:"rotate(#{i}, #{center}, #{center})     translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*2}, #{center}) "
        end
    end

    #=====================Aries========================

    w = 264 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Aries.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{360-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{360-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sun.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{360-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.95
    w = 75 / (75/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{360-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.95

    for i in [0,6,12,20,25,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+270-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+360-3}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+360-9}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+360-16}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+360-22.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+360-27.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Aries========================

    #=====================Taurus=======================
    w = 240 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Taurus.svg", transform:"translate(#{center+1-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{330-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{330-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.8
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Moon.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{330-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.8

    zodiac_height = zodiac_height * 1.1
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{330-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 1.1


    for i in [0,8,14,22,27,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+240-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+330-4}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+330-11}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+330-18}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+330-24.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+330-28.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Taurus=======================




    #=====================Gemini=======================
    w = 244 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Gemini.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{300-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{300-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{300-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sun.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{300-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    for i in [0,6,12,17,24,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+210-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+300-3}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+300-9}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+300-14.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+300-20.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+300-27}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Gemini=======================

    #=====================Cancer=======================
    w = 300 / (235/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Cancer.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{270-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.95
    w = 75 / (75/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{270-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.95


    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{270-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.8
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Moon.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{270-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.8


    for i in [0,7,13,18,26,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+180-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+270-3.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+270-10}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+270-15.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+270-22}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+270-28}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Cancer=======================

    #=====================Leo=======================
    w = 300 / (400/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Leo.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{240-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 1.1
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{240-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 1.1

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{240-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{240-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"


    for i in [0,6,11,18,24,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+150-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+240-3}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+240-8.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+240-14.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+240-21}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+240-27}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    #=====================Leo=======================

    #=====================Virgo=======================
    w = 207 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Virgo.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{210-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sun.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{210-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.95
    w = 75 / (75/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{210-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.95

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{210-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"


    for i in [0,7,17,21,28,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+120-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+210-3.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+210-12}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+210-19}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+210-24.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+210-29}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1
    #=====================Virgo=======================

    #=====================Libra=======================
    w = 228 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Libra.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{180-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.8
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Moon.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{180-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.8

    zodiac_height = zodiac_height * 1.1
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{180-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 1.1

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{180-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    for i in [0,6,14,21,28,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+90-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+180-3}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+180-10}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+180-17.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+180-24.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+180-29}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    #=====================Libra=======================

    #=====================Scorpio=======================
    w = 51.063829787
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Scorpio.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{150-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{150-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sun.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{150-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.95
    w = 75 / (75/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{150-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.95


    for i in [0,7,11,19,24,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+60-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+150-3.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+150-8.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+150-15}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"


    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+150-21.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+150-27}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1
    #=====================Scorpio=======================

    #=====================Sagittarius=======================
    w = 440 / (440/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sagittarius.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{120-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{120-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.8
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Moon.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{120-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.8

    zodiac_height = zodiac_height * 1.1
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{120-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 1.1

    for i in [0,12,17,21,26,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+30-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+120-6}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+120-14.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+120-19}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+120-23.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+120-28}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Sagittarius=======================


    #=====================Capricorn=======================
    w = 263 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Capricorn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{90-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{90-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{90-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Sun.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{90-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"


    for i in [0,7,14,22,26,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+90-3}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+90-10.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+90-18}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+90-24}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+90-28}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"


    #=====================Capricorn=======================

    #=====================Aquarius=======================
    w = 373 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Aquarius.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{60-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.95
    w = 75 / (75/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{60-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.95

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{60-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 0.8
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Moon.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{60-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 0.8

    for i in [0,7,13,20,25,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+330-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+60-3.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+60-10}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+60-16.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+60-22.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+60-27.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1

    #=====================Aquarius=======================

    #=====================Pisces=======================
    w = 202 / (251/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Pisces.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+(difference-zodiac_height)/2.0}) rotate(#{30-15-shift}, #{w/2.0}, #{outer_radius-(difference-zodiac_height)/2.0})"

    zodiac_height = zodiac_height * 1.1
    w = 50 / (50/(zodiac_height))
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{30-5-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"
    zodiac_height = zodiac_height / 1.1

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{30-15-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    w = 50 / (50/zodiac_height)
    image x: 0, y: 0, width: w, height: zodiac_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference+(difference-zodiac_height)/2.0}) rotate(#{30-25-shift}, #{w/2.0}, #{outer_radius-difference-(difference-zodiac_height)/2.0})"

    for i in [0,12,16,19,28,30] do
        rect x: 0, y: 0, width: difference, height: 2, fill: 'black', transform:"rotate(#{shift+300-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
    end

    term_height = term_height * 0.95
    w = 75 / (75/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Venus.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+30-6}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 0.95

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Jupiter.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+30-14}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mercury.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+30-17.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"


    w = 50 / (50/term_height)
    image x: 0, y: 0, width: w, height: term_height, href:"Mars.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+30-23.5}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"

    term_height = term_height * 1.1
    w = 50 / (50/(term_height))
    image x: 0, y: 0, width: w, height: term_height, href:"Saturn.svg", transform:"translate(#{center-w/2.0}, #{center-outer_radius+difference*2+(difference-term_height)/2.0}) rotate(#{shift+30-29}, #{w/2.0}, #{outer_radius-difference*2-(difference-term_height)/2.0})"
    term_height = term_height / 1.1
    #=====================Pisces=======================

end

svg.save 'pacman'

end

main
