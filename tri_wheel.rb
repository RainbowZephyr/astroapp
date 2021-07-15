require 'victor'
require 'daru'

$df = nil
$planets = []
$signs = ["ari", "tau", "gem", "can", "leo", "vir", "lib", "sco", "sag", "cap", "aqu", "pis"]

$natal = {}
$progressed = {}
$transit = {}

$bounds = {}

def grad(deg)
    return deg * Math::PI / 180
end

def degree(sign, deg)
    return ($signs.find_index {|s| s == sign }*30+deg)
end

def bounds(sign, radius, x, y, dimension, shift)
    return shift + 360 - sign * 30

end

def coordinates(angle, radius)
    x = Math.sqrt((radius**2).to_f/(1+(Math.tan(grad(angle)))**2))
    y = Math.sqrt( radius**2.to_f - x**2 )
    return [x,y]
end

def read_placements(file)
    $df = Daru::DataFrame.from_csv file
    $planets = $df["planets"].to_a
    $df.set_index "planets"

    for p in $planets
        planet = p
        if $df["rx_1"][p] == 1
            planet += "_rx"

        end



        if $natal.key?  $df["natal_sign"][p]
            $natal[$df["natal_sign"][p]] << {planet => $df["natal_degree"][p]}
        else
            $natal[$df["natal_sign"][p]] = [{planet => $df["natal_degree"][p]}]
        end

        planet = p
        if $df["rx_2"][p] == 1
            planet += "_rx"
        end

        if $df.vectors.to_a.include? "progressed_sign"
            if $progressed.key?  $df["progressed_sign"][p]
                $progressed[$df["progressed_sign"][p]] << {planet => $df["progressed_degree"][p]}
            else
                $progressed[$df["progressed_sign"][p]] = [{planet => $df["progressed_degree"][p]}]
            end
        end

        planet = p
        if $df["rx_3"][p] == 1
            planet += "_rx"
        end

        if $df.vectors.to_a.include? "transit_sign"
            if $transit.key?  $df["transit_sign"][p]
                $transit[$df["transit_sign"][p]] << {planet => $df["transit_degree"][p]}
            else
                $transit[$df["transit_sign"][p]] = [{planet => $df["transit_degree"][p]}]
            end
        end
    end

    # puts $progressed

    # puts $transit

end

