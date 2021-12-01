require_relative '../../../2019/18/part1.rb'

RSpec.describe '2019/18/Part1' do
    it 'works for example 1' do
        input = <<-EOF.chomp.lines.map {|line| line.chars}
#########
#b.A.@.a#
#########
EOF
        expected = 8
    end

    it 'works for example 2' do
        input = <<-EOF.chomp.lines.map {|line| line.chars}
########################
#f.D.E.e.C.b.A.@.a.B.c.#
######################.#
#d.....................#
########################
EOF
        expected = 86
    end

    it 'works for example 3' do
        input = <<-EOF.chomp.lines.map {|line| line.chars}
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################
EOF
        expected = 132
    end

    it 'works for example 4' do
        input = <<-EOF.chomp.lines.map {|line| line.chars}
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
EOF
        expected = 136
    end

    it 'works for example 5' do
        input = <<-EOF.chomp.lines.map {|line| line.chars}
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################
EOF
        expected = 81
    end
end