def main(file)
    dim = 975
    svg = Victor::SVG.new width: dim, height: dim
    scale = 1.5

    center = dim/2.0
    outer_radius = 442.5
    difference = 40.0
    shift = 240
    zodiac_height = 30.0
    term_height = 20.0
    dash_markers_width = 4

    svg.build do
        rect x: 0, y: 0, width: dim, height: dim, fill: '#151414'

        text "Britney Spears", x: 20, y: 40, font_weight: "bold", font_family: 'hasklig', font_size: term_height, fill: '#cfcfcf'


        text "Natal (Inner)", x: dim - 150, y: 40, font_weight: "bold", font_family: 'hasklig', font_size: term_height, fill: '#cfcfcf'
        text "2/12/1981 1:30am", x: dim-174, y: 60, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'
        text "McComb MS, USA", x: dim-174, y: 80, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'


        text "Progressed (Middle)", x: dim-220, y: dim-40, font_weight: "bold", font_family: 'hasklig', font_size: term_height, fill: '#cfcfcf'
        text "30/6/2021 5:00pm", x: dim-175, y: dim-60, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'
        text "McComb MS, USA", x: dim-174, y: dim-80, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'


        text "Transits (Outer)", x: 20, y: dim-40, font_weight: "bold", font_family: 'hasklig', font_size: term_height, fill: '#cfcfcf'
        text "30/6/2021 2:00pm", x: 20, y: dim-60, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'
        text "Los Angeles CA, USA", x: 20, y: dim-80, font_family: 'hasklig', font_size: term_height*0.9, fill: '#cfcfcf'

        #Outer circles
        circle cx: center, cy: center, r: outer_radius, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        circle cx: center, cy: center, r: outer_radius - difference, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        circle cx: center, cy: center, r: outer_radius - difference*2, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        circle cx: center, cy: center, r: outer_radius - difference*3, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        # Markers
        for i in (0...360).step(2)
            rect x: 0, y: 0, width: dash_markers_width , height: 2, fill: '#CC6D51', transform:"rotate(#{i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3 - dash_markers_width}, #{center})"
        end


        # for i in (0...360).step(30)
        #     rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference}, #{center})"
        # end

        # Inner circles
        circle cx: center, cy: center, r: outer_radius - difference*4.75, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        circle cx: center, cy: center, r: outer_radius - difference*6.75, stroke: '#CC6D51', fill: 'none', stroke_width: '2px'

        #Houses
        line_width = (center + (outer_radius - difference * 3)) - (center - (outer_radius - difference * 3))

        for i in (0...360).step(30)
            line x1: center - (outer_radius - difference * 3), y1: center-1, x2: center, y2: center, stroke: "#3B3A39", stroke_width: '2', stroke_dasharray: '10 5 4', transform: "rotate(#{i}, #{center}, #{center})"

        end

        #Decans
        for i in (0...360).step(10) do
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{i}, #{center}, #{center})     translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*2}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+270-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+240-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+210-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+180-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+150-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+120-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+90-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+60-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+30-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+330-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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
            rect x: 0, y: 0, width: difference, height: 2, fill: '#CC6D51', transform:"rotate(#{shift+300-i}, #{center}, #{center}) translate(#{(outer_radius*2)+(dim-outer_radius*2)/2.0 - difference*3}, #{center}) "
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

        read_placements file
        w = 50 / (50/term_height)
        factors = [7.25, 5.25,3.5]
        factor_counter=0
        placements = [$natal, $progressed, $transit]
        for h in placements
            factor = 7.25
            for sign, planets in h
                planets.sort! {|h1, h2| h1.values <=> h2.values}

                lift = false
                # consequetive_difference_counter = 0
                #
                # for p in 0...planets.length-1
                #     if planets[p+1].values[0] - planets[p].values[0] < 6
                #         consequetive_difference_counter += 1
                #     end
                # end



                for p in 0...planets.length

                    angle = 270-degree(sign, planets[p].values[0])-shift

                    if angle < 0
                        angle = angle + 360
                    end

                    if angle % 90 == 0
                        angle += 1

                    end

                    xc,yc = coordinates(angle, outer_radius-difference*factors[factor_counter])
                    txc,tyc = coordinates(angle, outer_radius-difference*(factors[factor_counter]+0.45))
                    puts "P #{planets[p]} angle #{angle} radius #{outer_radius-difference*7} coord #{[xc,yc]}"



                    if (p < planets.length-1 && planets.length > 1 && planets[p+1].values[0] - planets[p].values[0] < 5)
                        if lift || planets.length - p == 2
                            xc,yc = coordinates(angle, outer_radius-difference*(factors[factor_counter]+1.05))
                            txc,tyc = coordinates(angle, outer_radius-difference*(factors[factor_counter]+1.5))
                        end
                        lift = !lift
                        puts "@@@@@@@@@@@@@@@@@@@@@@@@ #{planets} P #{p}"
                    end

                    if angle > 0 && angle <= 90


                        text "#{planets[p].values[0]}°", x: center+txc-term_height*0.3, y: center+tyc, font_weight: "bold", font_family: 'hasklig', font_size: term_height*0.6, fill: '#cfcfcf'

                        image x: center+xc-w/2, y:  center+yc-term_height/2, width: w, height: term_height, href:"#{planets[p].keys[0]}.svg"
                    elsif angle > 90 && angle <= 180

                        text "#{planets[p].values[0]}°", x: center-txc-term_height*0.3, y: center+tyc, font_weight: "bold", font_family: 'hasklig', font_size: term_height*0.6, fill: '#cfcfcf'

                        image x: center-xc-w/2, y:  center+yc-term_height/2, width: w, height: term_height, href:"#{planets[p].keys[0]}.svg"
                    elsif angle > 180 && angle <= 270

                        text "#{planets[p].values[0]}°", x: center-txc-term_height*0.3, y: center-tyc, font_weight: "bold", font_family: 'hasklig', font_size: term_height*0.6, fill: '#cfcfcf'

                        image x: center-xc-w/2, y:  center-yc-term_height/2, width: w, height: term_height, href:"#{planets[p].keys[0]}.svg"
                    elsif angle > 270 && angle <= 360
                        text "#{planets[p].values[0]}°", x: center+txc, y: center-tyc+term_height*0.3, font_weight: "bold", font_family: 'hasklig', font_size: term_height*0.6, fill: '#cfcfcf'

                        image x: center+xc-w/2, y:  center-yc-term_height/2, width: w, height: term_height, href:"#{planets[p].keys[0]}.svg"
                    end

                end

            end
            if factor_counter < factors.length-1
                factor_counter += 1
            end
            puts "========================\n"
        end
        svg.save "#{file[0..-5]}"

    end
end

main ARGV[0]
